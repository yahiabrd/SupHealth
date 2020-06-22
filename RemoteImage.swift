//
//  RemoteImage.swift
//  SupHealth
//
//  Created by Yahia Berrada on 6/17/20.
//  Copyright © 2020 Supinfo. All rights reserved.
//

import SwiftUI


//struct for loading images

struct RemoteImage: View {
    @ObservedObject var imageLoader = ImageLoader()
    
    var placeholder:Image
    
    init(url: String, placeholder:Image = Image(systemName: "photo")) {
        self.placeholder = placeholder
        imageLoader.fetchImage(url: url)
    }
    
    var body: some View {
        if let image = self.imageLoader.downloadImage{
            return Image(uiImage: image)
        }
        return placeholder
    }
}

struct RemoteImage_Previews: PreviewProvider {
    static var previews: some View {
        RemoteImage(url: "")
    }
}
