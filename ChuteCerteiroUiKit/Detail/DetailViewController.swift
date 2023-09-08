//
//  DetailViewController.swift
//  ChuteCerteiroUiKit
//
//  Created by Marcos Abreu on 08/09/23.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var countryImageView: UIImageView!
    
    var country: Country!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        countryImageView.layer.cornerRadius = 8
        countryImageView.layer.masksToBounds = true
        countryImageView.contentMode = .scaleAspectFill
        countryImageView.backgroundColor = .blue

        configure(with: country)
    }

    func configure(with country: Country) {
        countryName.text = country.countryName
        countryImageView.download(path: country.countryLogo)
    }
}
