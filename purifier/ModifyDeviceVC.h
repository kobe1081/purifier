//
//  ModifyDeviceVC.h
//  purifier
//
//  Created by Tony on 15/11/25.
//  Copyright © 2015年 iMac. All rights reserved.
//

#import "HeBaseViewController.h"
#import "DeviceModel.h"
#import "PurifierModel.h"

@protocol SaveProtocol <NSObject>

- (void)saveSucceedWithModel:(PurifierModel *)model;

@end

@interface ModifyDeviceVC : HeBaseViewController<UITextFieldDelegate>
@property(assign,nonatomic)id<SaveProtocol>saveDelegate;

- (id)initWithDevice:(DeviceModel *)device;

@end
