//
//  FASectionView.swift
//  Pilates
//
//  Created by Ferhat Abdullahoglu on 10.01.2020.
//  Copyright © 2020 Ferhat Abdullahoglu. All rights reserved.
//

import UIKit

/// Container view that handles the collectionView for its own `FASection`
///
/// With the data it receives from its section, this class implements a collectionView tied
/// to its bounds.
public class FASectionView<Cell> : UIView, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, CollectionViewBuilder where Cell: CellConfig {
    
    
    // MARK: - Properties
    //
    
    
    // MARK: - Private properties
    
    /// CollectionView
    internal var collectionView: UICollectionView!
    
    /// Layout for the collectionView
    internal var collectionViewLayout: UICollectionViewFlowLayout!
    
    /// Cell type
    internal var cellType: UICollectionViewCell.Type { Cell.self }
    
    /// Ident of the cell
    internal var cellIdent: String { Cell.ident }
    

    // MARK: - Public properties
    
    /// Section for view
    public var section: FASection<Cell>
    
    
    // MARK: - Initialization
    //
    /// Required initializer fot the view
    /// - Parameter section: `FASection<Cell>` that's contained by the view
    public required init(withSection section: FASection<Cell>) {
        self.section = section
        super.init(frame: .zero)
        _setupUI()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    
    // MARK: - Methods
    //
    
    // MARK: - UICollectionViewDataSource implementation
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.section.data?.count ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FASection<Cell>.CellType.ident, for: indexPath) as! FASection<Cell>.CellType
        
        cell.cellData = self.section.data[indexPath.row]
        
        // check the cornerRadius property
        cell.clipsToBounds = section.config.cellCornerRadius > 0
        cell.layer.cornerRadius = section.config.cellCornerRadius
        cell.contentView.clipsToBounds = cell.clipsToBounds
        cell.contentView.layer.cornerRadius = cell.layer.cornerRadius
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        section.config.preferredCellSize
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        self.section.config.itemSpacing
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        self.section.config.itemSpacing
    }
    
    
    
    // MARK: - Private methods
    /// Internal UI setup
    private func _setupUI() {
        
        // making use of the `CollectionViewBuilder` to setup the collectionView
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }

            self.setupCollectionView()
            
            self.collectionViewLayout.minimumInteritemSpacing = self.section.config.itemSpacing
            self.collectionViewLayout.sectionInset = .init(top: 0, left: self.section.config.itemSpacing, bottom: 0, right: 0)
        }
        
    }
    
    // MARK: - Public methods
    
    
}
