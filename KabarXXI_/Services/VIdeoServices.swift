
import Foundation
import Moya
import UIKit

let videoProviderServices = MoyaProvider<VideoServices>()

enum VideoServices{

    case getVideo()
    
}

extension VideoServices :TargetType{
    var baseURL: URL {
        return URL(string: Constant.ApiUrlLocal)!
    }
    
    var path: String {
        switch self {
            
        case .getVideo:
            return "/getVideo.php"
            
        }
    }
    
    var method: Moya.Method {
        switch self {
            
        case .getVideo:
            return .get
            
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
            
        case .getVideo():
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

