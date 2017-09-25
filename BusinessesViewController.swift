//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FiltersViewControllerDelegate, UISearchBarDelegate {
    
    var businesses: [Business]!
    var filteredBusinesses: [Business]?
    @IBOutlet weak var businessTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        businessTableView.delegate = self
        businessTableView.dataSource = self
        
        //tableView dynamic row height as content height
        businessTableView.rowHeight = UITableViewAutomaticDimension
        businessTableView.estimatedRowHeight = 120
        
        //add search bar to navigation
        let searchBar = UISearchBar()
        searchBar.placeholder = "Restaurants"
        searchBar.delegate = self  //implement search functions
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        
        
        /*
         Business.searchWithTerm(term: "Restaurants", sort: nil, categories: nil, deals: nil) { (businesses: [Business]!, error: Error?) in
         self.businesses = businesses
         self.businessTableView.reloadData()
         }
         */
        Business.searchWithTerm(term: "Restaurant", completion: { (businesses: [Business]?, error: Error?) -> Void in
            
            self.businesses = businesses
            self.businessTableView.reloadData()
            
            if let businesses = businesses {
                for business in businesses {
                    print(business.name!)
                    print(business.address!)
                }
            }
            
        }
        )
        
        /* Example of Yelp search with more search options specified
         Business.searchWithTerm("Restaurants", sort: .distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: Error!) -> Void in
         self.businesses = businesses
         
         for business in businesses {
         print(business.name!)
         print(business.address!)
         }
         }
         */
        let leftButton = UIBarButtonItem(title: "Filters", style: UIBarButtonItemStyle.plain, target: self, action: #selector(filtersButtonPressed))
        navigationItem.leftBarButtonItem = leftButton

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if businesses != nil {
            return businesses!.count
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as! BusinessTableViewCell
        cell.business = businesses[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //OPTIONAL#4 restaurant detail
    }
    
    
    // MARK: - SearchBar
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //        filteredBusinesses = searchText.isEmpty ? businesses : businesses  ...filter { (item: String) -> Bool in
        //            // If dataItem matches the searchText, return true to include it
        //            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
//        if let searchRestaurant = searchText {
//            filteredBusinesses = searchRestaurant.isEmpty ? businesses : businesses.filter({ (sthg: String) -> Bool in
//                return sthg.name.range(of: searchText, options: .caseInsensitive) != nil
//            })
//          
        Business.searchWithTerm(term: searchText) { (businesses: [Business]?, error: Error?) in
            self.businesses = businesses
        }
            businessTableView.reloadData()
        //        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        //reset field and unsearched results
        searchBar.showsCancelButton = false
        searchBar.sizeToFit()
        searchBar.text = ""
        searchBar.placeholder = "Restaurants"
        searchBar.resignFirstResponder()
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        //performSegue(withIdentifier: "modalToFilterVC", sender: self)

        
        //let nextNavC = storyboard?.instantiateViewController(withIdentifier: "FilterNav") as! UINavigationController
        let navigationVController = segue.destination as! UINavigationController
        let filtersVController = navigationVController.topViewController as! FiltersViewController
        filtersVController.delegate = self
    }
    
    //segue @programatically created button action
    @objc fileprivate func filtersButtonPressed() {
        performSegue(withIdentifier: "modalToFilterVC", sender: self)
    }
    
    func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: [String : AnyObject]) {
        var categories = filters["categories"] as? [String]
        Business.searchWithTerm(term: "Restaurants", sort: nil, categories: categories, deals: nil) { (businesses: [Business]!, error: Error?) in
            self.businesses = businesses
            self.businessTableView.reloadData()
        }
    }
    
}
