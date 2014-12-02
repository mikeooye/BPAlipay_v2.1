//
//  AlipayConfigure.h
//  O2ODingcan
//
//  Created by Haozhen Li on 14-12-2.
//  Copyright (c) 2014年 refineit. All rights reserved.
//

#ifndef O2ODingcan_AlipayConfigure_h
#define O2ODingcan_AlipayConfigure_h


#define AlipaySuccessedNotificationName @"AlipaySuccessedNotificationName"
#define AlipayFailedNotificationName @"AlipayFailedNotificationName"


#define alipay_notify_url @"http://api.maizefresh.com/user-alipaycallback.html"
#define alipay_app_scheme @"alipay_demo"

//合作身份者id，以2088开头的16位纯数字
#define alipay_parter @"2088311878871888"
//收款支付宝账号
#define alipay_seller  @"account@maizefresh.com"

//安全校验码（MD5）密钥，以数字和字母组成的32位字符
#define MD5_KEY @"4frxan24g1vr1cl2fqo2n0inz3bgk7l8"

//商户私钥，自助生成
#define alipay_private_key @"MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBAMVl4idMAGaSYyaRanUhG15fUsf07F/zYJ2moFJnV+dUyAf6SItVHMSL3gxGx5zH2taaThzpMb5b4gj3hzvopzoCdfciECHO8IR4Pg1/TnPLNh+42VbTSysY/Bg7hA4EhcDDXdJrbCTHMJzuNHlnTW9+g0tXk9wCQ6EOATJV+BNjAgMBAAECgYEAmIyXDJVwjdQ9abXhVqmCNBloqPy/m5tDJDJ8HZKd3Tmo6HlkjMD23XHV5Rjh9GiC12wiR7dzaNArS5C3YvX2HMNyi7S3c070m6pGEcVnw6kUvXvEpwSFz3fznQ7lYul1eR3vvyPYqN3yg7d1D2pJw4EQ6HDaGuquAXao3nJf6ikCQQDuaNjq85yhDZ2xMDRWo66g5wHJgui9K3o2/49S8H82nuRcnBnZRUdOVseMrYr9/uPJFdPvUcQlhl5FjwZBLErHAkEA0/ZlmEzjM+bXRpU0e5w5BHAhdJTBFka7kHcvOObZMECL9y/3YZ+pR8OKFn9w527lbG1VG6XjIPdy2Uvbmxb2hQJBAJoUEtTNupVvilGAWOMBiBOfGE2WmDnhxmuTAJrWqTCwwd+EV0RO/MWJWg/1/JUozSghPkY17vFdhMGprJ4kNPMCQQDLuzlLehun92lT3nXjmfTz3xNJCvHMh5Ag+23YM4ruZhwiK2iL3PrIj5papYPP7zd1UGFNgdUeCrnJQrCCEUBBAkBD1cWUy31/NbZEkK7Jn4E1kiud+vFqOxsF48HsbHCelWbXGtD0Y/YVvelI5KiqtnmfUs9mNF9aV24+wXHe45Pv"


//支付宝公钥
#define alipay_public_key   @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCnxj/9qwVfgoUh/y2W89L6BkRAFljhNhgPdyPuBV64bfQNN1PjbCzkIM6qRdKBoLPXmKKMiFYnkd6rAoprih3/PrQEB/VsW8OoM8fxn67UDYuyBTqA23MML9q1+ilIZwBC2AQ2UBVOrFXfFl75p6/B5KsiNG9zpgmLCUYuLkxpLQIDAQAB"

#endif
