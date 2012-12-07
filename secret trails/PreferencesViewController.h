//
//  PreferencesViewController.h
//  secret trails
//
//  Created by Jesse Rintoul on 2012-12-03.
//  Copyright (c) 2012 Jesse Rintoul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PreferencesViewController : UIViewController <UITextFieldDelegate>



@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UILabel *connectedToData;
@property (weak, nonatomic) IBOutlet UISwitch *rememberMeToggle;
@property (weak, nonatomic) IBOutlet UILabel *errorMessage;
+ (NSArray*) displayUserCredentials;

@end
