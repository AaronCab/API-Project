//
//  FifithDetailViewController.swift
//  RickandMorty
//
//  Created by Aaron Cabreja on 1/1/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class FifithDetailViewController: UIViewController {
    public var resultFive: Result!

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
        nameLabel?.text = "Name: \(resultFive.name)"
        originLabel?.text = "Origin: \(resultFive.origin.name)"
        genderLabel?.text = "Gender: \(resultFive.gender)"
        locationLabel?.text = "Location: \(resultFive.location.name)"
        statusLabel?.text = "Status: \(resultFive.status)"
        
        if let url = resultFive?.image {
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
        view.backgroundColor =  UIColor.init(red: (136/255), green: (185/255), blue: (240/255), alpha: 1)
    }

}
