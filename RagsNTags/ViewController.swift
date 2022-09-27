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
import FirebaseStorage
import FirebaseDatabase
import AlertsAndNotifications

public var emailIDUser: String?
public var nameUser: String?

//MARK: class KeyChainManager for storing login credentials in keychain
class KeyChainManager{
    
    static func save( email: String,  password: Data) -> Bool{
    
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecValueData as String: password as AnyObject,
            kSecAttrAccount as String: email as AnyObject,
            
        ]
        if SecItemAdd(query as CFDictionary, nil) == noErr {
            print("User saved successfully in the keychain")
            return true
        } else {
            print("Something went wrong trying to save the user in the keychain")
            return false
        }
    }
    
}//END of KeyChainManager class

//MARK: class CoreDaataFetch to fetch the data store in UserRegisterData
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
                    fetName = data.name!
                    break
                }//End of if
            }//END for
        }//END do
        catch{
            print("error occured while fetching name")
        }
        
        if (flag == 1){
            return fetName
        }
        else{
            return " "
        }
    }//END of function fetchname
    
    func fetchData(email: String) -> UserRegisterData? {
        
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        var fetData: UserRegisterData?
        let fetchReq : NSFetchRequest<UserRegisterData> = UserRegisterData.fetchRequest()
        fetchReq.returnsObjectsAsFaults = false
        let predicate = NSPredicate(format: "email == %@", email)
        fetchReq.predicate = predicate
        do{
            let userDataArray = try context.fetch(fetchReq)
            for i in 0..<userDataArray.count{
                fetData = userDataArray[i]
            }
        } catch(let error){
            print(error.localizedDescription)
        }
        
            return fetData
    }//END of func fetchData
    
}//End of class CoreDataFetch

//MARK: class AuthenticateUser to authenticate user credential
class AuthenticateUser{
    
    //Face ID Authentication
    func authenticateUserByFace(){
        let context = LAContext()
        var authError: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError){
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Authenticate to access app") { success, error in
                DispatchQueue.main.async{
                    if success{
                        print("Successfully Local Authenticated")
                    }else{
                        print("Failed Local Authentication")
                    }
                }//End of dispatch
            }//END of evaluatePolicy
        }//End of if
    }//End of func
    
    //Passcode Authentication
    func authenticateUserByPasscode(){
        let context = LAContext()
        var authError: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &authError){
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "Authenticate to access app")
            { success, error in
                DispatchQueue.main.async{
                    if success{
                        print("Successfully Authenticated")
                    }else{
                        print("Failed")
                    }
                }//End of dispatch
            }//END of evaluatePolicy
        }//End of if
    }//End of func
    
}//End of AuthenticateUser class


class AuthenticateUserFromFirebase: UIViewController{
    
    func logninUserFromFirebase(emailId: String, password: String) -> Bool{
        var flag = 0
        
        Auth.auth().signIn(withEmail: emailId, password: password) { result, error in
            if let _error = error{
                flag = 1
                print(_error.localizedDescription)
            }
            else{
                flag = 0
                print("User registered")
            }
        }
        
        print(flag)
        if(flag == 0 ){
            return true
        }
        else{
            return false
        }
    }
    
}//End of class AuthenticateUserFromFirbase

public class Logout: UIViewController{
    public func logoutClicked(){
        let log = (self.storyboard?.instantiateViewController(withIdentifier: "loginVC")) as! ViewController 
        self.navigationController?.pushViewController(log, animated: true)
    }
}



class ViewController: UIViewController {
    
    
    //MARK: IBOutlet on ViewController (Login page)
    @IBOutlet weak var emailTxtFld: UITextField!
    @IBOutlet weak var passwordTxtFld: UITextField!
    @IBOutlet weak var logoImg: UIImageView!
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //authenticateUserByFace()
        navigationItem.hidesBackButton = true
        
        //call animation
        //animateLogo()
    }
    
    //MARK: function animate logo image
    func animateLogo(){
        UIView.animate(withDuration: 2,
            animations: {
            /*CGAffineTransform Structure used to rotate, scale, translate, or skew the objects
            transform property to scale or rotate*/
            self.logoImg.transform = CGAffineTransform(scaleX: 0, y: 0)
            },
            completion: { _ in
            UIView.animate(withDuration: 3) {
                    self.logoImg.transform = CGAffineTransform.identity
                }
            })
    }// End of animateLogo function
    
    //MARK: function to authenticate user from firebase
    func logninUserFromFirebase(emailId: String, password: String) -> Bool{
        var flag = 0
        
        Auth.auth().signIn(withEmail: emailId, password: password) { [self] result, error in
            if let _error = error{
                invalidCredentials()
                flag = 1
                print(_error.localizedDescription)
                
            }else{
                flag = 0
                print("User registered")
                do{
                    try KeyChainManager.save(email: emailId, password: Data(password.utf8))
                }
                catch{
                    print("Key chain error\(error)")
                }
                let dash = self.storyboard?.instantiateViewController(withIdentifier: "dash") as! DashboardViewController
                let fetchname = CoreDataFetch()
                nameUser = fetchname.fetchname(email: emailId)
                dash.name = nameUser!
                self.navigationController?.pushViewController(dash, animated: true)
            }
        }
        
        print(flag)
        if(flag == 0){
            return true
        }else{
            return false
        }
    }//END of func
    
    
    
    //MARK: Login button action to validate user from fire base
    @IBAction func enterButtonIsClicked(_ sender: Any) {
        
        let email: String = emailTxtFld.text!
        let password: String = passwordTxtFld.text!
        emailIDUser = email
        
        //Call function to authenticate from firebase
        print(logninUserFromFirebase(emailId: email, password: password))
        
    }//END of func enterButtonClicked
    
    
    //MARK: click here! button is clicked
    @IBAction func moveToRegistration(_ sender: Any) {
        let registration = (self.storyboard?.instantiateViewController(withIdentifier: "registerVC"))!
        self.navigationController?.pushViewController(registration, animated: true)
    }//END of IBAction
    
    
    //MARK: Validation in Login
    func invalidCredentials(){
        print("Alert")
            let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
             // Respond to user selection of the action.
            }
            
            // Create and configure the alert controller.
            let alert = UIAlertController(title: "Invalid Credentials",
                  message: "Please provide valid credentials or register for new account.",
                  preferredStyle: .alert)
            alert.addAction(cancelAction)
            
                 
            self.present(alert, animated: true) {
               // The alert was presented
            }
    }//END of func invalidCredentials
    
}//End of class ViewController


