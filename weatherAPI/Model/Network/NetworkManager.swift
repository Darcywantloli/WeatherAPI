//
//  NetworkManager.swift
//  weatherAPI
//
//  Created by Hung-Ming Chen on 2022/9/15.
//

import Foundation

class NetworkManager: NSObject {
    
    static let shared = NetworkManager()
    
    func getWeatherData<D: Decodable>(city: String, completion: @escaping (D?) -> Void, failure: @escaping (String?) -> Void) {
        let address = "https://api.openweathermap.org/data/2.5/weather?"
        if let url = URL(string: address + "q=\(city)" + "&units=metric&lang=zh_tw&appid=" + NetworkConstants.apiKey) {
            URLSession.shared.dataTask(with: url) {(data, response, error) in
                if let error = error {
                    failure("Error: \(error.localizedDescription)")
                } else if let response = response as? HTTPURLResponse, let data = data {
                    print("Status code: \(response.statusCode)")
                    
                    #if DEBUG
                    let content = String(data: data, encoding: .utf8) ?? ""
                    print(content)
                    #endif
                    
                    let decoder = JSONDecoder()
                    if let weatherData = try? decoder.decode(D.self, from: data) {
                        completion(weatherData)
                    } else {
                        failure("error")
                    }
                }
            }.resume()
        } else {
            failure("Invalid URL.")
        }
    }
}
