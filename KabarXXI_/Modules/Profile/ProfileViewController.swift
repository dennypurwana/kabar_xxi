import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet var lblSignUp: UILabel!
    
    @IBOutlet var loginButton: UIButton!
    
    @IBOutlet var signUpButton: UIButton!
    
    let userDefaults = UserDefaults.standard
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
       showLoginViewController()
        
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        
         showSignUpViewController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Profile"
        checkLogin()
    }
    
    
    func checkLogin(){
        
        let isLogin = userDefaults.bool(forKey: "isLogin")
        loginButton.layer.cornerRadius = 6
        loginButton.layer.masksToBounds = true
        if(isLogin){
            
            self.loginButton.isHidden = true
            self.signUpButton.isHidden = true
            self.lblSignUp.isHidden = true
        }
        else
        {
            self.loginButton.isHidden = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkLogin()
    }
    


}


extension UIViewController {
    func showProfileViewController() {
        let storyboard = UIStoryboard(name: "TabbarMenu", bundle: nil)
        let nc = storyboard.instantiateViewController(withIdentifier: "profile") as! ProfileViewController
        // present(nc, animated: true, completion: nil)
        navigationController?.pushViewController(nc, animated: true)
    }
}
