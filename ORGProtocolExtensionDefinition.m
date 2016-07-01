//
//  ORGProtocolExtensionDefinition.m
//  Mixin
//
//  Created by Kyosuke Kameda on 2016/07/01.
//  Copyright © 2016年 Kyosuke Kameda. All rights reserved.
//

#import "ORGProtocolExtensionDefinition.h"

@interface ORGProtocolExtensionDefinition()
@property(nonatomic, nonnull, copy) NSString *protocolName;
@property(nonatomic, nonnull, strong) NSMutableDictionary<NSString*, id> *implementation;
@end

@implementation ORGProtocolExtensionDefinition

+ (nonnull instancetype)definitionWithProtocolName:(nonnull NSString*)protocolName
{
    ORGProtocolExtensionDefinition *instance = [[ORGProtocolExtensionDefinition alloc] initWithProtocolName:protocolName];
    NSAssert(instance != nil, @"[[ORGProtocolExtensionDefinition alloc] initWithProtocolName:...] fail");
    return instance;
}

- (void)addImplementationWithSelectorString:(nonnull NSString*)SelectorString block:(nonnull id)block;
{
    self.implementation[SelectorString] = [block copy];
}

#pragma mark - Private
- (nullable instancetype)initWithProtocolName:(nonnull NSString*)protocolName
{
    self = [super init];
    if(self != nil){
        self.protocolName = protocolName;
        self.implementation = [NSMutableDictionary dictionary];
    }
    return self;
}

@end
