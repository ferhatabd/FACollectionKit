//
//  SectionConfig.swift
//  Pilates
//
//  Created by Ferhat Abdullahoglu on 8.01.2020.
//  Copyright © 2020 Ferhat Abdullahoglu. All rights reserved.
//

import UIKit

public protocol AnySection {
    /// Section ident
    var ident: Int { get }
    
    /// Section confriguration 
    var config: FASectionConfig { get set }
}


/// Main rules that define a `Section`
internal protocol SectionConfig: AnyObject {
    
    /// Data type of the section
    ///
    /// Ideally it would be an array of the `CellData` that's defined within the `CellConfig` protocol
    associatedtype SectionData
    
    /// Cell type config
    associatedtype CellType: CellConfig
    
    /// Section data
    var data: [SectionData]! { get set }
    
  
}

