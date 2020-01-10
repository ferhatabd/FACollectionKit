//
//  CollectionViewBuilder.swift
//  Pilates
//
//  Created by Ferhat Abdullahoglu on 10.01.2020.
//  Copyright © 2020 Ferhat Abdullahoglu. All rights reserved.
//

import UIKit

/// CollectionView builder helper protocol
internal protocol CollectionViewBuilder where Self: UIView & UICollectionViewDelegate & UICollectionViewDataSource {
    
    // MARK: - Properties
    //
    
    
    // MARK: - Private properties

    
    // MARK: - Public properties
    
    /// CollectionView
    var collectionView: UICollectionView! { get set }
    
    /// Layout for the collection view
    var collectionViewLayout: UICollectionViewFlowLayout! { get set }
    
    var cellType: UICollectionViewCell.Type { get }
    
    var cellIdent: String { get }
    
    
    
    
    // MARK: - Methods
    //
    /// Method that initializes the collectionView
    ///
    /// The defalut implementation initializes the collectionView, adds it to
    /// the view hierararchy as the base view
    /// then ties to the bounds of the view
    func setupCollectionView() -> Void
    
    // MARK: - Private methods
    
    
    // MARK: - Public methods
    
    
}

// MARK: - Default implementation
internal extension CollectionViewBuilder {
    /// Default implementation of the `setupCollectionView()`
    func setupCollectionView() {
        
        // Dispatch to the Main queue
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            // create the layout
            self.collectionViewLayout = UICollectionViewFlowLayout()
            self.collectionViewLayout.scrollDirection = .horizontal
            
            //
            // create the collectionView
            //
            self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.collectionViewLayout)
            self.collectionView.translatesAutoresizingMaskIntoConstraints = false
            self.collectionView.backgroundColor = .clear
            self.collectionView.delegate = self
            self.collectionView.dataSource = self
            
            // register the cell
            self.collectionView.register(self.cellType, forCellWithReuseIdentifier: self.cellIdent)
          
            
            // add the collectionView & constraints
            self.insertSubview(self.collectionView, at: 0)
            
            self.collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            self.collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            self.collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            self.collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            
        } // end of the dispatch
        
        
    }
}

