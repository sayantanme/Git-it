//
//  ImageViewExtension.swift
//  Git-it
//
//  Created by Sayantan Chakraborty on 25/11/17.
//  Copyright © 2017 Sayantan Chakraborty. All rights reserved.
//

import UIKit
let imageCache = NSCache<AnyObject, AnyObject>()
extension UIImageView{
    func loadImageFromImageUrlFromCache(url:String){
        
        self.image = nil
        if let cachedImage = imageCache.object(forKey: url as AnyObject) as? UIImage{
            maskCircle(anyImage: cachedImage)
            return
        }
        
        let urlRequest = URLRequest(url: URL(string: url)!)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: urlRequest) { (data:Data?, response:URLResponse?, error:Error?) in
            guard error == nil else{
                print(error?.localizedDescription ?? "error from loadImageFromImageUrlFromCache")
                return
            }
            DispatchQueue.main.async {
                if let downloadImage = UIImage(data: data!){
                    imageCache.setObject(downloadImage, forKey: url as AnyObject)
                    self.maskCircle(anyImage: downloadImage)
                }
            }
        }
        task.resume()
    }
    
    fileprivate func maskCircle(anyImage: UIImage) {
        self.contentMode = UIViewContentMode.scaleAspectFill
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = false
        self.clipsToBounds = true
        self.image = anyImage
    }
}

