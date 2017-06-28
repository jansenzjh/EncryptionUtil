//
//  PPMSProducts.swift
//  PPMS
//
//  Created by Jansen on 3/3/17.
//  Copyright © 2017 Jansen. All rights reserved.
//

import Foundation

public struct ProjectProducts {
    
    public static let PremiumAccessProduct = "com.jzsoft.PremiumAccess"
    
    fileprivate static let productIdentifiers: Set<ProductIdentifier> = [ProjectProducts.PremiumAccessProduct]
    
    public static let store = IAPHelper(productIds: ProjectProducts.productIdentifiers)
}

func resourceNameForProductIdentifier(_ productIdentifier: String) -> String? {
    return productIdentifier.components(separatedBy: ".").last
}
