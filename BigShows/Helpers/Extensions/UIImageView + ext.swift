//
//  UIImageView.swift
//  BigShows
//
//  Created by Andre Valdivia on 8/30/20.
//  Copyright © 2020 Andre Valdivia. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()



extension UIImageView {
    
    static var imageUrlLoads = Dictionary<String, URLSessionDataTask>()
    
    func loadImageWithUrl(urlString: String?, nameDefault: String? = nil, override: Bool = false, uuid: String? = nil){
        
        let urlString = urlString?.replacingOccurrences(of: " ", with: "%20")
        
        if !override, let imageCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage{
            self.image = imageCache
            return
        }
        
        if let nameDefault = nameDefault{
            self.image = UIImage(named: nameDefault)
        }else{
            self.image = nil
        }
        
        
        guard let string = urlString, let url = URL(string: string) else {
            print("No se cargo, error de URL: ", urlString as Any)
            return
        }
        
        if let uuid = uuid, UIImageView.imageUrlLoads[uuid] != nil{
            UIImageView.imageUrlLoads[uuid]?.cancel()
        }
        
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil
        let session = URLSession.init(configuration: config)
        let dataTask = session.dataTask(with: url){ (data, response, error) in
            if error != nil{
                return
            }
            DispatchQueue.main.async {
                
                if let data = data, let imageToCache = UIImage(data: data){
                    imageCache.setObject(imageToCache, forKey: urlString as AnyObject)
                    self.image = imageToCache
                    if let uuid = uuid {
                        UIImageView.imageUrlLoads.removeValue(forKey: uuid)
                    }
                }else{
                    print("No se cargo imagen: ", string)
                }
            }
        }
        if let uuid = uuid{
            UIImageView.imageUrlLoads[uuid] = dataTask
        }
        dataTask.resume()
    }
    
}
