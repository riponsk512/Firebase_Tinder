//
//  ChatVC.swift
//  Firebase_Tinder
//
//  Created by Ripon sk on 20/11/22.
//

import UIKit
import FirebaseDatabase
class ChatVC: UIViewController {
    var em:String?
    @IBOutlet weak var tv: UITableView!
    var arrmodel = [UserProfile]()
    let db = Database.database().reference().child("UserProfile")
    override func viewDidLoad() {
        super.viewDidLoad()
getData()
        // Do any additional setup after loading the view.
    }
    func getData(){
        db.observe(.childAdded) { snap,_  in
            let val = snap.value as? Dictionary<String,String>
            var model = UserProfile()
            model.firstName = val!["First Name"] as? String
            model.lastName = val!["Last Name"] as? String
            model.firstName = val!["First Name"] as? String
            model.Profileimage = val!["Profileimage"] as? String
            self.em = val!["Email Id"] as? String
            self.arrmodel.append(model)
            self.tv.reloadData()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension ChatVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if em == "riponsk123@mail.com"{
            return arrmodel.count
        }
        else{return 1}
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ChatTVC
        if em == "riponsk123@mail.com"{
        let arr = arrmodel[indexPath.row]
        // cell?.lblEmail.text = arr.emailId
        cell?.lblFirstName.text = arr.firstName
        cell?.lblLastName.text = arr.lastName
            DispatchQueue.main.async{
                let data = try! Data(contentsOf: URL(string: arr.Profileimage ?? "")!)
                
                cell?.profile.image = UIImage(data: data)
            }
    }
            return cell!
        
        
        
    }
}
