//
//  CreateAccountView.swift
//  ChatApp
//
//  Created by soga syunto on 2023/11/25.
//

import UIKit

class CreateAccountView :UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onImage)))
        
        
        // Do any additional setup after loading the view.
    }
    
    @objc func onImage(){
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.mediaTypes = ["public.image"]
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        imageView.image = image
        dismiss(animated: true, completion: nil)
    }
    
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    
    @IBAction func onRegister(_ sender: Any) {
        let name = nameField.text!
        if name.count < 3 || name.count > 10 {
            showError(message: "名前は3字以上10字以内で設定してください。")
            return
        } else{
            AuthHelper().createAccount(email: emailField.text!, password: passwordField.text!, result: {
                success in
                if success {
                    self.dismiss(animated: true, completion: nil)
                } else {
                    self.showError(message: "有効なメールアドレス、6文字以上のパスワードを設定してください。")
                }
            })
        }
    }
    
    @IBAction func onBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func showError(message:String){
            let dialog = UIAlertController(title: "エラー", message: message, preferredStyle: .alert)
            dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(dialog, animated: true, completion: nil)
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
