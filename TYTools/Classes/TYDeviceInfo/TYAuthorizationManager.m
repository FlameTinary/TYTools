//
//  TYAuthorizationManager.m
//  TYTools
//
//  Created by Sheldon on 2021/11/22.
//

#import "TYAuthorizationManager.h"
#import <Photos/Photos.h>

#define kAuthorizationAppName ([[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"])

@interface TYAuthorizationManager()
@property (nonatomic, copy) void (^permissionCompletion)(BOOL granted);
@end
@implementation TYAuthorizationManager

+ (BOOL)authorizedWithType:(ETYAuthorization)authorizationType
{
    BOOL authorized = NO;
    switch (authorizationType) {
        case ETYAuthorizationPhoto:
            authorized = [self photoAuthorized];
            break;
        case ETYAuthorizationCamera:
            authorized = [self cameraAuthorized];
            break;
        case ETYAuthorizationMicrophone:
            authorized =  [self microphoneAuthorized];
            break;
        default:
            authorized = NO;
            break;
    }
    return authorized;
}

+ (ETYAuthorizationStatus)authorizedStatusWithType:(ETYAuthorization)authorizationType
{
    ETYAuthorizationStatus status = ETYAuthorizationStatusNotDetermined;
    switch (authorizationType) {
        case ETYAuthorizationPhoto:
            status = [self photoAuthorizationStatus];
            break;
        case ETYAuthorizationCamera:
            status = [self cameraAuthorizationStatus];
            break;
        case ETYAuthorizationMicrophone:
            status =  [self microphoneAuthorizationStatus];
            break;
        default:
            break;
    }
    return status;
}

+ (void)authorizeWithType:(ETYAuthorization)authorizationType completion:(void(^)(BOOL authorized))completion
{
    switch (authorizationType) {
        case ETYAuthorizationPhoto:
            [self photoAuthorizeWithCompletion:completion];
            break;
        case ETYAuthorizationCamera:
            [self cameraAuthorizedWithCompletion:completion];
            break;
        case ETYAuthorizationMicrophone:
            [self microphoneAuthorizedWithCompletion:completion];
            break;
        default:
            break;
    }
}

+ (UIViewController *)getRootViewController {
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (rootViewController.presentedViewController) {
        rootViewController = rootViewController.presentedViewController;
    }
    return rootViewController;
}

//MARK: Photo
+ (BOOL)photoAuthorized
{
    return [PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusAuthorized;
}

+ (ETYAuthorizationStatus)photoAuthorizationStatus
{
    return (ETYAuthorizationStatus)[PHPhotoLibrary authorizationStatus];
}

+ (void)photoAuthorizeWithCompletion:(void(^)(BOOL authorized))completion
{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    
    switch (status) {
        case PHAuthorizationStatusAuthorized:
        {
            if (completion) {
                completion(YES);
            }
        }
            break;
        case PHAuthorizationStatusRestricted:
        case PHAuthorizationStatusDenied:
        {
            if (completion) {
                completion(NO);
            }
        }
            break;
        case PHAuthorizationStatusNotDetermined:
        {
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if (completion) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(status == PHAuthorizationStatusAuthorized);
                    });
                }
            }];
        }
            break;
        default:
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completion) {
                    completion(NO);
                }
            });
        }
            break;
    }
}
//MARK: Microphone
+ (BOOL)microphoneAuthorized
{
    return [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio] == AVAuthorizationStatusAuthorized;
}

+ (ETYAuthorizationStatus)microphoneAuthorizationStatus
{
    return (ETYAuthorizationStatus)[AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
}

+ (void)microphoneAuthorizedWithCompletion:(void(^)(BOOL authorized))completion
{
    [self authorizedForMediaType:AVMediaTypeAudio completion:completion];
}

//MARK: Camera
+ (BOOL)cameraAuthorized
{
    return [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo] == AVAuthorizationStatusAuthorized;
}

+ (ETYAuthorizationStatus)cameraAuthorizationStatus
{
    return (ETYAuthorizationStatus)[AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
}

+ (void)cameraAuthorizedWithCompletion:(void(^)(BOOL authorized))completion
{
    [self authorizedForMediaType:AVMediaTypeVideo completion:completion];
}

+ (void)authorizedForMediaType:(AVMediaType)type completion:(void(^)(BOOL authorized))completion
{
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:type];
    switch (status) {
        case AVAuthorizationStatusAuthorized:
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completion) {
                    completion(YES);
                }
            });
        }
            break;
        case AVAuthorizationStatusRestricted:
        case AVAuthorizationStatusDenied:
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completion) {
                    completion(NO);
                }
            });
        }
            break;
        case AVAuthorizationStatusNotDetermined:
        {
            //点击弹框授权
            [AVCaptureDevice requestAccessForMediaType:type completionHandler:^(BOOL granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (completion) {
                        completion(granted);
                    }
                });
            }];
        }
            break;
        default:
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completion) {
                    completion(NO);
                }
            });
        }
            break;
    }
}


+ (void)authorizedForRecordVideoWithCompletion:(void(^)(BOOL authorized))completion
{
    __weak typeof(self) weakSelf = self;
    [self authorizeWithType:ETYAuthorizationCamera completion:^(BOOL authorized) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!authorized) {
            NSString *des = [NSString stringWithFormat:@"请在设备的\"设置-隐私-相机\"选项中允许%@访问你的相机",kAuthorizationAppName];
            [strongSelf alertActionTitle:@"无法打开相机" message:des completion:completion];
            return;
        }
        
        [strongSelf authorizeWithType:ETYAuthorizationMicrophone completion:^(BOOL authorized) {
            if (!authorized) {
                NSString *des = [NSString stringWithFormat:@"请在设备的\"设置-隐私-麦克风\"选项中允许%@访问你的麦克风",kAuthorizationAppName];
                [strongSelf alertActionTitle:@"无法打开麦克风" message:des completion:completion];
                return;
            }
            if(completion){
                completion(YES);
            }
        }];
    }];
}

+ (void)authorizedForTakePhotoAndSaveWithCompletion:(void(^)(BOOL authorized))completion
{
    __weak typeof(self) weakSelf = self;
    [self authorizeWithType:ETYAuthorizationCamera completion:^(BOOL authorized) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!authorized) {
            NSString *des = [NSString stringWithFormat:@"请在设备的\"设置-隐私-相机\"选项中允许%@访问你的相机",kAuthorizationAppName];
            [strongSelf alertActionTitle:@"无法打开相机" message:des completion:completion];
            return;
        }
        [strongSelf authorizeWithType:ETYAuthorizationPhoto completion:^(BOOL authorized) {
            if (!authorized) {
                NSString *des = [NSString stringWithFormat:@"请在设备的\"设置-隐私-相册\"选项中允许%@访问你的相册",kAuthorizationAppName];
                [strongSelf alertActionTitle:@"无法打开相册" message:des completion:completion];
                return;
            }
            if(completion){
                completion(YES);
            }
        }];
    }];
}

+ (void)authorizedForRecordWithCompletion:(void(^)(BOOL authorized))completion {
    __weak typeof(self) weakSelf = self;
    [weakSelf authorizeWithType:ETYAuthorizationMicrophone completion:^(BOOL authorized) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!authorized) {
            NSString *des = [NSString stringWithFormat:@"请在设备的\"设置-隐私-麦克风\"选项中允许%@访问你的麦克风",kAuthorizationAppName];
            [strongSelf alertActionTitle:@"无法打开麦克风" message:des completion:completion];
            return;
        }
        if(completion){
            completion(YES);
        }
    }];
}

+ (void)authorizedForCameraWithCompletion:(void(^)(BOOL authorized))completion
{
    [self authorizedForCameraWithCompletion:completion needAlert:YES];
}
+ (void)authorizedForCameraWithCompletion:(void(^)(BOOL authorized))completion needAlert:(BOOL)needAlert
{
    __weak typeof(self) weakSelf = self;
    [self authorizeWithType:ETYAuthorizationCamera completion:^(BOOL authorized) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!authorized) {
            if (needAlert) {
                NSString *des = [NSString stringWithFormat:@"请在设备的\"设置-隐私-相机\"选项中允许%@访问你的相机",kAuthorizationAppName];
                [strongSelf alertActionTitle:@"无法打开相机" message:des completion:completion];
            }
            return;
        }
        if(completion){
            completion(YES);
        }
    }];
}

+ (void)authorizedForPhotoWithCompletion:(void(^)(BOOL authorized))completion
{
    __weak typeof(self) weakSelf = self;
    [self authorizeWithType:ETYAuthorizationPhoto completion:^(BOOL authorized) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!authorized) {
            NSString *des = [NSString stringWithFormat:@"请在设备的\"设置-隐私-相册\"选项中允许%@访问你的相册",kAuthorizationAppName];
            [strongSelf alertActionTitle:@"无法打开相册" message:des completion:completion];
            return;
        }
        if(completion){
            completion(YES);
        }
    }];
}


+ (void)alertActionTitle:(NSString *)title message:(NSString *)message completion:(void(^)(BOOL authorized))completion {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *enterAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if(completion){
            completion(NO);
        }
    }];
    [alertController addAction:enterAction];

    UIAlertAction *szAction = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self gotoSetting];
        if (completion) {
            completion(NO);
        }
    }];
    [alertController addAction:szAction];

    [[self getRootViewController] presentViewController:alertController animated:YES completion:nil];
}

+ (void)gotoSetting {
    //跳转到定位权限页面
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if( [[UIApplication sharedApplication] canOpenURL:url] ) {
        [[UIApplication sharedApplication] openURL:url];
    }
}
@end
