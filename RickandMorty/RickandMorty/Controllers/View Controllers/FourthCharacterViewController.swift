//
//  FourthCharacterViewController.swift
//  RickandMorty
//
//  Created by Aaron Cabreja on 1/1/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class FourthCharacterViewController: UIViewController {

    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var fourthCharacterTableView: UITableView!
    
    private var results = [Result](){
        didSet {
            DispatchQueue.main.async {
                self.fourthCharacterTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fourthCharacterTableView.dataSource = self
        fourthCharacterTableView.delegate = self
        searchBar.delegate = self
        searchBar.autocapitalizationType = .none
        searchPage(pageCount: "4")
        navigationController?.navigationBar.backgroundColor = UIColor.init(red: (105/255), green: (191/255), blue: (198/255), alpha: 1)
        
        navigationController?.tabBarController?.tabBar.barTintColor = UIColor.init(red: (105/255), green: (191/255), blue: (198/255), alpha: 1)

        let backButton = UIBarButtonItem()
        backButton.title = "Char 80"
        navigationItem.backBarButtonItem = backButton

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = fourthCharacterTableView.indexPathForSelectedRow,
            let characterDetailController = segue.destination as? FourthDetailViewController else { fatalError("indexPath, meeetupDetailController nil")}
        let result = results[indexPath.row]
        characterDetailController.resultFour = result
    }
    private func searchPage(pageCount: String) {
        APIClient.getCharacters(pageCount: pageCount) { (error, results) in
            if let error = error {
                print(error.errorMessage())
            } else if let results = results {
                self.results = results
            }
        }
    }
    
}

extension FourthCharacterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //1. Setup the CATransform3D structure
        var rotation = CATransform3DMakeRotation( CGFloat((90.0 * M_PI)/180), 0.0, 0.7, 0.4);
        rotation.m34 = 1.0 / -600
        
        //2. Define the initial state (Before the animation)
        cell.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
        cell.alpha = 0;
        cell.layer.transform = rotation;
        cell.layer.anchorPoint = CGPoint(x: 0.0, y: 0.5)
        
        //3. Define the final state (After the animation) and commit the animation
        cell.layer.transform = rotation
        UIView.animate(withDuration: 0.8, animations:{cell.layer.transform = CATransform3DIdentity})
        cell.alpha = 1
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        UIView.commitAnimations()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fourthCell", for: indexPath)
        let result = results[indexPath.row]
        cell.textLabel?.text = result.name
        cell.detailTextLabel?.text = result.species
        if indexPath.row % 2 == 1 {
           cell.backgroundColor = UIColor.init(red: (52/255), green: (236/255), blue: (101/255), alpha: 1)

        } else {
            cell.backgroundColor = UIColor.init(red: (136/255), green: (185/255), blue: (240/255), alpha: 1)

        }
        let url = result.image
        ImageHelper.fetchImage(urlString: url) { (error, image) in
            if let error = error {
                print(error.errorMessage())
            } else if let image = image {
                cell.imageView?.image = image
            }
        }
        cell.imageView?.layer.cornerRadius = 65
      
        return cell
    }
}

extension FourthCharacterViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder() // dismiss the keyboard
        guard let searchText = searchBar.text,
            !searchText.isEmpty,
            let searchTextEncoded = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return searchPage(pageCount: "4")}
        results = results.filter{$0.name.contains(searchTextEncoded.capitalized)}
        
    }

}
extension FourthCharacterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
}
