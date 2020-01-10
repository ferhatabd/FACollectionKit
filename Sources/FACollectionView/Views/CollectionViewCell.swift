//
//  CollectionViewCell.swift
//  Pilates
//
//  Created by Ferhat Abdullahoglu on 10.01.2020.
//  Copyright © 2020 Ferhat Abdullahoglu. All rights reserved.
//

import UIKit

public class CollectionViewCell: UICollectionViewCell, CellConfig {
    
    
    // MARK: - Properties
    //
    
    
    // MARK: - Private properties
    
    
    // MARK: - Public properties
    /// Section view to be added as a subview
    public var cellData: UIView! {
        didSet {
            if cellData != nil {
                setUI(fromView: oldValue, toView: cellData)
            }
        }
    }
    
    /// Cell ident
    public static var ident: String { "faMainCollectionViewCell" }
    
    
    // MARK: - Initialization
    //
    
    
    
    // MARK: - Methods
    //
    
    
    // MARK: - Private methods
    /// Internal UI Setup
    private func setUI(fromView from: UIView?, toView to: UIView) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            // remove the old view
            from?.removeFromSuperview()
            
            // add the new view and configure it
            to.translatesAutoresizingMaskIntoConstraints = false
            to.clipsToBounds = true
            self.contentView.addSubview(to)
            to.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            to.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            to.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            to.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            
        }
    }
    
    
    // MARK: - Public methods
    
    
}

