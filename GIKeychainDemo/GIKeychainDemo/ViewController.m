//
//  ViewController.m
//  GIKeychainDemo
//
//  Created by shen on 15/12/24.
//  Copyright © 2015年 shen. All rights reserved.
//

#import "ViewController.h"

#import <GIKeychain/GIKeychain.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *accountKey = @"accountKey";
    NSString *accountName = @"Alibaba";
    NSString *accountName2 = @"Netease";
    [GIKeychainAccess deleteKeychainDataForKey:accountKey];
    if ([GIKeychainAccess getKeychainDataForKey:accountKey]) {
        NSLog(@"该key内容已经存在，值为：%@", [GIKeychainAccess getKeychainDataForKey:accountKey]);
        [GIKeychainAccess addKeychainData:accountName2 forKey:accountKey];
        NSLog(@"该key内容被修改，值为：%@", [GIKeychainAccess getKeychainDataForKey:accountKey]);
    } else {
        NSLog(@"该key不存在，准备写入");
        [GIKeychainAccess addKeychainData:accountName forKey:accountKey];
        NSLog(@"已写入，该key内容：%@", [GIKeychainAccess getKeychainDataForKey:accountKey]);
    }
}


@end
