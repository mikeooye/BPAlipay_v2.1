//
//  RFAlixpayProcol.h
//  O2ODingcan
//
//  Created by lifu on 14-8-5.
//  Copyright (c) 2014年 refineit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AlipaySDK/AlipaySDK.h>
#import "AlipayConfigure.h"

@interface RFAlixpayProcol : NSObject

/**
 *  支付宝接口调用
 *
 *  @param dingDanId      定单号
 *  @param dingDanBiaoTi  标题
 *  @param dingDanMiaoShu 定单描述
 *  @param jiaGe          价格
 */
//+ (void)CallRequestAlixPay:(NSString*)dingDanId dingDanBiaoTi:(NSString*)dingDanBiaoTi dingDanMiaoShu:(NSString*)dingDanMiaoShu jiaGe:(float)jiaGe;

+ (void)alipayWithTradeNo:(NSString *)tradeNo
   productName:(NSString *)productName
productDescription:(NSString *)productDescription
        amount:(float)amount;

+ (RFAlixpayProcol *)sharedAlipay;
@end
