import UIKit

class RootSignViewController: UIViewController {

    @IBOutlet weak var toSignUpButton: UIButton!
    @IBOutlet weak var toLoginButton: UIButton!
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
             showSignUpViewController()
    }
    @IBAction func loginButtonTapped(_ sender: UIButton) {
             showLoginViewController()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        toSignUpButton.layer.cornerRadius = 6
        toSignUpButton.layer.masksToBounds = true
        toLoginButton.layer.cornerRadius = 6
        toLoginButton.layer.masksToBounds = true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
