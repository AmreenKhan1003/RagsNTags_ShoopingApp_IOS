//
//  RegisterViewController.swift
//  RagsNTags
//
//  Created by Capgemini-DA322 on 9/21/22.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
import CoreData

//MARK: class TextFieldValidation for validating text
class TextFieldValidation{
    
    //func email id validation
    func isValidEmailID(email: String) -> Bool {
        var result = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        do{
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = email as NSString
            let results = regex.matches(in: email, range: NSRange(location: 0, length: nsString.length))
            if (results.count == 0){
                result = false
            }
            
        }catch (let error as NSError){
            result = false
            print(error.localizedDescription)
        }
        
        return result
    } //end of email id validation
    
    //Password validation
    func isValidPassword(password: String) -> Bool{
        var result = true
        let passwordRegEx = "(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])[a-zA-Z0-9]{6,}"
        do{
            let regex = try NSRegularExpression(pattern: passwordRegEx)
            let nsString = password as NSString
            let results = regex.matches(in: password, range: NSRange(location: 0, length: nsString.length))
            if (results.count == 0){
                result = false
            }
            
        }catch (let error as NSError){
            result = false
            print(error.localizedDescription)
        }
        return result
    }//END of func password validation
    
}//END of class

//MARK: class RegisterUserOnCoreData
class RegisterUserOnCoreData: UIViewController{
    //func to register data on coreData
    func registerOnCoreData(name: String, mobile: String, email: String, password: String) -> Bool{
    let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let userData = NSEntityDescription.insertNewObject(forEntityName: "UserRegisterData", into: context) as! UserRegisterData
        
        var flag = 0
        do{
            let edata = try context.fetch(UserRegisterData.fetchRequest()) as! [UserRegisterData]
            for data in edata{
                let tomatchemail = data.email
                if(tomatchemail == email ){
                    //email exist
                    flag = 1
                    break
                    //print(tomatchemail)
                }
            }
            //no same email present so enter data in coreData
            if(flag == 0){
                userData.name = name
                userData.email = email
                userData.mobile = mobile
                userData.password = password
                do{
                    try context.save()
                    print("Data has been stored")
                    return true
                }catch {
                    print("Cant load")
                    return false
                }
                
            }else{
                print("email exist")
                return false
            }
        }catch{
            print("Error occured while storing user register data in CoreData")
            return false
        }//END of catch
    }//END of func
    
}//END of class RegisterUserOnCoreData


//MARK: class RegisterUserOnFirebase
class RegisterUserOnFirebase{
    
    //func for registering data on firebase
    func registerOnFirebase(emailid: String, password: String){
        Auth.auth().createUser(withEmail: emailid, password: password) { result, error in
            if let _error = error{
                print(_error.localizedDescription)
            }else{
                print("User registered")
            }
        }
    }//END of func
}//END of RegisterUserOnFirebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var mobileTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmPassTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: Function to call alerts if validation failed
    func callAlerts(titles: String, messages: String){
        
        let cancelAction = UIAlertAction(title: "OK", style: .cancel)
        { (action) in
        }
        
        // Create and configure the alert controller.
        let alert = UIAlertController(title: titles, message: messages, preferredStyle: .alert)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true) {
           // The alert was presented
        }
    }//END of func callAlert
    
    //MARK: Function clearField to clear the textField wiith invalid credentials
    func clearField(fieldName: String){
        switch (fieldName){
        case "name":
            nameTF.text = ""
        case "email":
            emailTF.text = ""
        case "mobile":
            mobileTF.text = ""
        case "password":
            passwordTF.text = ""
        case "confirmPassword":
            confirmPassTF.text = ""
        
        default: break
            
        }
    }//END of func clearField
    
    //MARK: IBAction when user submit the entered data
    @IBAction func enterIsClickerToRegister(_ sender: Any) {
        let name = nameTF.text!
        let mobile = mobileTF.text!
        let email = emailTF.text!
        let password = passwordTF.text!
        var coreDataStore: Bool?
        
        //MARK: Check if password and confirm password is same
        let val = TextFieldValidation()
        
        if(name.count < 4){
            callAlerts(titles: "Invalid name", messages: "Please provide First name and Last name")
            clearField(fieldName: "name")
        }else{
            if(mobile.count != 10){
            callAlerts(titles: "Invalid phone number", messages: "Please provide correct phone number.")
            clearField(fieldName: "mobile")
            print("wrong mobile")
            }else{
                if(!val.isValidEmailID(email: email)){
                callAlerts(titles: "Invalid email ID", messages: "Please provide correct email ID in format abc.xyz.com.")
                clearField(fieldName: "email")
                print("wrong email")
                    
                }else{
                    if (password == confirmPassTF.text!){
                        if(!val.isValidPassword(password: password)){
                            callAlerts(titles: "Invalid password", messages: "Please provide correct password with Capital letters and numbers and it should be more than or equal to 6 character long")
                            clearField(fieldName: "password")
                            clearField(fieldName: "confirmPassword")
                            print("wrong password")
                        }else{
                        //check user email exist using coreData
                            let regCore = RegisterUserOnCoreData()
                            coreDataStore = regCore.registerOnCoreData(name: name, mobile: mobile, email: email, password: password)
                            if(coreDataStore == true){
                            //store data in firebase
                                let regFirebase = RegisterUserOnFirebase()
                                regFirebase.registerOnFirebase(emailid: email, password: password)
                                let login = self.storyboard?.instantiateViewController(withIdentifier: "loginVC")
                                self.navigationController?.pushViewController(login!, animated: true)
                            }else{
                                //if email exist
                                callAlerts(titles: "Email exist", messages: "Provided email is already in use, please login or register using new email address.")
                                clearField(fieldName: "email")
                            }
                            
                        }
                    }else{
                        callAlerts(titles: "Password does not match", messages: "Please provide correct password")
                        clearField(fieldName: "password")
                        clearField(fieldName: "confirmPassword")
                        print("Password does match")
                    }
                }
            }
        }
    }//END of if
    
}//END of IBAction
