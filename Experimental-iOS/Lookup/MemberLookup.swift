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
    
    private static let localizableSeparator = "->"
    
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
        
        let separatedMembers = member.components(separatedBy: Self.localizableSeparator)
        
        var lookedUpDict: [String: Any]? = nil
        var lookedUpInfo: (key: String, value: Any?)? = nil
        
        if separatedMembers.count > 1 {
            for separatedMember in separatedMembers {
                if lookedUpDict != nil {
                    if let lastLookedUpDict = lookedUpDict {
                        if let lookUpDict = lastLookedUpDict[separatedMember] as? [String: Any] {
                            lookedUpDict = lookUpDict
                            lookedUpInfo = (separatedMember, lookedUpDict)
                            continue
                        }
                        else {
                            lookedUpDict = lastLookedUpDict[separatedMember] as? [String : Any] ?? [:]
                            lookedUpInfo = (separatedMember, lastLookedUpDict[separatedMember])
                        }
                    }
                }
                else if let lookupDict = dict[separatedMember] as? [String : Any] {
                    lookedUpDict = lookupDict
                    lookedUpInfo = (separatedMember, lookedUpDict)
                    continue
                }
                break
            }
        }
        
        if lookedUpDict != nil || lookedUpInfo != nil {
            return .init(with: lookedUpDict ?? [:], lastLookup: lookedUpInfo ?? ("",""))
        }
        else {
            return .init(with: dict[member] as? [String: Any] ?? [:], lastLookup: (member, dict[member]))
        }
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
//        let localize = Localizable()
//        let localizeA: Localizable = localize.start.moduleA.viewAA.stringAAA
//    //
//    //    let stringFormat = String(format: localize.start.moduleA.viewAA.stringAAAFormat.localizedString(),
//    //                              "Format Use")
//    //
//        print(localizeA.localizedString())
    let lookup = LookupTest()
    lookup.testLookup()
}
