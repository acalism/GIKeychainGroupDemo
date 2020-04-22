//
//  GIKeychainAccess.h
//  GIKeychainDemo
//
//  Created by shen on 15/12/24.
//  Copyright © 2015年 shen. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface GIKeychainAccess : NSObject

+ (nullable id)dataForKey:(NSString *)key;
+ (void)setData:(nullable id)data forKey:(NSString *)key;

/// "XXXXX.GrassInfoAppFamily"
@property(class, nonatomic, copy) NSString *appGroupName;
+ (void)setSharedData:(nullable id)data forKey:(NSString *)key;
+ (nullable id)sharedDataForKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
