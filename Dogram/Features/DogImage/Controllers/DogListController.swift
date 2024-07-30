//
//  DogListController.swift
//  Dogram
//
//  Created by Dhawal Mahajan on 30/07/24.
//

import Foundation
import UIKit
final class DogListViewModel {
    private(set) var images: [URL?] = []
    init(images: [URL?]) {
        self.images = images
    }
    
}
class DogListController: UIViewController {
    static let identifier = "DogListController"
    private let viewModel: DogListViewModel
    fileprivate lazy var collectionView: UICollectionView =  {
        let layout = UICollectionViewFlowLayout()
               layout.itemSize = CGSize(width: 100, height: 100) // Set the item size
               layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) // Set insets
               layout.minimumLineSpacing = 10
               layout.minimumInteritemSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(DogImageCollectionViewCell.self, forCellWithReuseIdentifier: DogImageCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
               collectionView.delegate = self
        return collectionView
    }()
    init(with viewModel: DogListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
    }
    private func setUpCollectionView() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo:view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo:view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo:view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo:view.bottomAnchor)
                ])
    }
}

extension DogListController: UICollectionViewDelegate,  UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DogImageCollectionViewCell.identifier, for: indexPath) as? DogImageCollectionViewCell else { return UICollectionViewCell()}
           return cell
    }
    
    
}
