//
//  File.swift
//  
//
//  Created by Ferhat Abdullahoglu on 11.01.2020.
//

import UIKit


public protocol CollectionViewHeaderDelegate: AnyObject {
    /// Will be fired when the detail button of a header is tapped
    /// - Parameters:
    ///   - button: Button that's tapped
    ///   - section: Section index the header belongs to
    func didDetailButtonTapped(_ button: UIButton, section: Int) -> Void
}

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
    
    /// Button that will be used as the detail indicator if there is any
    @usableFromInline
    internal var btnDetail: UIButton!
    
    
    // MARK: - Public properties
    
    /// Ident for the header
    open class var ident: String { "faMainCollectionHeader" }
    
    /// Current section config
    public var sectionConfig = FASectionConfig()
    
    /// The delegate
    public weak var delegate: CollectionViewHeaderDelegate?
    
    
    // MARK: - Initialization
    //
    
    // MARK: - Methods
    //
    
    // MARK: - Private methods
    
    @objc
    private func btnDetailAction(_ sender: UIButton) {
        delegate?.didDetailButtonTapped(sender, section: sectionConfig.ident)
    }
    
    // MARK: - Internal methods
    
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
        
        //
        // check if there is a need for a detail indicator
        //
        if let title = sectionConfig.detailTitle { // a title is configured, create the detail button
            btnDetail?.removeFromSuperview()
            btnDetail = UIButton(type: .custom)
            btnDetail.translatesAutoresizingMaskIntoConstraints = false
            btnDetail.setTitle(title, for: .normal)
            btnDetail.setTitleColor(sectionConfig.detailTitleColor, for: .normal)
            btnDetail.setTitleColor(sectionConfig.detailTitleColor.withAlphaComponent(0.2), for: .highlighted)
            btnDetail.setTitleColor(sectionConfig.detailTitleColor.withAlphaComponent(0.2), for: .selected)
            btnDetail.titleLabel?.font = sectionConfig.detailTitleFont
            //
            addSubview(btnDetail)
            //
            btnDetail.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding.right).isActive = true
            btnDetail.topAnchor.constraint(equalTo: topAnchor, constant: padding.top).isActive = true
            //
            btnDetail.addTarget(self, action: #selector(btnDetailAction(_:)), for: .touchUpInside)
        } else {
            btnDetail?.removeFromSuperview()
        }
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



#if canImport(SwiftUI)
import SwiftUI
#endif

@available(iOS 13, *)
public struct CollectionViewHeaderRepresentable: UIViewRepresentable{
    
    public typealias UIViewType = CollectionViewHeader
    
    var sectionConfig: FASectionConfig
    
    public func makeCoordinator() -> CollectionViewHeaderCoordinator {
        CollectionViewHeaderCoordinator(sectionConfig)
    }
    
    public func makeUIView(context: UIViewRepresentableContext<CollectionViewHeaderRepresentable>) -> CollectionViewHeader {
        CollectionViewHeader()
    }
    
    public func updateUIView(_ uiView: CollectionViewHeader, context: UIViewRepresentableContext<CollectionViewHeaderRepresentable>) {
        uiView.sectionConfig = context.coordinator.config
    }
}


public class CollectionViewHeaderCoordinator: NSObject {
    
    var config: FASectionConfig
    
    init(_ config: FASectionConfig) {
        self.config = config
    }
    
}

#if DEBUG
@available(iOS 13, *)
public struct CollectionViewHeader_Previews: PreviewProvider {
   
    public static var previews: some View {
        CollectionViewHeaderRepresentable(sectionConfig: .init())
    }
    
}
#endif


