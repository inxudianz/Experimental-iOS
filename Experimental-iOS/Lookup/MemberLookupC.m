//
//  MemberLookupC.m
//  Experimental-iOS
//
//  Created by William Inx on 30/01/22.
//

#import <Foundation/Foundation.h>

#import "MemberLookupC.h"

#import <Experimental_iOS-Swift.h>

@implementation LookupTest

- (void)testLookup {
    Localizable *localizedTest = [Localizable new];
    
    Localizable *designated = [[[localizedTest objectForKeyedSubscript:@"start"] objectForKeyedSubscript:@"moduleA"] objectForKeyedSubscript:@"viewAA"];
    
    NSLog([[designated objectForKeyedSubscript:@"stringAAA"] localizedString]);
    NSLog([[designated objectForKeyedSubscript:@"stringAAA"] stringValue]);
}

@end
