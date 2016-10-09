//
//  Helper.h
//  Coding_iOS
//
//  Created by Elf Sundae on 14-12-22.
//  Copyright (c) 2014年 Coding. All rights reserved.
//


@interface Helper : NSObject

/**
 * 检查系统"照片"授权状态, 如果权限被关闭, 提示用户去隐私设置中打开.
 */
+ (BOOL)checkPhotoLibraryAuthorizationStatus;

/**
 * 检查系统"相机"授权状态, 如果权限被关闭, 提示用户去隐私设置中打开.
 */
+ (BOOL)checkCameraAuthorizationStatus;

/**
 * 检查系统"定位服务"授权状态, 如果权限被关闭, 提示用户去隐私设置中打开.
 */
+ (BOOL)checkLocationAuthorizationStatus;

/**
 * 检查系统"通讯录"授权状态, 如果权限被关闭, 提示用户去隐私设置中打开.
 */
+ (void)checkContactsAuthorizationStatus:(void (^)(bool isAuthorized))block;

+ (void)showSettingAlertStr:(NSString *)tipStr;
@end
