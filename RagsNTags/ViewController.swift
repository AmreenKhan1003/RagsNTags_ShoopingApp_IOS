//
//  ViewController.swift
//  RagsNTags
//
//  Created by Capgemini-DA322 on 9/20/22.
//

import UIKit
import LocalAuthentication
import FirebaseAuth
import CoreData

class CoreDataFetch{
    
    func fetchname(email: String) -> String {
        var fetName: String = " "
        var flag = 0
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        do{
            let edata = try context.fetch(UserRegisterData.fetchRequest()) as! [UserRegisterData]
            
            for data in edata{
                let tomatchemail = data.email
                if(tomatchemail == email ){
                    flag = 1
                    //callAlert(titles: "Email Already Exist")
                    fetName = data.name!
                    break
                    //print(tomatchemail)
                }//end of if
            }//end for
        }//end do
        catch{
            print("error occured while fetching name")
        }
        
        if (flag == 1){
            return fetName
        }
        else{
            return " "
            
        }
    }
}

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
    
    func logninUserFromFirebase(emailId: String, password: String) -> Bool{
        var flag = 0
        Auth.auth().signIn(withEmail: emailId, password: password){ result, error in
            if let _error = error{
                flag = 1
                print("Cant enter data in firebase \(_error.localizedDescription)")
            }
            else{
                print("user logged in success fully")
            }
            
        }
        if(flag == 1 ){
            return false
        }
        else{
            return true
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
        if(authuser.logninUserFromFirebase(emailId: email, password: password)){
            //call alert
            let dash = self.storyboard?.instantiateViewController(withIdentifier: "dash") as! DashboardViewController
            let fetchname = CoreDataFetch()
            let name = fetchname.fetchname(email: email)
            dash.name = name
            self.navigationController?.pushViewController(dash, animated: true)
            
        }
    }//end of func enterButtonClicked
    
    //MARK: click here! button is clicked
    
    @IBAction func moveToRegistration(_ sender: Any) {
        let registration = (self.storyboard?.instantiateViewController(withIdentifier: "registerVC"))!
        self.navigationController?.pushViewController(registration, animated: true)
    }
    

}


