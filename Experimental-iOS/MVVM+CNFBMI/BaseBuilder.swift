//
//  BaseBuilder.swift
//  Experimental-iOS
//
//  Created by William Inx on 30/01/22.
//

import Foundation

// all builder

class BaseBuilder {
    
    class VCBuilder {
        static func buildVC() -> BaseViewController {
            .init()
        }
    }
    
    class VMBuilder {
        static func buildVM() -> BaseViewModel {
            .init()
        }
    }
    
    class CoordinatorBuilder {
        static func buildCoordinator() -> BaseCoordinator {
            .init()
        }
    }
    
    class NetworkBuilder {
        static func buildNetwork() -> BaseNetwork {
            .init()
        }
    }
}
