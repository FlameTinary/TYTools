//
//  NSJSONSerialization+TYExtend.h
//  TYTools
//
//  Created by SheldonBook on 2022/6/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSJSONSerialization (TYExtend)
+ (id)JSONObjectWithText:(NSString *)text;

+ (NSString *)JSONStringWithJSONObject:(id )obj;

///把对象转化成字符串 并且删除其中的\n
+ (NSString *)JSONStringWithJSONObject_RemoveSpace:(id )obj;
@end

NS_ASSUME_NONNULL_END
