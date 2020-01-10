//
//  TestSection.swift
//  Pilates
//
//  Created by Ferhat Abdullahoglu on 8.01.2020.
//  Copyright © 2020 Ferhat Abdullahoglu. All rights reserved.
//

import UIKit

open class FASection<CellType>: NSObject, SectionConfig where CellType: CellConfig {

    // MARK: - Properties
    /// Data container of the section
    ///
    /// The generic limitiatoin is that the datatype here should match with the datatype of the cell
    public var data: [CellType.CellData]!
    
    /// Section ident
    ///
    /// It's the main ID of the section, all the datasource & delegate events will be
    /// fired with this ident
    public var ident: Int
    
    
    // MARK: - Initialization
    public init<T: CellConfig>(cellType: T.Type, withIdent id: Int) {
        self.ident = id
    }
    
}
