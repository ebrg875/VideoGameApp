//
//  BaseRequest.swift
//  VideoGamesApp
//
//  Created by emeksu.barug on 4.02.2022.
//

import Foundation

struct BaseRequest {
    var url: URL?
    var method: String?
    var parameters: [String: Any]

    init(_ path: String,
         method: String? = "GET",
         parameters: [String: Any] = [:])
    {
        self.url = URL(string: APIConfig.current.rawValue + path)
        self.method = method
        self.parameters = parameters
        self.parameters["key"] = APIConfig.current.getApiKey()
    }
}
