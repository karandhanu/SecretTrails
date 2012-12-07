//
//  ViewController.m
//  secret trails
//
//  Created by Jesse Rintoul on 2012-10-31.
//  Copyright (c) 2012 Jesse Rintoul. All rights reserved.
//

#import "ViewController.h"
#import "GameInputOutput.h"
#import "SystemConfiguration/SCNetworkReachability.h"
#import "PreferencesViewController.h"

@interface ViewController ()

@end

@implementation ViewController

//@synthesize display = _display;
NSString *username;
NSString *password;
bool isFirstLoad = YES;
bool hasDataConnectionAvailable = NO;
NSMutableArray *firstWordName;
NSMutableArray *spellingpattern;

NSMutableArray *allWordsFromWeb;

bool shouldDownloadFile = YES;

- (void)viewDidLoad
{
    [super viewDidLoad];
    hasDataConnectionAvailable = [GameInputOutput isDataSourceAvailable];
    
    //download the new Json wordlist only if we are connected to the internet
    if(hasDataConnectionAvailable)
    {
        if (shouldDownloadFile)
        {
            NSArray *arr = [PreferencesViewController displayUserCredentials];
            
            NSString *authToken = @"";
            if(arr.count > 2)
            {
                authToken = [arr objectAtIndex:2];
            }
            
            //http://stackoverflow.com/questions/782451/iphone-sdk-load-save-settings
            NSLog(@"%@",authToken);
            //download the file if authtoken is not empty
            if(![authToken isEqualToString:@""])
            {
                //get the json file based on the username and password
                //method from Red Panda team
                [GameInputOutput writeJsonToFile:authToken];
                shouldDownloadFile = NO;
            }
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    //Dispose of any resources that can be recreated.
}




@end
