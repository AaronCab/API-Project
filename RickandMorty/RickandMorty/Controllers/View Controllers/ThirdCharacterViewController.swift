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
        thirdCharacterTableView.delegate = self
        searchBar.delegate = self
        searchBar.autocapitalizationType = .none
        searchPage(pageCount: "3")
        navigationController?.navigationBar.backgroundColor = UIColor.init(red: (105/255), green: (191/255), blue: (198/255), alpha: 1)
        
        navigationController?.tabBarController?.tabBar.barTintColor = UIColor.init(red: (105/255), green: (191/255), blue: (198/255), alpha: 1)

        let backButton = UIBarButtonItem()
        backButton.title = "Char 60"
        navigationItem.backBarButtonItem = backButton

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
        if indexPath.row % 2 == 1 {
            cell.backgroundColor = UIColor.init(red: (4/255), green: (213/255), blue: (136/255), alpha: 1)
        } else {
             cell.backgroundColor = UIColor.init(red: (52/255), green: (236/255), blue: (101/255), alpha: 1)

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
        cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
        UIView.animate(withDuration: 0.3, animations: {
            cell.layer.transform = CATransform3DMakeScale(1.05,1.05,1)
        },completion: { finished in
            UIView.animate(withDuration: 0.1, animations: {
                cell.layer.transform = CATransform3DMakeScale(1,1,1)
            })
        })
        return cell
    }
}

extension ThirdCharacterViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder() // dismiss the keyboard
        guard let searchText = searchBar.text,
            !searchText.isEmpty,
            let searchTextEncoded = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return searchPage(pageCount: "3")}
        results = results.filter{$0.name.contains(searchTextEncoded.capitalized)}
        
    }
}
extension ThirdCharacterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
}
