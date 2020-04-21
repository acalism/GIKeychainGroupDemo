//
//  GIKeychain.m
//  GIKeychainDemo
//
//  Created by shen on 15/12/24.
//  Copyright © 2015年 shen. All rights reserved.
//

#import "GIKeychainAccess.h"

NS_ASSUME_NONNULL_BEGIN

@implementation GIKeychainAccess

//创建一个基本的查询字典
+ (NSMutableDictionary *)keychainQueryFor:(NSString *)service {
    return @{
        (__bridge id) kSecClass: (__bridge id) kSecClassGenericPassword,
        (__bridge id) kSecAttrService: service,
        (__bridge id) kSecAttrAccount: service,
        (__bridge id) kSecAttrAccessible: (__bridge id) kSecAttrAccessibleAfterFirstUnlock,
    }.mutableCopy;
}

+ (id)getKeychainDataForKey:(NSString *)key {
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self keychainQueryFor:key];
    //Configure the search setting
    //Since in our simple case we are expecting only a single attribute to be returned (the password) we can set the attribute kSecReturnData to kCFBooleanTrue
    keychainQuery[(__bridge id) kSecReturnData] = (id) kCFBooleanTrue;
    keychainQuery[(__bridge id) kSecMatchLimit] = (__bridge id) kSecMatchLimitOne;
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((__bridge CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@",key,e);
        } @finally {
        }
    }
    if (keyData)
        CFRelease(keyData);
    return ret;
}

+ (void)addKeychainData:(id)data forKey:(NSString *)key {
    //Get search dictionary
    NSMutableDictionary *keychainQuery = [self keychainQueryFor:key];
    //Delete old item before add new item
    SecItemDelete((__bridge CFDictionaryRef)keychainQuery);
    //Add new object to search dictionary(Attention:the data format)
    keychainQuery[(__bridge id) kSecValueData] = [NSKeyedArchiver archivedDataWithRootObject:data];
    //Add item to keychain with the search dictionary
    SecItemAdd((__bridge CFDictionaryRef)keychainQuery, NULL);
}

+ (void)addShareKeyChainData:(id)data forKey:(NSString *)key {
    //Get search dictionary
    NSMutableDictionary *keychainQuery = [self keychainQueryFor:key];
    keychainQuery[(id) kSecAttrAccessGroup] = accessGroupItem;
    //Delete old item before add new item
    SecItemDelete((__bridge CFDictionaryRef)keychainQuery);
    //Add new object to search dictionary(Attention:the data format)
    keychainQuery[(__bridge id) kSecValueData] = [NSKeyedArchiver archivedDataWithRootObject:data];
    //Add item to keychain with the search dictionary
    SecItemAdd((__bridge CFDictionaryRef)keychainQuery, NULL);

}

+ (void)deleteKeychainDataForKey:(NSString *)key {
    NSMutableDictionary *keychainQuery = [self keychainQueryFor:key];
    SecItemDelete((__bridge CFDictionaryRef)keychainQuery);
}

@end

NS_ASSUME_NONNULL_END
