//
//  MemberLookup.swift
//  Experimental-iOS
//
//  Created by William Inx on 29/01/22.
//

import Foundation

func readFile() -> [String : Any] {
    if let path = Bundle.main.path(forResource: "localize", ofType: "json") {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let json = try JSONSerialization.jsonObject(with: data, options: .json5Allowed)
            
            if let jsonResult = json as? [String : Any] {
                return jsonResult
            }
        }
        catch {
            return [:]
        }
    }
    
    return [:]
}

@objc @dynamicMemberLookup
public class Localizable: NSObject {
    private lazy var data: [String: Any] = {
        let data = readFile()
        
        return data
    }()
    
    private var dict: [String: Any]
    private let lastLookup: (key: String, value: Any?)
    
    @objc
    public override init() {
        dict = [:]
        lastLookup = ("", "")
    }
    
    private init(with dict: [String: Any], lastLookup: (key: String, value: Any?)) {
        self.dict = dict
        self.lastLookup = lastLookup
    }
      
    @objc
    public subscript(dynamicMember member: String) -> Localizable {
        if dict.isEmpty {
            dict = data
        }
        
        return .init(with: dict[member] as? [String: Any] ?? [:], lastLookup: (member, dict[member]))
    }
    
    @objc
    public var stringValue: String {
        if dict.count == .zero {
            return lastLookup.value as? String ?? ""
        }
        else {
            do {
                let json = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
                return String(data: json, encoding: .utf8) ?? ""
            }
            catch {
                return ""
            }
        }
    }
    
    @Localized
    private var localized: String
    
    @objc
    func localizedString() -> String {
        localized = stringValue
        
        return localized
    }
    
    @propertyWrapper
    class Localized {
        private var value: String = ""
        
        var wrappedValue: String {
            get {
                value
            }
            set {
                value = NSLocalizedString(newValue, comment: "")
            }
        }
    }
}


func tester() {
    let localize = Localizable()
    let localizeA: Localizable = localize.start.moduleA.viewAA.stringAAA
    
    let stringFormat = String(format: localize.start.moduleA.viewAA.stringAAAFormat.localizedString(),
                              "Format Use")
//    print(localizeA.localizedString())
    let lookup = LookupTest()
    lookup.testLookup()
}
