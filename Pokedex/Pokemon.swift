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
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionTxt: String!
    
    var name: String! { return self._name }
    var pokedexId: Int! { return self._pokedexId }
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
    }
    
}