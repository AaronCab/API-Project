//
//  SecondCharacterViewController.swift
//  RickandMorty
//
//  Created by Aaron Cabreja on 1/1/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class SecondCharacterViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    
    @IBOutlet weak var secondCharacterTableView: UITableView!
   
    private var results = [Result](){
        didSet {
            DispatchQueue.main.async {
                self.secondCharacterTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        secondCharacterTableView.dataSource = self
        secondCharacterTableView.delegate = self
        searchBar.delegate = self
        searchBar.autocapitalizationType = .none
        searchPage(pageCount: "2")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = secondCharacterTableView.indexPathForSelectedRow,
            let characterDetailController = segue.destination as? SecondDetailViewController else { fatalError("indexPath, meeetupDetailController nil")}
        let result = results[indexPath.row]
        characterDetailController.resultTwo = result
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

extension SecondCharacterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "secondCell", for: indexPath)
        let result = results[indexPath.row]
        cell.textLabel?.text = result.name
        cell.detailTextLabel?.text = result.species
        cell.backgroundColor = UIColor.init(red: (10/255), green: (247/255), blue: (152/255), alpha: 1)
        return cell
    }
}

extension SecondCharacterViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder() // dismiss the keyboard
        guard let searchText = searchBar.text,
            !searchText.isEmpty,
            let searchTextEncoded = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
                return
        }
        
    }

}
extension SecondCharacterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
