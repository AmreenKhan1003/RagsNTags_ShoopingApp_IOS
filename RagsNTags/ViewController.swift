//
//  ViewController.swift
//  RagsNTags
//
//  Created by Capgemini-DA322 on 9/20/22.
//

import UIKit
import LocalAuthentication
import FirebaseAuth

class AuthenticateUser{
    //MARK: Face ID Authentication
    func authenticateUserByFace(){
        let context = LAContext()
        var authError: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError){
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Authenticate to access app") { success, error in
                DispatchQueue.main.async{
                    if success{
                        //callAlert
                        print("Successfully Authenticated")
                    }
                    else{
                        //call alert
                        print("Failed")
                    }
                }//End of dispatch
            }
        }//End of if
    }//End of func
    //MARK: Passcode Authentication
    func authenticateUserByPasscode(){
        let context = LAContext()
        var authError: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &authError){
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "Authenticate to access app") { success, error in
                DispatchQueue.main.async{
                    if success{
                        //callAlert
                        print("Successfully Authenticated")
                    }
                    else{
                        //call alert
                        print("Failed")
                    }
                }//End of dispatch
            }
        }//End of if
    }//End of func
}//End of AuthenticateUser class

class AuthenticateUserFromFirebase: UIViewController{
    
    func loginUserFromFirebase(emailId: String, password: String){
        Auth.auth().signIn(withEmail: emailId, password: password) { result, error in
            if let _error = error{
                print(_error.localizedDescription)
                //call alert
            }
            else{
                print("user logged in successfully")
                let dash = self.storyboard?.instantiateViewController(withIdentifier: "dashVC")
                self.navigationController?.pushViewController(dash!, animated: true)
            }
        }
    }
}//End of class AuthenticateUserFromFirbase




class ViewController: UIViewController {
    
    //MARK: IBOutlet on ViewController (Login page)
    @IBOutlet weak var emailTxtFld: UITextField!
    @IBOutlet weak var passwordTxtFld: UITextField!
    @IBOutlet weak var logoImg: UIImageView!
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //authenticateUserByFace()
        let auth = AuthenticateUser()
        auth.authenticateUserByPasscode()
        
        //call animation
        animateLogo()
    }
    
    //MARK: function animate logo image
    func animateLogo(){
        UIView.animate(withDuration: 2,
            animations: {
            //CGAffineTransform Structure used to rotate, scale, translate, or skew the objects
            //transform property to scale or rotate
            self.logoImg.transform = CGAffineTransform(scaleX: 0, y: 0)
            },
            completion: { _ in
            UIView.animate(withDuration: 3) {
                    self.logoImg.transform = CGAffineTransform.identity
                }
            })
    }// End of animateLogo function
    
    //MARK: Login button action to validate user from fire base
    @IBAction func enterButtonIsClicked(_ sender: Any) {
        let email: String = emailTxtFld.text!
        let password: String = passwordTxtFld.text!
        
        //Call function to authenticate from firebase
        let authuser = AuthenticateUserFromFirebase()
        authuser.loginUserFromFirebase(emailId: email, password: password)
    }
    

}

