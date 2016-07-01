//
//  ORGProtocolExtension.h
//
//  Created by Kyosuke Kameda on 2016/07/01.
//  Copyright © 2016年 Kyosuke Kameda. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ORGProtocolExtensionDefinition;
@interface ORGProtocolExtension : NSObject

- (void)addDefinition:(nonnull ORGProtocolExtensionDefinition*)definition;
- (void)apply;

@end
