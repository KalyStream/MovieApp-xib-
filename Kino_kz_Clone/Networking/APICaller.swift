//
//  APICaller.swift
//  Kino_kz_Clone
//
//  Created by Kalybay Zhalgasbay on 19.04.2022.
//

import Foundation

struct Constants {
    
    static let popularMovieUrl = "https://api.themoviedb.org/3/movie/popular?api_key=f4c46807364b1f792191d375f64bb34c&language=en-US&page=1"

    static let upcomingMovieUrl = "https://api.themoviedb.org/3/movie/upcoming?api_key=f4c46807364b1f792191d375f64bb34c&language=en-US&page=1"
    
    static let topRatedMovieUrl = "https://api.themoviedb.org/3/movie/top_rated?api_key=f4c46807364b1f792191d375f64bb34c&language=en-US&page=1"
    
    static let trendingMovieUrl = "https://api.themoviedb.org/3/trending/movie/day?api_key=f4c46807364b1f792191d375f64bb34c&language=en-US&page=1"
}

struct APICaller {
    
    static func fetchPopularMovies(completion: @escaping (Result<[MovieInfo],Error>) -> Void){
        guard let url = URL(string: Constants.popularMovieUrl) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let results = try decoder.decode(MovieResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(error))
            }
            
        }
        
        task.resume()
    }
    
    static func fetchUpcomingMovies(completion: @escaping (Result<[MovieInfo],Error>) -> Void){
        guard let url = URL(string: Constants.upcomingMovieUrl) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let results = try decoder.decode(MovieResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    static func fetchTopRatedMovies(completion: @escaping (Result<[MovieInfo], Error>)-> Void){
        guard let url = URL(string: Constants.topRatedMovieUrl) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(MovieResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    static func fetchTrendingMovies(completion: @escaping (Result<[MovieInfo],Error>)-> Void){
        guard let url = URL(string: Constants.trendingMovieUrl) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(MovieResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(error))
            }

        }
        
        task.resume()
    }
}
