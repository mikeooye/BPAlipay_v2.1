BPAlipay_V_2_1
==============

Alipay version 2.1 helper

Usage:
------
    1.添加 SystemConfiguration.framework

    2.添加预编译文件(如果已存在忽略)
        File->New->File,选择 Other->PCH file -> 保存（如 PrefixHeader.pch)
        添加如下内容
        #import <Foundation/Foundation.h>
        #import <UIKit/UIKit.h>

    3.设置预编译文件
        Target->Build Settings->Apple LLVM 6.0 - Language,将
        Precompile Prefix Header -> YES
        Prefix Header -> 预编译文件的路径 (如 $(SRCROOT)/$(PROJECT_NAME)/PrefixHeader.pch)

    4.设置回调处理
        打开 AppDelegate.m，加入
        #import "AlipaySDKHelper.h"

        在 - application:openURL:sourceApplication:annotation: 方法中，添加
        return [[AlipaySDKHelper sharedInstance] handleURL:url];
