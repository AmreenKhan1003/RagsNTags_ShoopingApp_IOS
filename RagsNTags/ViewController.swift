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
    
    func fetchData(email: String) -> UserRegisterData {
        /*
        var fetData: UserRegisterData?
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
                    fetData = data
                    break
                    //print(tomatchemail)
                }//end of if
            }//end for
        }//end do
        catch{
            print("error occured while fetching name")
        }
        
        if (flag == 1){
            return fetData!
        }
        else{
            return fetData!
            
        }
    }
         */
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
        return fetData!
        
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
        
        
                navigationItem.hidesBackButton = true
        
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
    
    //MARK: function to authenticate user from firebase
    func logninUserFromFirebase(emailId: String, password: String) -> Bool{
        var flag = 0
        
        Auth.auth().signIn(withEmail: emailId, password: password) { [self] result, error in
            if let _error = error{
                //self.alerts.invalidCredentials()
                invalidCredentials()
                flag = 1
                print(_error.localizedDescription)
                
            }
            else{
                flag = 0
                print("User registered")
                let dash = self.storyboard?.instantiateViewController(withIdentifier: "dash") as! DashboardViewController
                let fetchname = CoreDataFetch()
                nameUser = fetchname.fetchname(email: emailId)
                dash.name = nameUser!
                self.navigationController?.pushViewController(dash, animated: true)
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
    
    
    
    //MARK: Login button action to validate user from fire base
    @IBAction func enterButtonIsClicked(_ sender: Any) {
        
        let email: String = emailTxtFld.text!
        let password: String = passwordTxtFld.text!
        
        emailIDUser = email
        
        //Call function to authenticate from firebase
        print(logninUserFromFirebase(emailId: email, password: password))
        
    }//end of func enterButtonClicked
    
    //MARK: click here! button is clicked
    
    @IBAction func moveToRegistration(_ sender: Any) {
        let registration = (self.storyboard?.instantiateViewController(withIdentifier: "registerVC"))!
        self.navigationController?.pushViewController(registration, animated: true)
    }
    
    
    //MARK: Validation in Login
    func invalidCredentials(){
        print("Alert")
       
            let cancelAction = UIAlertAction(title: "OK",
                                             style: .cancel) { (action) in
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
           
    }
}


