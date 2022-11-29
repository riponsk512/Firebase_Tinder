//
//  SignUpVC.swift
//  Firebase_Tinder
//
//  Created by Ripon sk on 16/11/22.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
class SignUpVC: UIViewController {
    
    
    @IBOutlet weak var tfLastName: UITextField!
    @IBOutlet weak var tffirstName: UITextField!
    @IBOutlet weak var imgUser: UIImageView!
    var images:UIImage? = nil
    @IBOutlet weak var tfPswd: UITextField!
    
    @IBOutlet weak var tfEmail: UITextField!
    let db = Database.database().reference().child("UserProfile")
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(dissmissKeyBoard))
        self.view.addGestureRecognizer(tapGes)
        imgUser.layer.borderWidth = 1.0
        imgUser.layer.cornerRadius = 20
        imgUser.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(opencamera))
        imgUser.addGestureRecognizer(gesture)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tapSignUp(_ sender: Any) {
        Auth.auth().createUser(withEmail: tfEmail.text!, password: tfPswd.text!) { [self] res, err in
            if err != nil{
                print("error is:\(err?.localizedDescription)")
                return
                
    //
//                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                   // self.navigationController?.popToRootViewController(animated: true)
            }
            guard let img = images else
            {
                print("images is nil")
                return
                
            }
            guard let imgData = img.jpegData(compressionQuality: 0.4) else{return}

            if let authRes = res{
                print(authRes.user.email)
               // let model = UserProfile(Uid: authRes.user.uid,firstName: tffirstName.text!,lastName: tfLastName.text,emailId: authRes.user.email,Profileimage: "",status: "")
              
                let storegeRef = Storage.storage().reference(forURL: "gs://fir-tinder-d0579.appspot.com/Profile")
                let storegeProfileRef = storegeRef.child("ProfileImage").child(authRes.user.uid)
                let storegeMetaData = StorageMetadata()
                storegeMetaData.contentType = "image/jpg"
                storegeProfileRef.putData(imgData) { storegeMetaData, err in
                    if err != nil{
                        print("uploading Data error is:\(err?.localizedDescription)")
                    }
                    storegeProfileRef.downloadURL { url, err in
                        guard  err == nil, let urls = url else{
                            return
                        }
                        print("url is:\(urls)")
                        
                       // dict["Profileimage"] = urls
                        var dict:[String:Any] = ["Uid":authRes.user.uid,"First Name":tffirstName.text!,"Last Name":tfLastName.text!,"Email Id":authRes.user.email,"Profileimage":"\(urls)","status":""]
                   //     DispatchQueue.main.async {
                            db.child(authRes.user.uid).updateChildValues(dict) { err, ref in
                                if err != nil {
                                    print("adding data to server err is:\(err?.localizedDescription)")
                                }
                            }
//                        }

                        
                    }
                   
                }
              
                
                
                }
                
                
            }
           
           
            self.navigationController?.popToRootViewController(animated: true)
           // print("print:\(res?.credential!.provider)")
        }
        
    
 @objc func opencamera(){
        let imgPicker = UIImagePickerController()
                imgPicker.delegate = self
                imgPicker.allowsEditing = true
                imgPicker.sourceType = .photoLibrary
                self.present(imgPicker, animated: true)
    }


}
extension SignUpVC:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            images = img
            self.imgUser.image = img
            self.dismiss(animated: true)
        }
    }
  @objc func dissmissKeyBoard(){
      self.view.endEditing(true)
    }
}
