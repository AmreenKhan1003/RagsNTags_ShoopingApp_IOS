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

class TextFieldValidation{
    //email id validation
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
            
        }
        catch (let error as NSError){
            result = false
            print(error.localizedDescription)
        }
        
        return result
    } //end of email id validation
    
    //Password validation
    func isvalidpassword(password: String) -> Bool{
        var result = true
        let passwordRegEx = "(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])[a-zA-Z0-9]{6,}"
        do{
            let regex = try NSRegularExpression(pattern: passwordRegEx)
            let nsString = password as NSString
            let results = regex.matches(in: password, range: NSRange(location: 0, length: nsString.length))
            if (results.count == 0){
                result = false
            }
            
        }
        catch (let error as NSError){
            result = false
            print(error.localizedDescription)
        }
        return result
    }       //end of password validation
}

class RegisterUserOnCoreData{
    
    func registerOnCoreData(name: String, mobile: String, email: String, password: String) -> Bool{
    let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
        let userData = NSEntityDescription.insertNewObject(forEntityName: "UserRegisterData", into: context) as! UserRegisterData
        //check if provided email already exist in coreData
        //flag = 1 if exist email flag = 0 if not exist
        var flag = 0
        do{
            let edata = try context.fetch(UserRegisterData.fetchRequest()) as! [UserRegisterData]
            //print(edata)
            for data in edata{
                let tomatchemail = data.email
                
                if(tomatchemail == email ){
                    //email exist
                    flag = 1
                    //callAlert(titles: "Email Already Exist")
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
                }
                catch {
                    print("Cant load")
                    return false
                }
                //if registration is completed
                //print("Done")
            }
            else{
                //flag is 1 than email exist
                //callAlert(titles: "Email exist")
                //clearField(fieldName: "email")
                print("email exist")
                return false
            }
        }
        catch{
            print("Error occured while storing data")
            return false
        }
        
    }
}

class RegisterUserOnFirebase{
    
    func registerOnFirebase(emailid: String, password: String){
        Auth.auth().createUser(withEmail: emailid, password: password) { result, error in
            if let _error = error{
                print(_error.localizedDescription)
            }
            else{
                print("User registered")
            }
        }
    }
}

class RegisterViewController: UIViewController {

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var mobileTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmPassTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func enterIsClickerToRegister(_ sender: Any) {
        let name = nameTF.text!
        let mobile = mobileTF.text!
        let email = emailTF.text!
        let password = passwordTF.text!
        var coreDataStore: Bool?
        //MARK: Check if password and confirm password is same
        let val = TextFieldValidation()
        if(mobile.count != 10){
            //call alert
            print("wrong mobile")
        }else{
            if(!val.isValidEmailID(email: email)){
                //call alert
                print("wrong email")
            }
            else{
                if (password == confirmPassTF.text!){
                    if(!val.isvalidpassword(password: password)){
                        //call alert
                        print("wrong password")
                    }
                    else{
                        //check user email exist using coreData
                        let regCore = RegisterUserOnCoreData()
                        coreDataStore = regCore.registerOnCoreData(name: name, mobile: mobile, email: email, password: password)
                        if(coreDataStore == true){
                            //store data in firebase
                            let regFirebase = RegisterUserOnFirebase()
                            regFirebase.registerOnFirebase(emailid: email, password: password)
                            let login = self.storyboard?.instantiateViewController(withIdentifier: "loginVC")
                            self.navigationController?.pushViewController(login!, animated: true)
                        }
                    }
                }
                else{
                    //call alert
                    print("Password does match")
                }
            }
        }
            
        
        
    }
    
}
