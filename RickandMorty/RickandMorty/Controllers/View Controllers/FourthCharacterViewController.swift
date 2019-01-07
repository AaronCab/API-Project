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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fourthCell", for: indexPath)
        let result = results[indexPath.row]
        cell.textLabel?.text = result.name
        cell.detailTextLabel?.text = result.species
        if indexPath.row % 2 == 1 {
           cell.backgroundColor = UIColor.init(red: (52/255), green: (236/255), blue: (101/255), alpha: 1)
            cell.imageView?.image = UIImage(named: "Rick-and-Morty-S02E06-The-Ricks-Must-Be-Crazy-Peace-Among-Worlds")

        } else {
            cell.backgroundColor = UIColor.init(red: (136/255), green: (185/255), blue: (240/255), alpha: 1)
            cell.imageView?.image = UIImage(named: "rick_and_morty_s02_still.0")

        }
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
        return 100
    }
}
