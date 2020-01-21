//
//  PokemonViewController.swift
//  Pokemon
//
//  Created by Uzo on 1/20/20.
//  Copyright © 2020 Uzo. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var pokemonSearchBar: UISearchBar!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonWeightLabel: UILabel!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonSearchBar.delegate = self
    }
    
    // MARK: - Custom Methods
    func fetchSpriteAndUpdateUI(for pokemon: Pokemon) {
        PokemonController.fetchSprite(for: pokemon) { (result) in
            
            //if you are doing anything on the UI/View
            //always do it on the main queue
            DispatchQueue.main.async {
                switch result {
                    case .success(let image):
                        let name = pokemon.name.uppercased()
                        let weight = pokemon.weight
                        let id = pokemon.id
                        
                        self.pokemonImage.image = image
                        self.pokemonNameLabel.text = "Hi, I am \(name)"
                        self.pokemonWeightLabel.text = "I weight \(weight) lbs"
                        self.pokemonIDLabel.text = "And my pokemon ID is \(id)"
                    case .failure(let error):
                    print(error)
                    self.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
}

extension PokemonViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchBarText = searchBar.text,  !searchBarText.isEmpty else { return }
        
        print(searchBarText)
        
        PokemonController.fetchPokemon(searchTerm: searchBarText) { (resultFromAPI) in
            DispatchQueue.main.async {
                switch resultFromAPI {
                    case .success(let pokemon):
                    self.fetchSpriteAndUpdateUI(for: pokemon)
                    case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
}
