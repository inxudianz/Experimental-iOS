//
//  BaseFactory.swift
//  Experimental-iOS
//
//  Created by William Inx on 30/01/22.
//

import Foundation

// factory

class BaseFactory {
    static func createCoordinator() -> BaseCoordinator {
        BaseBuilder.CoordinatorBuilder.buildCoordinator()
    }
    
    static func createVC() -> BaseViewController {
        BaseBuilder.VCBuilder.buildVC()
    }
    
    static func createVM() -> BaseViewModel {
        BaseBuilder.VMBuilder.buildVM()
    }
}
