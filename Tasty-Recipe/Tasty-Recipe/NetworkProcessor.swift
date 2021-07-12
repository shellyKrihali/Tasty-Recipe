//
//  NetworkProcessor.swift
//  Tasty-Recipe
//
//  Created by user196689 on 7/4/21.
//

import Foundation

class NetworkProcessor{
    lazy var configuraiton = URLSessionConfiguration.default
       lazy var session = URLSession(configuration: configuraiton)
       
       var url : URL?
       
       init(url : URL) {
           self.url = url
       }
       
       typealias JSONDownloader = ((Codable?)-> Void)
       typealias IMAGEDATADownloader = ((Data?, HTTPURLResponse?, Error?)-> Void)
    //Download Image Data
    func downloadImage(_ completion : @escaping IMAGEDATADownloader ){
        guard let imageUrl = self.url else { return }
        let imageRequest = URLRequest(url: imageUrl)
        
        let imageDataTask = session.dataTask(with: imageRequest) { (imageData, imageResponse, imageError) in
           
            if imageError == nil {
                guard let response = imageResponse as? HTTPURLResponse else {return}
                
                switch response.statusCode {
                case 200:
                    guard let data = imageData else {return}
                    completion(data, nil, nil )
                default:
                    return
                }
            }else {
                print("Error downloading Image:  \(imageError.debugDescription)")
                completion(nil, nil, imageError!)
            }
        }
        imageDataTask.resume()
    }
    
    }
