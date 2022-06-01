//
//  MovieViewCell.swift
//  Kino_kz_Clone
//
//  Created by Kalybay Zhalgasbay on 19.04.2022.
//

import UIKit

class MovieCollectionTableViewCell: UITableViewCell {

    
    @IBOutlet weak var movieCollectionView: UICollectionView!
    
    private var MovieModels = [MovieInfo]()

    static let identifier = "MovieCollectionTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = .black
        movieCollectionView.dataSource = self
        movieCollectionView.delegate = self
        movieCollectionView.register(MovieCell.setNib(), forCellWithReuseIdentifier: MovieCell.identifier)
        
    }

    static func setNib() -> UINib {
        return UINib(nibName: "MovieCollectionTableViewCell", bundle: Bundle.main)
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configureMovie(with model: [MovieInfo]){
        self.MovieModels = model
        DispatchQueue.main.async { [weak self] in
            self?.movieCollectionView.reloadData()
        }
    }
    
    
}

extension MovieCollectionTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MovieModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = movieCollectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell else {
            return UICollectionViewCell()
        }
        
        let model = MovieModels[indexPath.row]
        cell.configure(with:model)
        cell.configure(with: model.posterPath ?? model.backdropPath)
        
        return cell
    }
    
    
}

extension MovieCollectionTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 340)
    }
}

extension MovieCollectionTableViewCell: UICollectionViewDelegate {
    
}
