//
//  FACollectionViewBuilder.swift
//  Pilates
//
//  Created by Ferhat Abdullahoglu on 10.01.2020.
//  Copyright © 2020 Ferhat Abdullahoglu. All rights reserved.
//

import Foundation

public struct FACollectionViewBuilder {
    
    // MARK: - Properties
    //
    
    
    // MARK: - Private properties
    
    
    // MARK: - Public properties
    /// Singleton for all
    static let `default` = FACollectionViewBuilder()
    
    
    
    // MARK: - Initialization
    //
    private init() {}
    
    
    // MARK: - Methods
    //
    
    /// Register a FASection
    /// - Parameter section: Returns the just registered `FASectionView` in case the receiver needs it
    @discardableResult
    public func registerSection<T: CellConfig>(_ section: FASection<T>) -> FASectionView<T> {
        FASectionView(withSection: section)
    }
    
    // MARK: - Private methods
    
    
    // MARK: - Public methods
    
    
}

