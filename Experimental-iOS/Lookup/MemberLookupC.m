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
    
    Localizable *designatedX = [localizedTest objectForKeyedSubscript:@"start->moduleA->viewAA"];
    
    NSLog([[designatedX objectForKeyedSubscript:@"stringAAA"] localizedString]);
    NSLog([[designatedX objectForKeyedSubscript:@"stringAAA"] stringValue]);
}

@end
