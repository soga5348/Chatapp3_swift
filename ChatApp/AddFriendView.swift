//
//  AddFriendView.swift
//  ChatApp
//
//  Created by soga syunto on 2023/11/26.
//

import UIKit

func makeQRCode(text: String) -> UIImage? {
    guard let data = text.data(using: .utf8) else { return nil }
    let qr = CIFilter(name: "CIQRCodeGenerator", parameters: ["inputMessage": data, "inputCorrectionLevel": "H"])!
    return UIImage(ciImage: qr.outputImage!)
}



class AddFriendView: UIViewController {
    
    @IBOutlet weak var idField: UITextField!
    @IBOutlet weak var qrView: UIImageView!
    @IBOutlet var idLabel: UILabel!
    
    let uid = AuthHelper().uid()
        let database = DatabaseHelper()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            idLabel.text = "MyID:\(uid)"
            qrView.image = makeQRCode(text: uid)
        }
    
    @IBAction func onSearch(_ sender: Any) {
        conform(id: idField.text!)
    }
    
    @IBAction func onCopy(_ sender: Any) {
        UIPasteboard.general.string = uid
    }
    func showError(message: String) {
        let dialog = UIAlertController(title: "エラー", message: message, preferredStyle: .alert)
        dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(dialog, animated: true, completion: nil)
    }

    
    func conform(id:String){
        database.getUserInfo(userID: id, result: {
            result in
            if result == "" {
                self.showError(message: "存在しないidです。")
            } else {
                self.performSegue(withIdentifier: "conform", sender: UserData(id: id, name: result))
            }
        })
    
        
         func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "conform"{
                let vc = segue.destination as! FriendConformView
                let data = sender as! UserData
                vc.userID = data.id
                vc.name = data.name
            }
            if segue.identifier == "conform"{
                   let vc = segue.destination as! FriendConformView
                   let data = sender as! UserData
                   vc.userID = data.id
                   vc.name = data.name
               }
               if segue.identifier == "qr"{
                   let vc = segue.destination as! QRScanner
                   vc.qrScaned = {
                       id in
                       self.conform(id: id)
                   }
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
    
    
    class FriendConformView:UIViewController {
        
        @IBOutlet weak var nameLabel: UILabel!
        
        @IBOutlet weak var imageView: UIImageView!
        
        var userID = ""
        var name = ""
        
        var database = DatabaseHelper()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            nameLabel.text = name
            database.getImage(userID: userID, imageView: imageView)
            imageView.layer.cornerRadius = imageView.frame.size.height * 0.5
            imageView.clipsToBounds = true
        }
        
        @IBAction func onAdd(_ sender: Any) {
            database.createRoom(userID: userID)
            dismiss(animated: true, completion: nil)
        }
        @IBAction func onCancel(_ sender: Any) {
            dismiss(animated: true, completion: nil)
        }
    }
}

struct UserData{
    let id:String
    let name:String
}
