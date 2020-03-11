//
//  APIClient.swift
//  MimeoTakeHome-iOS
//
//  Created by Axel Mosiejko on 11/03/2020.
//  Copyright © 2020 Mimeo. All rights reserved.
//

import Foundation

class APIClient {
    
    static var shared: APIClient = { return APIClient() }()
    private init(){}
    
    public func getUUID(completion: @escaping (UUID?) -> Void) {
        
        guard let url = URL(string: "https://httpbin.org/uuid") else { fatalError("Invalid URL") }
        
        URLSession.shared.dataTask(with: url) { data, response, err in
            if(err != nil) {
                completion(nil)
            }
            guard let httpResponse = response as? HTTPURLResponse else { fatalError("URL Response Error") }
            switch httpResponse.statusCode {
            case 200:
                if let data = data {
                    do {
                        let data = try JSONDecoder().decode(UUID.self, from: data)
                        completion(data)
                    } catch {
                        print("ERROR DECODING JSON \(err.debugDescription)")
                    }
                }
                break
            default:
                completion(nil)
                break
            }
        }.resume()
    }
    
    public func postRequest(image:EditImage, completion: @escaping (NSDictionary?) -> Void) {
        
        let json: [String: Any] = ["uuid": image.uuid ?? "000",
                                   "filename": image.filename ?? "n/a",
                                   "size": ["width":image.width ?? "0.0", "height":image.height ?? "0.0"],
                                   "rotation": Utils.getDegreeValueFor(position: image.position ?? 0)]

        let jsonData = try? JSONSerialization.data(withJSONObject: json)

        // create post request
        let url = URL(string: "https://httpbin.org/anything")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        // insert json data to the request
        request.httpBody = jsonData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            
            do {
                if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    print(convertedJsonIntoDict)
                    if let form = convertedJsonIntoDict["form"] as? NSDictionary {
                        completion(form)
                    }
               }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }

        task.resume()
    }
    
}
