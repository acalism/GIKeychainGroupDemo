//
//  ViewController.m
//  GIKeychainDemo2
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
    NSString *accountName3 = @"Google";
    NSString *accountName4 = @"Apple";
    if ([GIKeychainAccess getKeychainDataForKey:accountKey]) {
        NSLog(@"该key内容已经存在，值为：%@", [GIKeychainAccess getKeychainDataForKey:accountKey]);
        [GIKeychainAccess addKeychainData:accountName4 forKey:accountKey];
        NSLog(@"该key内容被修改，值为：%@", [GIKeychainAccess getKeychainDataForKey:accountKey]);
    } else {
        NSLog(@"该key不存在，准备写入");
        [GIKeychainAccess addKeychainData:accountName3 forKey:accountKey];
        NSLog(@"已写入，该key内容：%@", [GIKeychainAccess getKeychainDataForKey:accountKey]);
    }
}

@end
