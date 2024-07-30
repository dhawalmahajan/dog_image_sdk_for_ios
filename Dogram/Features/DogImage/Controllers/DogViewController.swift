//
//  ViewController.swift
//  Dogram
//
//  Created by Dhawal Mahajan on 30/07/24.
//

import UIKit


class DogViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var numberInput: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    private let viewModel: DogViewModel = DogViewModel()
         
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func nextTapped(_ sender: UIButton) {
        Task {
            imageView.image = await viewModel.getNextImage()
            
        }
    }
    @IBAction func previousTapped(_ sender: UIButton) {
        Task {
            imageView.image = await viewModel.getPreviousImage()
        }
    }
    
    @IBAction func submitTapped(_ sender: UIButton) {
        guard let count = Int( numberInput.text ?? "0") else { return }
        let vc = DogListController(with: .init(imageCount: count, dogLibrary: viewModel.dogLibrary))
        navigationController?.pushViewController(vc, animated: true)

    }
}

