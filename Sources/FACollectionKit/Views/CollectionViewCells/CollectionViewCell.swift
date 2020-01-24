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
    
    /// Cell is setup with a view
    private var isCellSet = false
    
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
        if isCellSet { return }
        
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
            
            self.layoutIfNeeded()
            self.isCellSet = true 
        }
    }
    
    
    // MARK: - Public methods
    
    
}


#if canImport(SwiftUI)
import SwiftUI
#endif

@available(iOS 13, *)
public struct CollectionViewCellRepresentable: UIViewRepresentable {
    
    public typealias UIViewType = CollectionViewCell
    
    // cellData
    var cellData: UIView!
    
    public func makeCoordinator() -> CollectionViewCellCoordinator {
        CollectionViewCellCoordinator(cellData)
    }
    
    public func makeUIView(context: UIViewRepresentableContext<CollectionViewCellRepresentable>) -> CollectionViewCell {
        CollectionViewCell()
    }
    public func updateUIView(_ uiView: CollectionViewCell, context: UIViewRepresentableContext<CollectionViewCellRepresentable>) {
        uiView.cellData = context.coordinator.cellData
    }
    
}


public class CollectionViewCellCoordinator: NSObject{
    
    /// cell data
    var cellData: UIView!
    
    init(_ data: UIView) {
        self.cellData = data
    }
    
}


#if DEBUG
@available(iOS 13, *)
struct CollectionViewCell_Previews: PreviewProvider {
    
    static var previews: some View {
        let view = UIView()
        view.backgroundColor = .orange
        return CollectionViewCellRepresentable(cellData: view)
    }
}
#endif
