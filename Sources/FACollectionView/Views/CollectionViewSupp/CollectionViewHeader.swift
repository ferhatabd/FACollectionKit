//
//  File.swift
//  
//
//  Created by Ferhat Abdullahoglu on 11.01.2020.
//

import UIKit

/// Reusable headerView for CollectionViews
///
/// It's designed to be used as a means to supply titles, but it's possible
/// to subclass and modify it
///
/// - Important: Currently not usable via Storyboards
open class CollectionViewHeader: UICollectionReusableView {
    
    // MARK: - Properties
    //
    
    
    // MARK: - Private properties
    /// Label for the title
    @usableFromInline
    internal var lblTitle: UILabel!
    
    @usableFromInline
    internal var padding: UIEdgeInsets = .zero
    
    
    // MARK: - Public properties
    
    /// Ident for the header
    open class var ident: String { "faMainCollectionHeader" }
    
    /// Current section config
    public var sectionConfig = FASectionConfig()
    
    
    // MARK: - Initialization
    //
    
    // MARK: - Methods
    //
    
    // MARK: - Private methods
    
    /// Initial setup for the UI components
    internal func _setupUI() {
        if lblTitle == nil {
            lblTitle = UILabel()
            lblTitle.translatesAutoresizingMaskIntoConstraints = false
            lblTitle.backgroundColor = .clear
            lblTitle.numberOfLines = 1
            lblTitle.font = sectionConfig.titleFont
            lblTitle.textColor = sectionConfig.titleColor
            lblTitle.textAlignment = .left
            
            addSubview(lblTitle)
        }
        
        lblTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding.left).isActive = true
        lblTitle.topAnchor.constraint(equalTo: topAnchor, constant: padding.top).isActive = true
        lblTitle.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, constant: -(padding.left + padding.right)).isActive = true
    
    }
    
    /// Updates the UI with the current config
    internal func _updateUI() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self._setupUI()
            self.lblTitle.text = self.sectionConfig.title
        }
    }
    
    // MARK: - Public methods
    
    /// Set or update the header config
    ///
    ///     As the method ends, it will update the current UI 
    ///
    /// - Parameters:
    ///   - config: New config to be set
    ///   - padding: New padding
    public func setConfig(_ config: FASectionConfig, padding: UIEdgeInsets = .init(top: 4, left: 4, bottom: 4, right: 4)) {
        self.sectionConfig = config
        self.padding = padding
        _updateUI()
    }
    
    
}

