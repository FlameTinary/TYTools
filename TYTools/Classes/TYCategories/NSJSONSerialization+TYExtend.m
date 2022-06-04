//
//  NSJSONSerialization+TYExtend.m
//  TYTools
//
//  Created by SheldonBook on 2022/6/4.
//

#import "NSJSONSerialization+TYExtend.h"

@implementation NSJSONSerialization (TYExtend)
+ (id)JSONObjectWithText:(NSString *)text {
    id obj = [self JSONObjectWithData:[text dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
    return obj;
    return nil;
}


+ (NSString *)JSONStringWithJSONObject:(id )obj {
    
    if ([self isValidJSONObject:obj]) {
        NSData *data = [self dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:nil];
        return [[NSString alloc] initWithData:data encoding:(NSUTF8StringEncoding)];
    }
    return nil;
}

///把对象转化成字符串 并且删除其中的\n
+ (NSString *)JSONStringWithJSONObject_RemoveSpace:(id )obj {
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:obj
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&parseError];
    NSString * jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return jsonStr;
}
@end
