//
//  ViewController.swift
//  Pokedex
//
//  Created by Kyle Lee on 11/14/15.
//  Copyright © 2015 Kyle Lee. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    @IBOutlet weak var circleDec: UIView!

    @IBOutlet weak var collection: UICollectionView!
    
    @IBOutlet var searchBar: UISearchBar!
    
    
    var pokemon = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var musicPlayer: AVAudioPlayer!
    var inSearchMode = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad() 
        
        self.collection.delegate = self
        self.collection.dataSource = self
        self.searchBar.delegate = self
        self.searchBar.returnKeyType = UIReturnKeyType.Done
        
        self.initAudio()
        self.parsePokeCSV()
        
    }
    
    func initAudio() {
        
        let path = NSBundle.mainBundle().pathForResource("music", ofType: "mp3")!
        
        do {
            self.musicPlayer = try AVAudioPlayer(contentsOfURL: NSURL(string: path)!)
            self.musicPlayer.prepareToPlay()
            self.musicPlayer.numberOfLoops = -1
            self.musicPlayer.play()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        
    }
    
    func parsePokeCSV() {
        let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")!
        
        
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows {
                let pokeID = Int(row["id"]!)!
                let name = row["identifier"]!
                let poke = Pokemon(name: name, pokedexId: pokeID)
                self.pokemon.append(poke)
            }
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokeCell", forIndexPath: indexPath) as? PokeCell {
            
            let poke: Pokemon!
            
            if self.inSearchMode {
                poke = filteredPokemon[indexPath.row]
            } else {
                poke = pokemon[indexPath.row]
            }
            
            cell.configureCell(poke)
            return cell
            
        } else {
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
     
        let poke: Pokemon!
        
        if self.inSearchMode {
            poke = self.filteredPokemon[indexPath.row]
        } else {
            poke = self.pokemon[indexPath.row]
        }

        performSegueWithIdentifier("PokemonDetailVC", sender: poke)
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if self.inSearchMode {
            return self.filteredPokemon.count
        }
        
        return self.pokemon.count
        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        return CGSizeMake(105, 105)
    }

    @IBAction func volumeButton(sender: UIButton!) {
        if self.musicPlayer.playing {
            self.musicPlayer.pause()
            sender.alpha = 0.2
        } else {
            self.musicPlayer.play()
            sender.alpha = 1.0
        }
        
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.searchBar.resignFirstResponder()
    }
    
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if self.searchBar.text == nil || self.searchBar.text == "" {
            self.inSearchMode = false
            view.endEditing(true)
            collection.reloadData()
        } else {
            self.inSearchMode = true
            let lower = self.searchBar.text!.lowercaseString
            
            self.filteredPokemon = pokemon.filter({$0.name.rangeOfString(lower) != nil})
            self.collection.reloadData()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PokemonDetailVC" {
            if let detailsVC = segue.destinationViewController as? PokemonDetailVC {
                if let poke = sender as? Pokemon {
                    detailsVC.pokemon = poke
                }
            }
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}

