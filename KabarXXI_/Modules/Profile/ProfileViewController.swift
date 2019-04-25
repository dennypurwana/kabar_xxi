import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet var loginButton: UIButton!
    
    @IBOutlet var signUpButton: UIButton!
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
       showLoginViewController()
        
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        
         showSignUpViewController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Profile"
        
        loginButton.layer.cornerRadius = 6
        loginButton.layer.masksToBounds = true

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
