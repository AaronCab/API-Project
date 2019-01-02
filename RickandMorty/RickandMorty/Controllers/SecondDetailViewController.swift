//
//  SecondDetailViewController.swift
//  RickandMorty
//
//  Created by Aaron Cabreja on 1/1/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class SecondDetailViewController: UIViewController {
    public var resultTwo: Result!
    
    @IBOutlet weak var characterImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    @IBOutlet weak var genderLabel: UILabel!
    
    @IBOutlet weak var originLabel: UILabel!
    
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        // Do any additional setup after loading the view.
    }
    
    private func updateUI(){
        nameLabel?.text = "Name: \(resultTwo.name)"
        originLabel?.text = "Origin: \(resultTwo.origin.name)"
        genderLabel?.text = "Gender: \(resultTwo.gender)"
        locationLabel?.text = "Location: \(resultTwo.location.name)"
        statusLabel?.text = "Status: \(resultTwo.status)"
        
        if let url = resultTwo?.image {
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
        
    }

}
