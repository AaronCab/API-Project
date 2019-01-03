//
//  FourthDetailViewController.swift
//  RickandMorty
//
//  Created by Aaron Cabreja on 1/1/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class FourthDetailViewController: UIViewController {
    
    public var resultFour: Result!

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
        nameLabel?.text = "Name: \(resultFour.name)"
        originLabel?.text = "Origin: \(resultFour.origin.name)"
        genderLabel?.text = "Gender: \(resultFour.gender)"
        locationLabel?.text = "Location: \(resultFour.location.name)"
        statusLabel?.text = "Status: \(resultFour.status)"
        
        if let url = resultFour?.image {
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
        view.backgroundColor = UIColor.init(red: (52/255), green: (236/255), blue: (101/255), alpha: 1)
    }
}
