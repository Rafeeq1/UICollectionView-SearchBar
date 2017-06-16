//
//  ViewController.swift
//  MRCollectionSearch
//
//  Created by Mohammad Ateeq on 16/06/2017.
//  Copyright © 2017 Rafeeq. All rights reserved.
//

import UIKit

class MRCollectionSearchVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var isSearchActive:Bool=false
    
    var filteredPizzaHuts:[String]=[]
    let pizzaHuts="The Pizza Stone,Speedy's Pizza Delivery,The Funky Anchovy,Deep Dish Pizzeria,Tossers Pizzeria,Feelin' Saucy Pizza Shop,Doughbie Brothers Pizza,Red Pepper Pizza,Twin Brothers,NY PIE,Wildfire Coal Fired Pizza,Pizza Toss Pizzeria,Luigi's Pizza,Slice of Heaven,Go-Go-Gourmet Pizza,We Knead Pizza,Basil's Pizza Parlor,Lighthouse Pizza,Hot Stone Pizzeria,Pepperoni's Pizzeria,Mellow Mozzarella Pizzeria,Skyline Pizza,Circular Pi Pizzeria,Pinballer Pizza & Arcade,Hearty Hearth Pizza Oven,Full Moon Pizza,The Crispy Crust Pizzeria,The Pie,Pizza Kitchen,Half Baked Take 'N' Bake Pizza,Sin City Slice,The Pizza Connection,Margherita Mama's Pizza Shop,All Around Pizza,PeppiPizza Co.,Township Pizza Shop,Slice of Italy Pizza,Holy Rollers Pizzeria,Wicked Marinara,Applewood Smoked Pizza,Inside-Outs Pizza,Crossgates Pizza Grill,Pizza Express,Pioneer Pizza,Tower of Pizza,Heirloom Homemade Pizza,Party Time Pizza,Pizza Paradise,Pizza Peddler,We Stuff Pizza,Buttercrust,Pie in the Sky,Tuscany Pizzeria,The Mad Pizza Scientist,Charred Charlie's Pizza,White Pie Pizza Restaurant,Touchdown Pizza,Family Night Pizza,The Black Olive Gourmet Pizzeria,Golden Globe Pizza,Inner City Pizza Co.,Stonecold Pizza,Varsity Pizza,Pizza Castle,Pizza University,Shipwreck Pizza and Wings,World of Pizza,Pirates Cove Pizza,Downtown Pizza and Subs,Chicago Pizza Kitchen,Brick Oven Pizza Parlor,Masterpiece Pies,Twisted Toppings,Papa Louie's Pizza Parlor,Angry Baby Pizza,Home Team Pizzeria,Carnivores Pizza Buffet,Hot Sausage Pizza Shop,Marinara's Pie Shop,Slice Guy,The Pizza Box,Frankie's Fried Pizza,Oven Baked Pizzas and Calzones,Hot Spot Pizza Shop,Sugar and Slice Pizza Shop,Rosa's Italian Pizzeria,Sterling Pan Pizza Co.,Stakeout Pizza,Gooey Gouda Pizza Crafters,Home Slice,Skinny Slice Pizzeria,The Pizza Cutter,Blood Pie Pizzas,Flyer's Pizza,The Sizzlin' Pepperoni,Lazy Baker Pizza Maker,Da Wheel".components(separatedBy: ",")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //CollectionView item size setup
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            let numberOfColumns: CGFloat = 3
            let horizontalSpacing = flowLayout.scrollDirection == .vertical ? flowLayout.minimumInteritemSpacing : flowLayout.minimumLineSpacing
            let cellWidth = (view.frame.width - max(0, numberOfColumns - 1)*horizontalSpacing)/numberOfColumns
            flowLayout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}





/* CollectionView Datasource and Delegates*/
extension MRCollectionSearchVC:UICollectionViewDataSource,UICollectionViewDelegate{
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(isSearchActive){
            print(" Filtered object:\(filteredPizzaHuts[indexPath.row])")
        }
        else {
            print(" Un-Filtered object:\(pizzaHuts[indexPath.row])")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(isSearchActive){
            return filteredPizzaHuts.count
        }
        return pizzaHuts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "CellItem", for: indexPath) as! CollectionSearchCell
        
        if(isSearchActive){
            cell.itemTitle.text=filteredPizzaHuts[indexPath.row]
        }
        else {
        
            cell.itemTitle.text=pizzaHuts[indexPath.row]
        }
        
        return cell
    }
    
}




/* Searchbar Delegates */
extension MRCollectionSearchVC:UISearchBarDelegate{
    

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar){
        isSearchActive=false
        collectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar){
        isSearchActive=false
        collectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        isSearchActive=false
        collectionView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredPizzaHuts=pizzaHuts.filter({ (text) -> Bool in
            
            let temp:NSString=text as NSString
            let range=temp.range(of: searchText, options: .caseInsensitive)
            return range.location != NSNotFound
        })
        
        if(filteredPizzaHuts.count>0 || searchText.characters.count>0){
            isSearchActive=true
        }
        else{
            isSearchActive=false
        }
        
        collectionView.reloadData()
    }
    
}


