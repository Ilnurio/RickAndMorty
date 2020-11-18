//
//  DetailsViewController.swift
//  RickAndMorty
//
//  Created by Alexey Efimov on 03.03.2020.
//  Copyright © 2020 Alexey Efimov. All rights reserved.
//

import UIKit

class CharcterDetailsViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var chracterImageView: UIImageView! {
        didSet {
            chracterImageView.layer.cornerRadius = chracterImageView.frame.width / 2
        }
    }
    @IBOutlet weak var descriptionLabel: UILabel!

    // MARK: - Public properties
    var result: Result?
    var charcterUrl: String!
    
    private var spinnerView: UIActivityIndicatorView!
    
    // MARK: - UIViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        spinnerView = showSpinner(in: view)
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
       
        NetworkManager.shared.fetchCharacter(from: charcterUrl) { result in
            self.result = result
            self.title = result.name
            self.descriptionLabel.text = result.description
            guard let imageData = ImageManager.shared.fetchImage(from: result.image) else { return }
            DispatchQueue.main.async {
                self.chracterImageView.image = UIImage(data: imageData)
                self.spinnerView.stopAnimating()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let episodesVC = navigationController.topViewController as! EpisodesViewController
        episodesVC.result = result
    }
    
    private func showSpinner(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .white
        activityIndicator.startAnimating()
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        
        view.addSubview(activityIndicator)
        
        return activityIndicator
    }
}