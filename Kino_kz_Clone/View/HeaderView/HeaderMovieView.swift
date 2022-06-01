//
//  HeaderMovieView.swift
//  Kino_kz_Clone
//
//  Created by Kalybay Zhalgasbay on 22.04.2022.
//

import UIKit

class HeaderMovieView: UIView {

    private let headerViewImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "header")
        
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(headerViewImage)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        headerViewImage.frame = bounds
    }

    func configure(with movieImage: String){
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(movieImage)") else {
            return
        }
        
        headerViewImage.sd_setImage(with: url)
    }
}
