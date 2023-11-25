//
//  LoginView.swift
//  ChatApp
//
//  Created by soga syunto on 2023/11/25.
//

import UIKit

class LoginView: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            if AuthHelper().uid() != "" {
                dismiss(animated: false, completion: nil)
            }
        }
    
    
    @IBAction func onLogin(_ sender: Any) {
        AuthHelper().login(email: emailField.text!, password: passwordField.text!, result: {
            success in
            if success {
                self.dismiss(animated: true, completion: nil)
                print("ログイン成功")
            } else {
                self.showError()
            }
        })
    }
    
        
        func showError(){
                let dialog = UIAlertController(title: "エラー", message: "メールアドレス、またはパスワードが間違っています。", preferredStyle: .alert)
                dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(dialog, animated: true, completion: nil)
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


