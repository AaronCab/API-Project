//
//  FirstDetailViewController.swift
//  RickandMorty
//
//  Created by Aaron Cabreja on 1/1/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class FirstDetailViewController: UIViewController {
    public var resultOne: Result!
    
    @IBOutlet weak var characterImage: UIImageView!
    

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var originLabel: UILabel!
    
    @IBOutlet weak var genderLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    private func updateUI(){
        nameLabel?.text = "Name: \(resultOne.name)"
        originLabel?.text = "Origin: \(resultOne.origin.name)"
        genderLabel?.text = "Gender: \(resultOne.gender)"
        locationLabel?.text = "Location: \(resultOne.location.name)"
        statusLabel?.text = "Status: \(resultOne.status)"
        
            if let url = resultOne?.image {
            ImageHelper.fetchImage(urlString: url) { (error, image) in
                if let error = error {
                    print(error.errorMessage())
                } else if let image = image {
                    self.characterImage.image = image
                }
            }
        } else {
            characterImage.image = UIImage(named: "rickM")
        }
        view.backgroundColor = UIColor.init(red: (10/255), green: (247/255), blue: (240/255), alpha: 1)
        
    }

}
