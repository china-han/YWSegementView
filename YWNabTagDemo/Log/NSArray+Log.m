#import "NSArray+Log.h"

@implementation NSArray (Log)
/**
 *  输出数组
 */

- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level
{
    NSMutableString *string = [NSMutableString string];
    
    // 开头有个[
    [string appendString:@"[\n"];
    
    // 遍历所有的元素
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [string appendFormat:@"\t%@,\n", obj];
    }];
    
    // 结尾有个]
    [string appendString:@"]"];
    
    // 查找最后一个逗号
    NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
    if (range.location != NSNotFound)
        [string deleteCharactersInRange:range];
    
    return string;
}

/**
 
 判断数组为空
 
 
 
 @param arr 数组
 
 @return YES 空 NO
 
 */

+ (BOOL)isBlankArr:(NSArray *)arr {
    
    if (!arr) {
        
        return YES;
        
    }
    
    if ([arr isKindOfClass:[NSNull class]]) {
        
        return YES;
        
    }
    
    if (!arr.count) {
        
        return YES;
        
    }
    
    if (arr == nil) {
        
        return YES;
        
    }
    
    if (arr == NULL) {
        
        return YES;
        
    }
    
    if (![arr isKindOfClass:[NSArray class]]) {
        
        return YES;
        
    }
    
    return NO;
    
}

@end

@implementation NSDictionary (Log)
/**
 *  输出字典
 */

// NSLog输出
- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *string = [NSMutableString string];
    
    // 开头有个{
    [string appendString:@"{\n"];
    
    // 遍历所有的键值对
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [string appendFormat:@"\t%@", key];
        [string appendString:@" = "];
        [string appendFormat:@"%@,\n", obj];
    }];
    
    // 结尾有个}
    [string appendString:@"}"];
    
    // 查找最后一个逗号
    NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
    if (range.location != NSNotFound)
        [string deleteCharactersInRange:range];
    
    return string;
}

// 输出台po命令输出
-(NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level
{
    NSMutableString *string = [NSMutableString string];
    
    // 开头有个{
    [string appendString:@"{\n"];
    
    // 遍历所有的键值对
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [string appendFormat:@"\t%@", key];
        [string appendString:@" = "];
        [string appendFormat:@"%@,\n", obj];
    }];
    
    // 结尾有个}
    [string appendString:@"}"];
    
    // 查找最后一个逗号
    NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
    if (range.location != NSNotFound)
        [string deleteCharactersInRange:range];
    
    return string;
}

/**
 
 判断字典为空
 
 
 
 @param  dic 数组
 
 @return YES 空 NO
 
 */
+ (BOOL)isBlankDictionary:(NSDictionary *)dic {
    
    if (!dic) {
        
        return YES;
        
    }
    
    if ([dic isKindOfClass:[NSNull class]]) {
        
        return YES;
        
    }
    
    if (!dic.count) {
        
        return YES;
        
    }
    
    if (dic == nil) {
        
        return YES;
        
    }
    
    if (dic == NULL) {
        
        return YES;
        
    }
    
    if (![dic isKindOfClass:[NSDictionary class]]) {
        
        return YES;
        
    }
    
    return NO;
    
}

@end

@implementation NSString (isBlank)
/**
 
 判断字符串是否为空
 
 
 
 @param  aStr 字符串
 
 @return YES  空 NO
 
 */

+ (BOOL)isBlankString:(NSString *)aStr {
    
    if ( !aStr ) {
        
        return YES;
        
    }
    
    if ([aStr isKindOfClass:[NSNull class]]) {
        
        return YES;
        
    }
    
    if (!aStr.length) {
        
        return YES;
        
    }
    
    if (aStr == nil) {
        
        return YES;
        
    }
    
    if (aStr == NULL) {
        
         return YES;
        
    }
    
    if ([aStr isEqualToString:@"NULL"]) {
         return YES;
       
    }
    
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    
    NSString *trimmedStr = [aStr stringByTrimmingCharactersInSet:set];
    
    if (!trimmedStr.length) {
        
        return YES;
        
    }
    
    return NO;
    
}
@end

