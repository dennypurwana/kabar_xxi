
import Foundation
import Moya
import UIKit

let newsProviderServices = MoyaProvider<NewsServices>()

enum NewsServices{
   
    case getLatestNews()
    case getMainNews()
    case getPopularNews()
    case getCategory()
    
}

extension NewsServices :TargetType{
    var baseURL: URL {
        return URL(string: Constant.ApiUrl)!
    }
    
    var path: String {
        switch self {
       
        case .getLatestNews:
            return "/news/latest"
       
        case .getMainNews:
            return "/news/main"
            
        case .getPopularNews:
            return "/news/popular"
            
        case .getCategory:
            return "/category"
    
        }
    }
    
    var method: Moya.Method {
        switch self {
       
        case .getCategory:
            return .get

        case .getLatestNews:
            return .get
            
        case .getMainNews:
            return .get
            
        case .getPopularNews:
            return .get
            

        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {

        case .getLatestNews():
            return .requestParameters(
                parameters: [:],
                encoding: URLEncoding.default
            )
            
        case .getMainNews():
            return .requestParameters(
                parameters: [:],
                encoding: URLEncoding.default
            )
            
        case .getPopularNews():
            return .requestParameters(
                parameters: [:],
                encoding: URLEncoding.default
            )
            
        case .getCategory():
            return .requestParameters(
                parameters: [:],
                encoding: URLEncoding.default
            )
        
        }
        
    }
    
    var headers: [String : String]? {
        return nil
    }
    
}
