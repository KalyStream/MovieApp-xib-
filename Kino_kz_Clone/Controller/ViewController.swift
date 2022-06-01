//
//  ViewController.swift
//  Kino_kz_Clone
//
//  Created by Kalybay Zhalgasbay on 19.04.2022.
//

import UIKit

class ViewController: UIViewController {
    
    enum Sections: Int {
        case Popular = 0
        case Upcoming = 1
        case Trending = 2
        case TopRated = 3
    }
    
    private var header: HeaderMovieView?
    
    private let titles: [String] = ["Popular", "Upcoming", "Trending", "Top rated"]

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MovieCollectionTableViewCell.setNib(), forCellReuseIdentifier: MovieCollectionTableViewCell.identifier)
        
        header = HeaderMovieView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 400))
        tableView.tableHeaderView = header
        configureHeaderImage()
        
    }
    
    func configureHeaderImage(){
        
        APICaller.fetchTopRatedMovies {[weak self] result in
            switch(result){
            case .success(let output):
                let selectedElement = output.randomElement()
                let selectedImage = selectedElement?.posterPath ?? " "
                self?.header?.configure(with: selectedImage)
                //print(selectedImage)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }


}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCollectionTableViewCell.identifier, for: indexPath) as? MovieCollectionTableViewCell else { return UITableViewCell() }
        
        switch indexPath.section {
        case (Sections.Popular.rawValue):
            APICaller.fetchPopularMovies { result in
                switch(result){
                case .success(let output):
                    cell.configureMovie(with: output)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case (Sections.Upcoming.rawValue):
            APICaller.fetchUpcomingMovies { result in
                switch(result){
                case .success(let output):
                    cell.configureMovie(with: output)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case (Sections.Trending.rawValue):
            APICaller.fetchTrendingMovies { result in
                switch(result){
                case .success(let output):
                    cell.configureMovie(with: output)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case (Sections.TopRated.rawValue):
            APICaller.fetchTopRatedMovies { result in
                switch(result){
                case .success(let output):
                    cell.configureMovie(with: output)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        default:
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return titles[section]
    }
}

extension ViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 370
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerText = UILabel()
        headerText.font = UIFont.boldSystemFont(ofSize: 30)
        headerText.textColor = .white
        headerText.backgroundColor = .black
        headerText.frame = CGRect(x: 10, y: -10, width: 300, height: 50)
        headerText.text = self.tableView(tableView, titleForHeaderInSection: section)
        
        let headerView = UIView()
        headerView.backgroundColor = .black
        headerView.addSubview(headerText)
        return headerView
    }
}
