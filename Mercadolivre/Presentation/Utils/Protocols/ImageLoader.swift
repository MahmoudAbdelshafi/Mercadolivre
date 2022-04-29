//
//  ImageLoader.swift
//  Mercadolivre
//
//  Created by Mahmoud Abdelshafi on 28/04/2022.
//

import Kingfisher

protocol ImageLoader {
    func loadWebImageWithUrl(imageUrl: String)
}

extension UIImageView: ImageLoader {
    func loadWebImageWithUrl(imageUrl: String) {
        self.startAnimating()
        self.kf.indicatorType = .activity
        let url = URL(string: imageUrl)
        self.kf.setImage(with: url,
                         options: [.transition(.fade(0.5))],
                         progressBlock: nil,
                         completionHandler: nil)
    }
}
