//
//  FASectionView.swift
//  Pilates
//
//  Created by Ferhat Abdullahoglu on 10.01.2020.
//  Copyright © 2020 Ferhat Abdullahoglu. All rights reserved.
//

import UIKit

public typealias SectionId = Int
public typealias CellIndex = Int
public typealias ContentSize = CGSize
public typealias ContentView = UICollectionView
public typealias TapHandler<Cell: CellConfig> = (SectionId, CellIndex, Cell.CellData) -> ()
public typealias CellDidDequeue<Cell: CellConfig> = (Cell) -> ()
public typealias ShouldSelectCell<Cell: CellConfig> = (SectionId, CellIndex, Cell.CellData) -> Bool
public typealias ContentSizeChange = (ContentSize, SectionId) -> Void
public typealias ContentOffsetChange = (ContentView, SectionId) -> Void

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
    
    /// If the callback is set, it will be called once a cell is selected
    internal var onDidSelect: TapHandler<Cell>?
    
    /// If the callback is set, it will be called to check whether
    /// the cell should be selected
    internal var onShouldSelect: ShouldSelectCell<Cell>?
    
    /// Callback to be called whenever the contentSize changes
    internal var onSizeChange: ContentSizeChange?
    
    /// Callback to be called right after a cell is dequeued
    internal var onDidDequeue: CellDidDequeue<Cell>?
    
    /// Callback that's called when a longpress tap occurs on `Cell`
    internal var onLongPressDidSelect: TapHandler<Cell>?
    
    /// Callback to be called when content offset changes
    internal var onOffsetChange: ContentOffsetChange?
    
    internal var _scrollDirection: UICollectionView.ScrollDirection
    
    /// The implemented collectionView's scrolling is enabled or not
    internal var isScrollEnabled: Bool
    

    // MARK: - Public properties
    
    public var id: Int
    
    /// Section for view
    public var section: FASection<Cell>
    
    var scrollDirection: UICollectionView.ScrollDirection { _scrollDirection }
    
    /// Collection view's top anchor constraint
    var topConstraint: NSLayoutConstraint!
    
    /// Collection view's leading anchor constraint
    var leadingConstraint: NSLayoutConstraint!
    
    /// Collection view's trailing anchor constraint
    var trailingConstraint: NSLayoutConstraint!
    
    /// Collection view's bottom anchor constraint
    var bottomConstraint: NSLayoutConstraint!
    
    /// Collectionview height constraint
    ///
    /// - warning: Might be nil depending on the current configuration
    var heightConstraint: NSLayoutConstraint?
    
    /// Collectionview width constraint
    ///
    /// - warning: Might be nil depending on the current configuration
    var widthConstraint: NSLayoutConstraint?
    
    public var contentSize: CGSize {
        collectionView?.contentSize ?? .zero
    }
    
    // MARK: - Initialization
    //
    /// Required initializer fot the view
    /// - Parameter section: `FASection<Cell>` that's contained by the view
    public required init(withSection section: FASection<Cell>,
                         direction: UICollectionView.ScrollDirection = .horizontal,
                         isScrollable: Bool = true) {
        self.section = section
        self.id = section.ident
        self.isScrollEnabled = isScrollable
        self._scrollDirection = direction
        super.init(frame: .zero)
        _setupUI()
    }
    
    public required init?(coder: NSCoder) {
        preconditionFailure("Not implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        if !isScrollEnabled {
            switch scrollDirection {
            case .vertical:
                bottomConstraint.isActive = false
                heightConstraint?.isActive = false
                heightConstraint = collectionView.heightAnchor.constraint(equalToConstant: collectionView.contentSize.height)
                heightConstraint?.isActive = true
            case .horizontal:
                trailingConstraint.isActive = false
                widthConstraint?.isActive = false
                widthConstraint = collectionView.widthAnchor.constraint(equalToConstant: collectionView.contentSize.width)
                widthConstraint?.isActive = true 
            @unknown default:
                break
            }
        }
        onSizeChange?(collectionView.contentSize, id)
    }
    
    // MARK: - Methods
    //
    
    public func refresh() {
        collectionView?.reloadData()
    }
    
    
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
        cell.gradientColors = section.config.gradientColors
        cell.gradientLocations = section.config.gradientLocations
        cell.longPressTapHandler = { [weak self] (cell) in
            guard let self = self else { return }
            guard let indexPath = collectionView.indexPath(for: cell) else { return }
            self.onLongPressDidSelect?(self.section.ident, indexPath.row, self.section.data[indexPath.row])
        }
        
        onDidDequeue?(cell)
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        section.config.preferredCellSize
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
         self.section.config.interItemSpacing
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        self.section.config.lineSpacing
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let insets: UIEdgeInsets = {
            let insetTop = self.section.config.additionalInsets.top
            let insetLeft = self.section.config.additionalInsets.left
            let insetRight = self.section.config.additionalInsets.right
            let insetBottom = self.section.config.additionalInsets.bottom
            if scrollDirection == .horizontal {
                return UIEdgeInsets(top: insetTop,
                                    left: self.section.config.lineSpacing + insetLeft,
                                    bottom: insetBottom,
                                    right: self.section.config.lineSpacing + insetRight)
            } else {
                return UIEdgeInsets(top: self.section.config.interItemSpacing + insetTop,
                                    left: insetLeft,
                                    bottom: self.section.config.interItemSpacing + insetBottom,
                                    right: insetRight)
            }
        }()
        return insets
    }
    
    public func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        guard let shouldSelect = self.onShouldSelect else { return true }
        return shouldSelect(self.section.ident, indexPath.row, section.data[indexPath.row])
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onDidSelect?(self.section.ident, indexPath.row, section.data[indexPath.row])
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView === collectionView else { return }
        DispatchQueue.global(qos: .userInteractive).sync {
            self.onOffsetChange?(self.collectionView, self.id)
        }
    }
    
    // MARK: - Private methods
    /// Internal UI setup
    private func _setupUI() {
        self.setupCollectionView()
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.isScrollEnabled = self.isScrollEnabled
    }
    
    // MARK: - Public methods
    
    
    @discardableResult
    public func onDidSelect(_ callback: @escaping TapHandler<Cell>) -> FASectionView<Cell> {
        self.onDidSelect = callback
        return self
    }
    
    @discardableResult
    public func onShouldSelect(_ callback: @escaping ShouldSelectCell<Cell>) -> FASectionView<Cell> {
        self.onShouldSelect = callback
        return self
    }
    
    @discardableResult
    public func onSizeChange(_ callback: @escaping ContentSizeChange) -> FASectionView<Cell> {
        self.onSizeChange = callback
        return self 
    }
    
    @discardableResult
    public func onOffsetChange(_ callback: @escaping ContentOffsetChange) -> FASectionView<Cell> {
        self.onOffsetChange = callback
        return self 
    }
    
    @discardableResult
    public func onDequeue(_ callback: @escaping CellDidDequeue<Cell>) -> FASectionView<Cell> {
        self.onDidDequeue = callback
        return self
    }
    
    /// In case the long press is released while still within the cell
    /// boundaries the `callback` will be called with the
    /// cell that's tapped on as the input
    @discardableResult
    public func onLongGestureTap(_ callback: @escaping TapHandler<Cell>) -> FASectionView<Cell> {
        self.onLongPressDidSelect = callback
        return self
    }
}


#if canImport(SwiftUI)
import SwiftUI
#endif

@available(iOS 13, *)
public struct FASectionViewRepresentible<Cell>: UIViewRepresentable where Cell: CellConfig {
    
    public typealias UIViewType = FASectionView<Cell>
    
    @State
    public var section: FASection<Cell>
    
    public func makeCoordinator() -> FASectionViewCoordinator<Cell> {
        FASectionViewCoordinator(section: section)
    }
    
    public func makeUIView(context: UIViewRepresentableContext<FASectionViewRepresentible<Cell>>) -> FASectionView<Cell> {
        FASectionView(withSection: section)
    }
    
    public func updateUIView(_ uiView: FASectionView<Cell>, context: UIViewRepresentableContext<FASectionViewRepresentible<Cell>>) {
        uiView.section = context.coordinator.section
    }
    
}

public class FASectionViewCoordinator<Cell>: NSObject where Cell: CellConfig {
    
    public var section: FASection<Cell>
    
    init(section: FASection<Cell>) {
        self.section = section
    }
    
}
