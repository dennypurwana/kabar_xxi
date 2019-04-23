
import Foundation
import Moya
import UIKit

let newsProviderServices = MoyaProvider<NewsServices>()

enum NewsServices{
   
    case getLatestNews()
    case getMainNews()
    case getPopularNews()
    case getCategory()
    case getRelatedNews(keyword:String)
    case getNewsByCategory(categoryName:String)
    
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
            
        case .getRelatedNews(let keyword):
            return "/news/related/\(keyword)"
            
        case .getNewsByCategory(let categoryName):
            return "/news/newsByCategory/\(categoryName)"
       
        case .getCategory:
            return "/category"
            
    
        }
    }
    
    var method: Moya.Method {
        switch self {
//        case .upload:
//            return .post
//
        default:
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
        
        case .getRelatedNews(_):
            let parameters: [String: Any] =
                [:]
            return .requestParameters(
                parameters: parameters,
                encoding: URLEncoding.default
            )
            
        case .getNewsByCategory(_):
            let parameters: [String: Any] =
                [:]
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
