//
//  PokemonController.swift
//  Pokedex
//
//  Created by Uzo on 1/20/20.
//  Copyright © 2020 Uzo. All rights reserved.
//

import UIKit

class PokemonController {
    
    static func fetchPokemon(searchTerm: String, completion: @escaping(Result<Pokemon, PokemonAPIError>) -> Void) {
        
        // Step 1: Assemble the URL
        guard let baseURL = URL(string: "https://pokeapi.co/api/v2") else {
            return completion(.failure(.invalidURL))
        }
        let pokemonURL = baseURL.appendingPathComponent("pokemon")
        let finalURL = pokemonURL.appendingPathComponent(searchTerm.lowercased())
        print(finalURL)
        
        
        // Step 2: create a request
        var request = URLRequest(url: finalURL)
        request.httpMethod = "GET"
        request.httpBody = nil
        
        // Step 3: Go to the Internet
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            // handle error
            if let error = error {
                print(error, error.localizedDescription)
                return completion(.failure(.communicationError))
            }
            
            //unwrap the error
            guard let data = data else { return completion(.failure(.noData))}
            
            do {
                let decoder = JSONDecoder()
                let pokemon = try decoder.decode(Pokemon.self, from: data)
                return completion(.success(pokemon))
            } catch {
                print(error, error.localizedDescription)
                return completion(.failure(.unableToDecodeData))
            }
            
        }.resume()
        
    }
    
    static func fetchSprite(for pokemon: Pokemon, completion: @escaping(Result<UIImage, PokemonAPIError>) -> Void) {
        
        let url = pokemon.sprites.frontDefault
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.httpBody = nil
        
        URLSession.shared.dataTask(with: request) { (data, _, error ) in
            if let error = error {
                print(error, error.localizedDescription)
                return completion(.failure(.communicationError))
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            
            guard let image = UIImage(data: data) else {
                return completion(.failure(.unableToDecodeData))
            }
            
            completion(.success(image))
        }.resume()
    }
}


enum PokemonAPIError: LocalizedError {
    case invalidURL
    case communicationError
    case noData
    case unableToDecodeData
}
