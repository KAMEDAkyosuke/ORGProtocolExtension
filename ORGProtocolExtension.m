//
//  ORGProtocolExtension.m
//
//  Created by Kyosuke Kameda on 2016/07/01.
//  Copyright © 2016年 Kyosuke Kameda. All rights reserved.
//

#import "ORGProtocolExtension.h"

#import <objc/runtime.h>

#import "ORGProtocolExtensionDefinition.h"

@interface ORGProtocolExtension ()

@property(nonatomic, nonnull, strong) NSMutableArray<ORGProtocolExtensionDefinition*> *definition;
@property(nonatomic, nonnull, strong) NSMutableArray<NSValue*> *imp;

@end

@implementation ORGProtocolExtension

- (void)dealloc
{
    for(NSValue *v in self.imp) {
        IMP imp = v.pointerValue;
        imp_removeBlock(imp);
    }
}

- (void)addDefinition:(nonnull ORGProtocolExtensionDefinition*)definition
{
    [self.definition addObject:definition];
}

- (void)apply
{
    int numClasses = objc_getClassList(NULL, 0);
    Class *classes = NULL;
    
    if(numClasses <= 0){
        return;
    }
    
    classes = (Class*)malloc(sizeof(Class) * numClasses);
    numClasses = objc_getClassList(classes, numClasses);
    for(int i=0; i<numClasses; ++i){
        for(ORGProtocolExtensionDefinition *d in self.definition){
            Protocol *protocol = objc_getProtocol([d.protocolName cStringUsingEncoding:NSUTF8StringEncoding]);
            if(protocol == NULL || !class_conformsToProtocol(classes[i], protocol)){
                continue;
            }
            
            unsigned int outCount;
            struct objc_method_description* method_list;
            method_list = protocol_copyMethodDescriptionList(protocol, NO, YES, &outCount);
            for(int x=0; x<outCount; ++x){
                NSString *selectorName = NSStringFromSelector(method_list[x].name);
                if(d.implementation[selectorName] == nil){
                    continue;
                }
                
                IMP imp = imp_implementationWithBlock(d.implementation[selectorName]);
                [self.imp addObject:[NSValue valueWithPointer:imp]];
                BOOL success = class_addMethod(classes[i],
                                               method_list[x].name,
                                               imp,
                                               method_list[x].types);
                NSAssert(success, @"class_addMethod fail");
                Method m = class_getInstanceMethod(classes[i], method_list[x].name);
                NSAssert(m != NULL, @"class_getInstanceMethod fail");
                
            }
            free(method_list);
        }
    }
    free(classes);
}

#pragma mark - Private

- (nonnull instancetype)init
{
    self = [super init];
    if(self != nil){
        self.definition = [NSMutableArray array];
        self.imp = [NSMutableArray array];
    }
    return self;
}

@end
