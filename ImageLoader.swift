//
//  imageLoader.swift
//  SupHealth
//
//  Created by Yahia Berrada on 6/17/20.
//  Copyright © 2020 Supinfo. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

//class for fetching remote img

class ImageLoader:ObservableObject {
    @Published var downloadImage: UIImage?
    
    func fetchImage(url:String){
        guard let imageURL = URL(string: url)else{
            fatalError("url incorrect")
        }
        
        URLSession.shared.dataTask(with: imageURL ){ data, response, error in
            
            guard let data = data, error == nil else{
                fatalError("error reading img")
            }
            
            DispatchQueue.main.async {
                self.downloadImage = UIImage(data: data)
            }
        }.resume()
    }
}
