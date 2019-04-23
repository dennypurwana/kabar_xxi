
import Foundation
import Moya
import UIKit

let providerUserService = MoyaProvider<UserServices>()

enum UserServices{
    case createUser(  username:String,  email:String,  phone:String, password:String)
    case loginUser(username:String,password:String)
    case getUserById(userId:String)
}

extension UserServices :TargetType{
    var baseURL: URL {
        return URL(string: Constant.ApiUrl)!
    }
    
    var path: String {
        switch self {
        case .createUser:
            return "/register.php"
            
        case .loginUser:
            return "/login.php"
            
        case .getUserById:
            return "/getProfile.php"
        
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .createUser:
            return .post
        default:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
       
        case .createUser(let username, let email, let phone, let password):
            return .requestParameters(
                parameters: ["username": username,"email": email,"phone": phone,"password": password,],
                encoding: URLEncoding.default
            )
            
        case .loginUser(let username, let password):
            let parameters: [String: Any] = [
                "username": username,
                "password": password,
            ]
            return .requestParameters(
                parameters: parameters,
                encoding: URLEncoding.default
            )
           
        case .getUserById(let userid):
            let parameters: [String: Any] = [
                "user_id": userid
            ]
            return .requestParameters(
                parameters: parameters,
                encoding: URLEncoding.default
            )
            
        }
        
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
    
    
}
