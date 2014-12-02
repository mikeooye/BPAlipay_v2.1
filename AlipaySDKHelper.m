//
//  AlipaySDKHelper.m
//  AlipayDemo
//
//  Created by Haozhen Li on 14-12-2.
//  Copyright (c) 2014年 Hojin. All rights reserved.
//

#import "AlipaySDKHelper.h"
#import "Order.h"
#import "AlipayConfigure.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import <UIKit/UIKit.h>


@implementation AlipaySDKHelper

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

+ (instancetype)sharedInstance
{
    static AlipaySDKHelper *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init];
    });
    return _instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        //初始化
    }
    return self;
}

#pragma mark - Pay
- (void)payWithOrder:(Order *)aOrder
{
    if (aOrder && aOrder.tradeNO.length && aOrder.productName.length && aOrder.productDescription.length) {
        
        /*
         *生成订单信息及签名
         */
        //将商品信息赋予AlixPayOrder的成员变量
        aOrder.partner = alipay_parter;
        aOrder.seller = alipay_seller;
//        aOrder.tradeNO = tradeNo; //订单ID（由商家自行制定）
//        aOrder.productName = productName; //商品标题
//        aOrder.productDescription =productDescription; //商品描述

#if DEBUG
        aOrder.amount = @"0.01";
#endif
        
        aOrder.notifyURL = alipay_notify_url; //回调URL
        
        aOrder.service = @"mobile.securitypay.pay";  //必须，否则会失败
        aOrder.paymentType = @"1";
        aOrder.inputCharset = @"utf-8";
        aOrder.itBPay = @"30m";
        
        //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
        NSString *appScheme = alipay_app_scheme;
        
        //将商品信息拼接成字符串
        NSString *orderSpec = [aOrder description];
        NSLog(@"orderSpec = %@",orderSpec);
        
        //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
        id<DataSigner> signer = CreateRSADataSigner(alipay_private_key);
        NSString *signedString = [signer signString:orderSpec];
        
        //将签名成功字符串格式化为订单字符串,请严格按照该格式
        NSString *orderString = nil;
        
        if (signedString != nil) {
            orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                           orderSpec, signedString, @"RSA"];
            NSLog(@"%@",orderString);
            
        }
        
        __weak typeof(self) weakSelf = self;
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {

            NSLog(@"callback_result = %@", resultDic);
            [weakSelf handleResult:resultDic];
        }];
    }
}


#pragma mark - Result

- (BOOL)handleURL:(NSURL *)url
{
    if ([url.host isEqualToString:@"safepay"]) {
        //如果极简 SDK 不可用,会跳转支付宝钱包进行支付,需要将支付宝钱包的支付结果回传给 SDK
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"safepay_result = %@", resultDic);
            [self handleResult:resultDic];
        }];
        
        return YES;
    }else if ([url.host isEqualToString:@"platformapi"]){
        //支付宝钱包快登授权返回 authCode
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"platformapi_result = %@", resultDic);
            [self handleResult:resultDic];
        }];
        
        return YES;
    }
    
    return NO;
}

- (void)handleResult:(NSDictionary *)result
{
    if ([[result objectForKey:@"resultStatus"] integerValue] == 9000) {
        //成功，发起通知
        [[NSNotificationCenter defaultCenter] postNotificationName:AlipaySuccessedNotificationName object:self];
    }else{
        //失败，发起通知，并且弹出alert提示
        [[NSNotificationCenter defaultCenter] postNotificationName:AlipayFailedNotificationName object:self];
        [self alipayResultAlert:result];
    }
}

- (void)alipayResultAlert:(NSDictionary *)result
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"支付宝[code=%@]", [result objectForKey:@"resultStatus"]]
                                                    message:[result objectForKey:@"memo"] delegate:nil
                                          cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}
@end
