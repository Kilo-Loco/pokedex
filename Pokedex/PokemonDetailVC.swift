//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Kyle Lee on 11/15/15.
//  Copyright © 2015 Kyle Lee. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    var pokemon: Pokemon!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokedexLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var evoLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.nameLbl.text = self.pokemon.name.capitalizedString
        
        let img = UIImage(named: "\(pokemon.pokedexId)")
        self.mainImg.image = img
        self.currentEvoImg.image = img
        
        self.pokemon.downloadPokemonDetails { () -> () in
            self.updateUI()
        }
    }
    
    func updateUI() {
        self.descriptionLbl.text = pokemon.description
        self.typeLbl.text = pokemon.type
        self.attackLbl.text = pokemon.attack
        self.heightLbl.text = pokemon.height
        self.pokedexLbl.text = "\(pokemon.pokedexId)"
        self.weightLbl.text = pokemon.weight
        self.defenseLbl.text = pokemon.defense
        
        if self.pokemon.nextEvolutionId == "" {
            self.evoLbl.text = "No Evolutions"
            self.nextEvoImg.hidden = true
        } else {
            self.nextEvoImg.hidden = false
            self.nextEvoImg.image = UIImage(named: self.pokemon.nextEvolutionId)
            var str = "Next Evolution: \(self.pokemon.nextEvolutionTxt)"
            
            if self.pokemon.nextEvolutionLvl != "" {
                str += " - LVL \(self.pokemon.nextEvolutionLvl)"
                self.evoLbl.text = str
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func backBtnPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
