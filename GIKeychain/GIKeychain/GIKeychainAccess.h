//
//  GIKeychainAccess.h
//  GIKeychainDemo
//
//  Created by shen on 15/12/24.
//  Copyright © 2015年 shen. All rights reserved.
//

#import <Foundation/Foundation.h>

#define accessGroupItem @"XXXXX.GrassInfoAppFamily"

NS_ASSUME_NONNULL_BEGIN

@interface GIKeychainAccess : NSObject

+ (id)getKeychainDataForKey:(NSString *)key;
+ (void)addKeychainData:(id)data forKey:(NSString *)key;
+ (void)deleteKeychainDataForKey:(NSString *)key;
+ (void)addShareKeyChainData:(id)data forKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
