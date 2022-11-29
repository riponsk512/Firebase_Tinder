//
//  ViewController.swift
//  Firebase_Tinder
//
//  Created by Ripon sk on 16/11/22.
//

import UIKit
import FirebaseAuth
class ViewController: UIViewController {
    
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func moveToSignUp(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func loginTap(_ sender: Any) {
        Auth.auth().signIn(withEmail: tfEmail.text!, password: tfPassword.text!) { (user, error) in
            if(error != nil){
                debugPrint(error)
               // self.showAlert(error?.localizedDescription ?? "")
            }else{
                  
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChatVC") as! ChatVC
                
                           self.navigationController?.pushViewController(vc, animated: true)
            }
        }
//        Auth.auth().signIn(withEmail: tfEmail.text!, password: tfPassword.text!){err,user in
//            if err != nil{
//                print("erros:\(err.loc)")
//            }else{
//                //riponsk123@mail.com
//                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChatVC") as! ChatVC
//                self.navigationController?.pushViewController(vc, animated: true)
//            }
//
//        }
    }
    
    

}

