//
//  ACModelParser.h
//  ACDemo
//
//  Created by alan on 2013/11/7.
//  Copyright (c) 2013年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface ACModelParser : NSObject

+(id)parse:(id)data toClass:(Class)className; // object or list
+(NSMutableArray *)parseList:(id)data toClass:(Class)className; // list only
+(id)parseObject:(id)data toClass:(Class)className; // object only

+(NSMutableDictionary *) getPropertiesDictOfClass:(Class)className;
+(NSMutableDictionary *) getPropertiesDictOfClassIncludingSuperClass:(Class)className;
+(id) createModelOfClass:(Class)className withPropertiesDict:(id)propsInfo withOriginalData:(id)originalData;

+(NSDictionary *)convertModelToDictionary:(id)model;

@end


// Object which is subclass of ACModel will be parsed automatically.
@interface ACModel : NSObject

@end
