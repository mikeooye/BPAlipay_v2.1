//
//  AlipaySDKHelper.h
//  AlipayDemo
//
//  Created by Haozhen Li on 14-12-2.
//  Copyright (c) 2014年 Hojin. All rights reserved.
//

#import <Foundation/Foundation.h>


@class Order;

@interface AlipaySDKHelper : NSObject


+ (instancetype)sharedInstance;

/**
 *  发起支付请求
 *
 *  @param aOrder 初始化好的Order实例，其中tradeNo,productName, productDescription 这三个参数必须被设置，否则无法发起
 */
- (void)payWithOrder:(Order *)aOrder;

/**
 *  处理支付宝客户端回调
 *
 *  @param url 在 appDelegate 中，将`- application:openURL:sourceApplication:annotation:` 中的 url参数传入
 *
 *  @return 处理成功与否
 */
- (BOOL)handleURL:(NSURL *)url;
@end
