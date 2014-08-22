//
//  ACModelParser.m
//  ACDemo
//
//  Created by alan on 2013/11/7.
//  Copyright (c) 2013年 alan. All rights reserved.
//

#import "ACModelParser.h"


@implementation ACModel


@end

@implementation ACModelParser

+(id)parse:(id)data toClass:(Class)className
{
    if([data isKindOfClass:[NSArray class]])
        return [self parseList:data toClass:className];
    else if([data isKindOfClass:[NSDictionary class]])
        return [self parseObject:data toClass:className];
    
    return nil;
}

+(NSMutableArray *)parseList:(id)dataList toClass:(Class)className
{
    if(dataList==nil)
        return nil;
    
    NSMutableArray *array = [NSMutableArray array] ;
    id dict = [self getPropertiesDictOfClassIncludingSuperClass:className];
    
    for(NSDictionary *data in dataList)
    {
        id model = [self createModelOfClass:className withPropertiesDict:dict withOriginalData:data];
        [array addObject:model];
    }
    
    return array;
}

+(id)parseObject:(id)data toClass:(Class)className
{
    if(data==nil)
        return nil;
    
    id dict = [self getPropertiesDictOfClassIncludingSuperClass:className];
    id model = [self createModelOfClass:className withPropertiesDict:dict withOriginalData:data];
    
    return model;
}

// value: type  key: property name
+(NSMutableDictionary *) getPropertiesDictOfClass:(Class)className
{
    NSMutableDictionary *result = [@{}mutableCopy];
    
    unsigned count;
    objc_property_t *properties = class_copyPropertyList(className, &count);
    
    for (unsigned i = 0; i < count; i++)
    {
        objc_property_t oneProp = properties[i];
        NSString *propName = [NSString stringWithUTF8String:property_getName(oneProp)];
        NSString *attrs = [NSString stringWithUTF8String: property_getAttributes(oneProp)];
        
        // Read only attributes are assumed to be derived or calculated
		// See http://developer.apple.com/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/chapter_8_section_3.html
        if ([attrs rangeOfString:@",R,"].location == NSNotFound)
        {
            NSArray *attrParts = [attrs componentsSeparatedByString:@","];
            if (attrParts != nil)
            {
                if ([attrParts count] > 0)
                {
                    NSString *propType = [[attrParts objectAtIndex:0] substringFromIndex:1] ;
                    propType = [propType stringByReplacingOccurrencesOfString:@"\""withString:@""];
                    propType = [propType stringByReplacingOccurrencesOfString:@"@"withString:@""];
                    [result setObject:propType forKey:propName];
                }
            }
        }
    }
    
    free(properties);
    
    return result;
}

+(NSMutableDictionary *) getPropertiesDictOfClassIncludingSuperClass:(Class)className
{
    NSMutableDictionary *result = [@{}mutableCopy];
    
    if ([className superclass] != [NSObject class]) {
        result = [self getPropertiesDictOfClassIncludingSuperClass:[className superclass]];
    }
    
    [result addEntriesFromDictionary:[self getPropertiesDictOfClass:className]];
    
    return result;
}

+(id) createModelOfClass:(Class)className withPropertiesDict:(id)propsInfo withOriginalData:(id)originalData
{
    id model =  [[className alloc] init];
    
    NSArray *allProps = [propsInfo allKeys];
    
    for(NSString *propName in allProps)
    {
        NSString *propType=[propsInfo objectForKey:propName];
        Class propClass = NSClassFromString(propType);
        
        id data= [originalData objectForKey:propName];
        if([data isEqual:[NSNull null]]){ data=nil;}
       
        if([propClass isKindOfClass:[NSString class]] && data==nil){
            data=@"";
        }
        
        if([propClass isSubclassOfClass:[ACModel class]] || [propClass isKindOfClass:[ACModel class]]){
            data = [self parseObject:data toClass:propClass] ;
        }
        
        if(data){
            [model setValue:data forKey:propName];
        }
    }

    return model;
}

// value: property value  key: property name
+(NSDictionary *)convertModelToDictionary:(id)model;
{
    NSMutableDictionary *result = [@{} mutableCopy];
    
    NSMutableDictionary *plist = [ACModelParser getPropertiesDictOfClass:[model class]];
    
    [plist enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
        NSString *propName = key;
        NSString *propType=[plist objectForKey:propName];
        Class propClass = NSClassFromString(propType);
        
        id value = [model valueForKey:propName];
        
        if([propClass isSubclassOfClass:[ACModel class]] || [propClass isKindOfClass:[ACModel class]]){
            value = [self convertModelToDictionary:value] ;}
        
        if(value)
            [result setObject:value forKey:propName];
    }];
    
    return [NSDictionary dictionaryWithDictionary:result];
}





@end
