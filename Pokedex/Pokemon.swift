//
//  Pokemon.swift
//  Pokedex
//
//  Created by Kyle Lee on 11/14/15.
//  Copyright © 2015 Kyle Lee. All rights reserved.
//

import Foundation

class Pokemon {
    private var _name: String!
    private var _pokedexId: Int!
    
    var name: String! { return self._name }
    var pokedexId: Int! { return self._pokedexId }
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
    }
    
}