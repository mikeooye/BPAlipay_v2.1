//
//  RFAlixpayProcol.m
//  O2ODingcan
//
//  Created by lifu on 14-8-5.
//  Copyright (c) 2014年 refineit. All rights reserved.
//

#import "RFAlixpayProcol.h"
#import "Order.h"
#import "DataSigner.h"

@interface RFAlixpayProcol ()

@end

@implementation RFAlixpayProcol

+ (RFAlixpayProcol *)sharedAlipay
{
    static RFAlixpayProcol *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[RFAlixpayProcol alloc] init];
    });
    return _instance;
}

- (void)paymentResultDelegate:(NSDictionary *)result
{
    if ([[result objectForKey:@"resultStatus"] integerValue] == 9000) {
        
//        [[NSNotificationCenter defaultCenter] postNotificationName:kPaySuccessedNotification object:self];
    }else{
//        [[NSNotificationCenter defaultCenter] postNotificationName:kPayFailedNotification object:self];
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

+ (void)CallRequestAlixPay:(NSString*)dingDanId dingDanBiaoTi:(NSString*)dingDanBiaoTi dingDanMiaoShu:(NSString*)dingDanMiaoShu jiaGe:(float)jiaGe
{

    
//    AlixPayOrder *order = [[AlixPayOrder alloc]init];
//    order.partner = PartnerID;
//    order.seller = SellerID;
//    order.tradeNO = dingDanId;
//    order.productName = dingDanBiaoTi;
//    order.productDescription = dingDanMiaoShu;
//    order.amount = [NSString stringWithFormat:@"%.2f",jiaGe];
//    order.notifyURL = @"http://api.maizefresh.com/user-alipaycallback.html";
//    NSString *appScheme = @"O2ODingcan";
//    
//    NSString *orderSpec = [order description];
//    NSLog(@"orderSpec = %@",orderSpec);
//    
//    
//    id<DataSigner>signer = CreateRSADataSigner(PartnerPrivKey);
//    NSString *signedString = [signer signString:orderSpec];
//    
//    NSString *orderString = nil;
//    if (signedString != nil) {
//        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
//                       orderSpec, signedString, @"RSA"];
//        NSLog(@"%@",orderString);
//
//    }
//    
//    [AlixLibService payOrder:orderString AndScheme:appScheme seletor:@selector(paymentResultDelegate:) target:[RFAlixpayProcol sharedAlipay]];
}

+ (void)alipayWithTradeNo:(NSString *)tradeNo productName:(NSString *)productName productDescription:(NSString *)productDescription amount:(float)amount
{
//    Order *order = [[Order alloc]init];
//    order.partner = PartnerID;
//    order.seller = SellerID;
//    order.tradeNO = tradeNo;
//    order.productName = productName;
//    order.productDescription = productDescription;
//#if DEBUG
//    order.amount = @"0.01";
//#else
//    order.amount = [NSString stringWithFormat:@"%.2f",amount];
//#endif
//    
//    order.notifyURL = @"http://api.maizefresh.com/user-alipaycallback.html";
//    NSString *appScheme = @"O2ODingcan";
//    
//    NSString *orderSpec = [order description];
//    NSLog(@"orderSpec = %@",orderSpec);
//    
//    
//    id<DataSigner>signer = CreateRSADataSigner(PartnerPrivKey);
//    NSString *signedString = [signer signString:orderSpec];
//
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = alipay_parter;
    order.seller = alipay_seller;
    order.tradeNO = tradeNo; //订单ID（由商家自行制定）
    order.productName = productName; //商品标题
    order.productDescription =productDescription; //商品描述
//    order.amount = [NSString stringWithFormat:@"%.2f", amount]; //商品价格
#if DEBUG
    order.amount = @"0.01";
#else
    order.amount = [NSString stringWithFormat:@"%.2f",amount];
#endif
    
    order.notifyURL =  @"http://api.maizefresh.com/user-alipaycallback.html"; //回调URL
    
    order.service = @"mobile.securitypay.pay";  //必须，否则会失败
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"O2ODingcan";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
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
    
    RFAlixpayProcol *rfalipay = [RFAlixpayProcol sharedAlipay];
//    [AlixLibService payOrder:orderString AndScheme:appScheme seletor:@selector(paymentResultDelegate:) target:rfalipay];
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        NSLog(@"callback_result = %@", resultDic);
        [rfalipay paymentResultDelegate:resultDic];
    }];
}
@end
