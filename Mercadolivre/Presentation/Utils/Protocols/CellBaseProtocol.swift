//
//  CellBaseProtocol.swift
//  Mercadolivre
//
//  Created by Mahmoud Abdelshafi on 28/04/2022.
//

import Foundation
import UIKit

protocol CellBaseProtocol: AnyObject {
   static var reusableIdentifier: String { get }
    static var xibName: String { get }
}
