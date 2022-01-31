//
//  BigDataResolver.swift
//  Experimental-iOS
//
//  Created by William Inx on 30/01/22.
//

import Foundation

// DP to handle big data
let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

func getLetter() -> String {
    letters.randomElement()?.uppercased() ?? "Failed"
}

var bigValue: [String] = .init(repeating: "Value", count: 10000)
var bigValue2: [String] = .init(repeating: "Value", count: 10000000)


func underEstimate() {
    let initialCapacity = bigValue2.underestimatedCount
    var array = ContiguousArray<String>()
    
    var iterator = bigValue2.makeIterator()
    
    for _ in 0..<initialCapacity {
        array.append(iterator.next()!)
    }
    
    while let element = iterator.next() {
        array.append(element)
    }
}

func underEstimateOld() {
    var array: [String] = []
    
    array.append(contentsOf: bigValue2)
}

func underEstimateOld2() {
    var array: [String] = []
    
    for value in bigValue2 {
        array.append(value)
    }
}

func completion() {
    let startTime = DispatchTime.now()
    
    doBigValue {
        print("done")
        let endTime = DispatchTime.now()
        let timeInNanoSecond = endTime.uptimeNanoseconds - startTime.uptimeNanoseconds
        let timeInterval = Double(timeInNanoSecond) / 1_000_000_000
        print("Time elapsed: \(timeInterval) second(s)")
    }
    // +- 5s
}

func completionOld() {
    bigValue.forEach { _ in
        bigValue = bigValue.map { $0.lowercased() }
    }
    // +- 20s
}
func doBigValue(completion: @escaping (() -> Void)) {
    let bigValueCount = bigValue.count
    let half = bigValueCount / 2
    var lowerhalf = bigValue[0...half]
    var upperhalf = bigValue[half...bigValueCount - 1]
    
    var lowerFin = false
    var upperFin = false
    
    DispatchQueue.global().async {
        var lowerhalfArr = Array(lowerhalf)
        lowerhalfArr.forEach { _ in
            lowerhalfArr = lowerhalfArr.map({ $0.lowercased() })
        }
        
        lowerFin = true
        print("finished 1")
        
        if lowerFin && upperFin {
            completion()
        }
    }
    
    DispatchQueue.global().async {
        var upperhalfArr = Array(upperhalf)
        upperhalfArr.forEach { _ in
            upperhalfArr = upperhalfArr.map({ $0.lowercased() })
        }
        
        upperFin = true
        print("finished 2")
        
        if lowerFin && upperFin {
            completion()
        }
    }
}

@discardableResult
func calculateTimeElapsed(for function: (() -> Void),
                          shouldPrintResult: Bool) -> String {
    let startTime = DispatchTime.now()
    
    function()
    
    let endTime = DispatchTime.now()
    
    
    let timeInNanoSecond = endTime.uptimeNanoseconds - startTime.uptimeNanoseconds
    let timeInterval = Double(timeInNanoSecond) / 1_000_000_000
    if shouldPrintResult {
        print("Time elapsed: \(timeInterval) second(s)")
    }
    
    return "Time elapsed: \(timeInterval) second(s)"
}
