//
//  ORGProtocolExtensionDefinition.h
//
//  Created by Kyosuke Kameda on 2016/07/01.
//  Copyright © 2016年 Kyosuke Kameda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ORGProtocolExtensionDefinition : NSObject

+ (nonnull instancetype)definitionWithProtocolName:(nonnull NSString*)protocolName;

- (void)addImplementationWithSelectorString:(nonnull NSString*)SelectorString block:(nonnull id)block;

@property(nonatomic, nonnull, copy, readonly) NSString *protocolName;
@property(nonatomic, nonnull, strong, readonly) NSMutableDictionary<NSString*, id> *implementation;

@end
