//
//  ViewController.swift
//  RagsNTags
//
//  Created by Capgemini-DA322 on 9/20/22.
//

import UIKit
import LocalAuthentication

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



class ViewController: UIViewController {

    @IBOutlet weak var logoImg: UIImageView!
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
    }
    

}

