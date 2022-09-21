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
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //authenticateUserByFace()
        let auth = AuthenticateUser()
        auth.authenticateUserByPasscode()
    }
    
    
    

}

