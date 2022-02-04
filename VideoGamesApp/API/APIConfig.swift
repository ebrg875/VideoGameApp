//
//  APIConfig.swift
//  VideoGamesApp
//
//  Created by emeksu.barug on 4.02.2022.
//

import Foundation

enum APIConfig: String {
    static var current: APIConfig = .dev
    case dev = "https://api.rawg.io/api"

    func getApiKey() -> String {
        switch self{
            case .dev:
                return "97d710b59c434c88b3a07e5654d4b3f6"
        }
    }
}
