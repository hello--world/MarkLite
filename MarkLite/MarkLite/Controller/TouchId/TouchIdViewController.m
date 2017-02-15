//
//  TouchIdViewController.m
//  MarkLite
//
//  Created by HeFengyang on 2017/2/15.
//  Copyright © 2017年 zhubch. All rights reserved.
//

#import "TouchIdViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface TouchIdViewController ()

@end

@implementation TouchIdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.touchId) {
        [self touchid];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)touchid {
    LAContext *context = [[LAContext alloc] init];
    NSError *error;
    
    // check if the policy can be evaluated
    if (![context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error])
    {
        NSLog(@"error:%@", error);
        NSString *msg = [NSString stringWithFormat:@"Can't evaluate policy! %@", error.localizedDescription];
        //        [SVProgressHUD showErrorWithStatus:msg];
        NSLog(@"%@",msg);
        return;
    }
    
    // evaluate
    [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
            localizedReason:@"通过Touch ID 🔓"
                      reply:
     ^(BOOL success, NSError *authenticationError) {
         
         dispatch_async(dispatch_get_main_queue(), ^{
             if (self.authenticationBlock) {
                 self.authenticationBlock(success);
             }
             if (success) {
                 //                 [SVProgressHUD showSuccessWithStatus:@"SUCCEEDED!"];
                 NSLog(@"SUCCEEDED");
                 
             }
             else {
                 NSLog(@"%@,",[NSString stringWithFormat:@"FAILED! %@", authenticationError.localizedDescription]);
                 
                 //                 NSLog(@"error:%@", authenticationError);
                 //                 [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"FAILED! %@", authenticationError.localizedDescription]];
             }
         });
     }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
