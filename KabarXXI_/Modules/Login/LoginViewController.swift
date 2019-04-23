import UIKit

class LoginViewController: UIViewController , UITextFieldDelegate{
    @IBOutlet weak var txfUsername: UITextField!
    @IBOutlet weak var txfPassword: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
         login(txfUsername.text!, txfPassword.text!)
    }
    @IBAction func toRegisterButtonTapped(_ sender: UIButton) {
        showSignUpViewController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 6
        loginButton.layer.masksToBounds = true
        txfUsername.delegate = self
        txfPassword.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func login(_ username: String,_ password: String) {
        providerUserService.request(UserServices.loginUser(username: username,  password: password)) { (result) in
            switch result {
            case .success(let response):
                
                    do {
                        //here dataResponse received from a network request
                        let decoder = JSONDecoder()
                        let responseUser = try decoder.decode(UserResponse.self, from:
                            response.data) //Decode JSON Response Data
                        print(responseUser)
                        guard let email = self.txfUsername.text, email == responseUser.user.username,
                            let password = self.txfPassword.text, password == responseUser.user.encrypted_password else {
                                let alert = UIAlertController(title: "Error", message: "Invalid email or password", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                               self.present(alert, animated: true, completion: nil)
                                return
                        }
                        //self.showHomeViewController()
                    } catch let parsingError {
                        print("Error", parsingError)
                    }
               
                //let responseString = String(data: response.data, encoding: .utf8)
                //print("response login: \(String(describing: responseString))")
            case .failure(let error):
                print("error login: \(error)")
                
            }
        }
        
    }
}

// MARK: - UIViewController
extension UIViewController {
    func showLoginViewController() {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let nc = storyboard.instantiateViewController(withIdentifier: "login") as! LoginViewController
        present(nc, animated: true, completion: nil)
    }
}
