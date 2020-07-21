//
//  ItemListModal.swift
//  POC
//
//  Created by Shashank on 21/07/20.
//  Copyright © 2020 Shashank. All rights reserved.
//

import UIKit

public struct ItemListModal: Codable {
    public var title : String?
    public var rows : [Rows]?
    
}
public class Rows: Codable {
    public let title : String?
    public let description : String?
    public let imageHref : String?
}
