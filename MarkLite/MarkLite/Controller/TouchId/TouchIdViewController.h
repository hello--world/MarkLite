//
//  TouchIdViewController.h
//  MarkLite
//
//  Created by HeFengyang on 2017/2/15.
//  Copyright © 2017年 zhubch. All rights reserved.
//

typedef void(^AuthenticationBlock)(BOOL succeed);

#import "BaseViewController.h"

@interface TouchIdViewController : BaseViewController

@property (nonatomic, assign) BOOL touchId;

@property (nonatomic, copy) AuthenticationBlock authenticationBlock;

@end
