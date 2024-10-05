//
//  AddReviewEndpoint.swift
//  Movarium
//
//  Created by Anton Solovev on 05.10.2024.
//

import Alamofire
import KeychainAccess

struct AddReviewEndpoint: APIEndpoint {
    
    private var authToken: String? {
        let keychain = Keychain()
        return try? keychain.get("authToken")
    }
    let movieID: String
    
    var path: String {
        return "/api/movie/\(movieID)/review/add"
    }
    
    var method: Alamofire.HTTPMethod {
        return .post
    }
    
    var parameters: Alamofire.Parameters? {
        return ["id": movieID]
    }
    
    var headers: Alamofire.HTTPHeaders? {
        guard let token = authToken else { return nil }
        return [
            "Authorization": "Bearer \(token)"
        ]
    }
}
