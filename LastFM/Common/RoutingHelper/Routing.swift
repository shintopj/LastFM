//
//  Routing.swift
//  LastFM
//
//  Created by Shinto Joseph on 31/07/2021.
//

import UIKit

/// Confirm routing protocol and define the storyboard name
protocol Routing: AnyObject {
    
    /// get the view controller instance from storyboard
    /// only storyboard supported now
    static func viewController<T: Routing>() -> T
    
    /// storyboard name should match with class name
    static var reuseIdentifier: String { get }
    
    /// name of storyboard to look for controller
    static var storyboardIdentifier: String { get }
}

extension Routing {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    // load the view controller from storyboard using the storyboard identifier
    static func viewController<T: Routing>() -> T {
        guard let vc = UIStoryboard(name: T.storyboardIdentifier, bundle: Bundle.main)
                .instantiateViewController(withIdentifier: T.reuseIdentifier) as? T else {
            fatalError("Could not instantiate \(T.reuseIdentifier) from \(T.storyboardIdentifier) storyboard")
        }
        return vc
    }
}
