//
//  DetailsViewController.swift
//  RickAndMorty
//
//  Created by Alexey Efimov on 03.03.2020.
//  Copyright © 2020 Alexey Efimov. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var chracterImageView: UIImageView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
//    @IBOutlet weak var statusLabel: UILabel!
//    @IBOutlet weak var speciesLabel: UILabel!
//    @IBOutlet weak var genderLabel: UILabel!
//    @IBOutlet weak var originLabel: UILabel!
//    @IBOutlet weak var locationLabel: UILabel!
//
    // MARK: - Public properties
    var chracter: Result!
    
    // MARK: - UIViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionLabel.text = chracter.description
        setupChracterImageView()
        view.backgroundColor = .black
        setupNavigationBar()
    }
    
    // MARK: - Private methods
    
    private func setupChracterImageView() {
        chracterImageView.layer.cornerRadius = chracterImageView.bounds.width / 2
        chracterImageView.backgroundColor = .white
            
        DispatchQueue.global().async {
            guard let imageData = ImageManager.shared.fetchImage(from: self.chracter.image) else { return }
            DispatchQueue.main.async {
                self.chracterImageView.image = UIImage(data: imageData)
            }
        }
    }
    
    private func setupNavigationBar() {
        title = chracter.name
        
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
    }
}
