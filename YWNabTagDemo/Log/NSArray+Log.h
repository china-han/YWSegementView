#import <Foundation/Foundation.h>
/**
 *  给数组加分类,让使用%@输出时输出汉字
 */
@interface NSArray (Log)
+ (BOOL)isBlankArr:(NSArray *)arr;
@end
/**
 *  给字典加分类,让使用%@输出时输出汉字
 */
@interface NSDictionary (Log)
+ (BOOL)isBlankDictionary:(NSDictionary *)dic;
@end

/**
 *  字符串校验
 */
@interface NSString (isBlank)

+ (BOOL)isBlankString:(NSString *)aStr;

@end

