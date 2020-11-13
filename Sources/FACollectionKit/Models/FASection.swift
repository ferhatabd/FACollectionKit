//
//  TestSection.swift
//  Pilates
//
//  Created by Ferhat Abdullahoglu on 8.01.2020.
//  Copyright © 2020 Ferhat Abdullahoglu. All rights reserved.
//

import UIKit

/// Appearence config of the section
public struct FASectionConfig {
    
    /// Section title
    public var title: String = ""
    
    /// Preferred cell size
    public var preferredCellSize: CGSize = .zero
    
    /// Header title color
    public var titleColor: UIColor = .black
    
    /// Title font
    public var titleFont: UIFont = .systemFont(ofSize: 18)
    
    /// If there is  a title, a detail button with the matching title will be displayed
    public var detailTitle: String? = nil
    
    /// Font for the detail button title
    public var detailTitleFont: UIFont = .systemFont(ofSize: 14)
    
    /// Color for the detail button title
    public var detailTitleColor: UIColor = .black
    
    /// Cell radius
    public var cellCornerRadius: CGFloat = 0
    
    /// Item spacing within the same row 
    public var itemSpacing: CGFloat = 20
    
    /// Flag to check if there is a need for a CollectionViewHeader
    public var needsHeader: Bool { !title.isEmpty }
    
    /// Header alignment
    public var headerAlignment: UIControl.ContentVerticalAlignment = .top
    
    /// Section index -- must match with the corresponding section's ident
    public var ident: Int = 0
    
    public init() {}
    
}

open class FASection<CellType>: NSObject, SectionConfig, AnySection where CellType: CellConfig {
    
    // MARK: - Properties
    
    /// Section configuration
    public var config = FASectionConfig()
    
    // MARK: - Public properties
    /// Data container of the section
    ///
    /// The generic limitiatoin is that the datatype here should match with the datatype of the cell
    public var data: [CellType.CellData]!
    
    
    /// Section ident
    ///
    /// It's the main ID of the section, all the datasource & delegate events will be
    /// fired with this ident
    public var ident: Int
    
    /// Might be used for special ordering
    ///
    /// Defaults to 0
    public var orderedId: Int = 0
    
    
    // MARK: - Initialization
    public init<T: CellConfig>(cellType: T.Type, withIdent id: Int) {
        self.ident = id
    }
    
    // MARK: - Methods
    
    // MARK: - Public methods
    
    /// Change the active configuration for the UI
    /// - Parameter config: New `FASectionConfig`to be set
    public func setConfig(_ config: FASectionConfig) {
        self.config = config
    }
    
}
