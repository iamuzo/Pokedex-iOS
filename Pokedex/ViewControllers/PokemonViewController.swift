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
            
            DispatchQueue.main.async {
                switch result {
                    case .success(let image):
                        self.pokemonImage.image = image
                        self.pokemonNameLabel.text = pokemon.name.uppercased()
                        self.pokemonWeightLabel.text = String(pokemon.weight)
                        self.pokemonIDLabel.text = String(pokemon.id)
                    case .failure(let error):
                    print(error)
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
                    print(pokemon)
                    self.fetchSpriteAndUpdateUI(for: pokemon)
                    case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
