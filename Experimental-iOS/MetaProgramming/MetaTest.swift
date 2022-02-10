//
//  MetaTest.swift
//  Experimental-iOS
//
//  Created by William Inx on 10/02/22.
//

import Foundation

protocol AutoEquatable { }


struct Person: AutoEquatable {
    var age: Int
    var name: String
}
