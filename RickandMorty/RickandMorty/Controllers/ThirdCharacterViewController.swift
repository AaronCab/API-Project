//
//  ThirdCharacterViewController.swift
//  RickandMorty
//
//  Created by Aaron Cabreja on 1/1/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ThirdCharacterViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var thirdCharacterTableView: UITableView!
    
    private var results = [Result](){
        didSet {
            DispatchQueue.main.async {
                self.thirdCharacterTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        thirdCharacterTableView.dataSource = self
        searchBar.delegate = self
        searchBar.autocapitalizationType = .none
        searchPage(pageCount: "3")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = thirdCharacterTableView.indexPathForSelectedRow,
            let characterDetailController = segue.destination as? ThirdDetailViewController else { fatalError("indexPath, meeetupDetailController nil")}
        let result = results[indexPath.row]
        characterDetailController.resultThree = result
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

extension ThirdCharacterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "thirdCell", for: indexPath)
        let result = results[indexPath.row]
        cell.textLabel?.text = result.name
        cell.detailTextLabel?.text = result.species
        cell.backgroundColor = UIColor.init(red: (4/255), green: (213/255), blue: (136/255), alpha: 1)
        return cell
    }
}

extension ThirdCharacterViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder() // dismiss the keyboard
        guard let searchText = searchBar.text,
            !searchText.isEmpty,
            let searchTextEncoded = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
                return
        }
        
    }

}
