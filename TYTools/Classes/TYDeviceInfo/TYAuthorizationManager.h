//
//  TYAuthorizationManager.h
//  TYTools
//
//  Created by Sheldon on 2021/11/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, ETYAuthorization) {
    ETYAuthorizationPhoto,
    ETYAuthorizationCamera,
    ETYAuthorizationMicrophone
};

typedef NS_ENUM(NSUInteger, ETYAuthorizationStatus) {
    ETYAuthorizationStatusNotDetermined,//尚未决定
    ETYAuthorizationStatusRestricted,//限制
    ETYAuthorizationStatusDenied,//拒绝
    ETYAuthorizationStatusAuthorized,//已授权 定位时:使用AuthorizedAlways 或 AuthorizedWhenInUse
    ETYAuthorizationStatusAuthorizedAlways,//定位使用 总是授权
    ETYAuthorizationStatusAuthorizedWhenInUse,//定位使用 使用时授权
};

@interface TYAuthorizationManager : NSObject
+ (ETYAuthorizationStatus)authorizedStatusWithType:(ETYAuthorization)authorizationType;

+ (BOOL)authorizedWithType:(ETYAuthorization)authorizationType;

+ (void)authorizeWithType:(ETYAuthorization)type completion:(void(^)(BOOL authorized))completion;

// 拍照并存储相册 需要请求相机、相册两个权限
+ (void)authorizedForTakePhotoAndSaveWithCompletion:(void(^)(BOOL authorized))completion;

// 录制视频 需要相机、相册、麦克风三个权限 其中只要有一个权限无法获取，都会导致录制出错
+ (void)authorizedForRecordVideoWithCompletion:(void(^)(BOOL authorized))completion;

// 语音
+ (void)authorizedForRecordWithCompletion:(void(^)(BOOL authorized))completion;

// 相册
+ (void)authorizedForPhotoWithCompletion:(void(^)(BOOL authorized))completion;

// 相机
+ (void)authorizedForCameraWithCompletion:(void(^)(BOOL authorized))completion;

+ (void)authorizedForCameraWithCompletion:(void(^)(BOOL authorized))completion needAlert:(BOOL)needAlert;

+ (void)gotoSetting;

@end

NS_ASSUME_NONNULL_END
