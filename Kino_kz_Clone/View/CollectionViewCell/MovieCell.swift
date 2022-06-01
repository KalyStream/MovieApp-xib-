//
//  MovieCell.swift
//  Kino_kz_Clone
//
//  Created by Kalybay Zhalgasbay on 19.04.2022.
//

import UIKit
import SDWebImage

class MovieCell: UICollectionViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieGenre: UILabel!
    @IBOutlet weak var averageVoteLabel: UILabel!
    
    var genresList: [Int:String] = [
        23:"action", 12:"adventure", 16:"animation", 35:"comedy", 80:"crime", 99:"documentary", 18:"drama", 10751:"family", 14:"fantasy", 36:"history", 27:"horror", 10402:"music", 9648:"mystery", 10749:"romance", 878:"science fiction", 10770:"tv movie", 53:"thriller", 10752:"war", 37:"western"
    ]
    
    static let identifier = "MovieCell"
        
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = .black
    }

    static func setNib() -> UINib {
        return UINib(nibName: "MovieCell", bundle: Bundle.main)
    }
    
    func configure(with postURL: String?){
        
        guard let safePostURL = postURL else {
            return
        }
        
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(safePostURL)") else {
            return
        }
        //movieImage.image = nil
        movieImage.sd_setImage(with: url)
    }
    
    func configure(with model: MovieInfo){
        //movieName.text = nil
        movieName.text = model.originalTitle
        movieName.textColor = .black
        movieName.font = UIFont.boldSystemFont(ofSize: 17)
        
        let genresIds = model.genreIDS
        var genres: String = ""
        for i in genresIds {
            guard let safeGenres = genresList[i] else {
                return
            }
            if(genres.isEmpty){
                genres = safeGenres
            } else {
                genres += ", \(safeGenres)"
            }
        }
        //movieGenre.text = nil
        movieGenre.text = genres
        movieGenre.textColor = .black
        
        let vote = model.voteAverage
        
        guard let safeVote = vote else {
            return
        }
        
        averageVoteLabel.backgroundColor = .none
        if(safeVote>=7){
            averageVoteLabel.backgroundColor = .green
        } else if(safeVote<7 && safeVote>=5){
            averageVoteLabel.backgroundColor = .orange
        } else {
            averageVoteLabel.backgroundColor = .red
        }
        //averageVoteLabel.text = nil
        averageVoteLabel.text = "\(safeVote)"
        averageVoteLabel.textColor = .black
        
    }
}



