//
//  PreferencesViewController.m
//  secret trails
//
//  Created by Jesse Rintoul on 2012-12-03.
//  Copyright (c) 2012 Jesse Rintoul. All rights reserved.
//

#import "GameViewController.h"
#import "PreferencesViewController.h"
#import "GameInputOutput.h"

#include <SystemConfiguration/SystemConfiguration.h>
#import "ViewController.h"

@interface PreferencesViewController ()

@end

@implementation PreferencesViewController
@synthesize username;
@synthesize password;
@synthesize connectedToData;
@synthesize rememberMeToggle;
@synthesize errorMessage;

bool hasDataConnection= NO;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}






- (IBAction)doneEnterCredentials:(id)sender
{
    NSArray *arr = [PreferencesViewController displayUserCredentials];
    NSString *token = @"";
    //1.download the file when user has done entering username and password
    //2. download the file from sever only if username and password is not bank
    //3. I need to find a to authenicate these usernames and passwords
    [self authenicateUserAccount];
    if(arr.count >2)
    {
        token = [arr objectAtIndex:2];
    }
    NSLog(@"%@",token);
    if(![token isEqualToString:@"token"])
    {
        if(![token isEqualToString:@""])
        {
            if([self saveUserCredentials:token])
            {
                //get the json file based on the username and password
                //[GameInputOutput writeJsonToFile:token];
                [self performSegueWithIdentifier:@"doneCredentials" sender:self];
            }
        }
    }
}


//http://stackoverflow.com/questions/7673127/iphone-sdk-xcode-4-2-ios-5-how-do-i-send-a-json-to-url-post-and-get-resolv
//http://stackoverflow.com/questions/4085978/json-post-request-on-the-iphone-using-https
- (void) authenicateUserAccount
{
    NSString* jsonRequest = [NSString stringWithFormat:@"{\"login\": {\"username\":\"%@\",\"password\":\"%@\",\"application\":\"my test app\",\"version\":\"0.0\"}}", username.text,password.text];
    
    NSURL *url = [NSURL URLWithString:@"http://helpchildrenread.org/api/simplified/login"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSData *requestData = [NSData dataWithBytes:[jsonRequest UTF8String] length:[jsonRequest length]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%d", [requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    [NSURLConnection connectionWithRequest:request delegate:self];
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSMutableData *retrievedData = [NSMutableData data];
    [retrievedData appendData:data];
    //NSMutableString *allInfo = [[NSMutableString alloc] initWithData:retrievedData encoding:NSASCIIStringEncoding];
    
    
    // NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //NSString *documentsDirectory = [paths objectAtIndex:0];
    // NSString *pathToFile = [NSString stringWithFormat:@"%@/%@", documentsDirectory,@"data.json"];
    
    // NSData *urlData = allInfo;
    
    //[urlData writeToFile:pathToFile atomically:YES];
    
    //    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"credentials" ofType:@"json"];
    //
    //    NSData *userCredentials = allInfo;
    //    [userCredentials writeToFile:filePath atomically:YES];
    
    
    NSError *error;
    
    //NSString *jsonFilePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,@"data.json"];
    //NSData *jsonData = [NSData dataWithContentsOfFile:jsonFilePath options:kNilOptions error:&error ];
    //NSData *hello ;
    //NSData* JSONData = [NSData dataWithContentsOfFile:filePath];
    // NSLog(@"%@",urlData);
    //NSDictionary *JSONDictionary = [NSJSONSerialization JSONObjectWithData:urlData options:kNilOptions error:&error];
    NSDictionary *JSONDictionary = [NSJSONSerialization JSONObjectWithData:retrievedData options:0 error:&error];
    //get the log in information from the credentials file
    NSDictionary *login = [JSONDictionary objectForKey:@"login"];
    //get the auth_token
    NSDictionary *loginInfo = login;
    
    if(loginInfo == NULL)
    {
        errorMessage.text = @"Invalid username or password";
        errorMessage.hidden = NO;
        NSUserDefaults *userCredentials = [NSUserDefaults standardUserDefaults];
        [userCredentials setObject:@"" forKey:@"username"];
        [userCredentials setObject:@"" forKey:@"password"];
        [userCredentials setObject:@"" forKey:@"authcode"];
    }
    else
    {
        NSString *authCode = [loginInfo objectForKey:@"auth_token"];
        [GameInputOutput writeJsonToFile:authCode];
        [self saveUserCredentials:authCode];
    }
}


- (void) connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    if([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
    {
        [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust]
             forAuthenticationChallenge:challenge];
    }
    
    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}

- (void) connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
    if([[protectionSpace authenticationMethod] isEqualToString:NSURLAuthenticationMethodServerTrust])
    {
        //return YES;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [username setDelegate:self];
    [password setDelegate:self];
    [self displayInternetConnectionStatus];
    
    
    
    //this methof is drived from
    //http://stackoverflow.com/questions/782451/iphone-sdk-load-save-settings
    //display the username, password
    NSArray *arr = [PreferencesViewController displayUserCredentials];
    
    if(arr.count > 0)
    {
        NSString *name = [arr objectAtIndex:0];
        NSString *pass = [arr objectAtIndex:1];
        
        username.text = name;
        password.text = pass;
    }
    
    //authenicate user
    //[self authenicateUserAccount];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)rememberCredentials:(id)sender
{
    if(rememberMeToggle.isOn)
    {
        
    }
    if(!rememberMeToggle.isOn)
    {
        
    }
}

- (void) displayInternetConnectionStatus
{
    hasDataConnection = [GameInputOutput isDataSourceAvailable];
    NSString * boolString = hasDataConnection ? @"Connected To Data" : @"No Data Connection";
    connectedToData.text = boolString;
    connectedToData.enabled = YES;
    if(hasDataConnection)
    {
        connectedToData.textColor =  [UIColor colorWithRed:0.10f green:0.53f blue:0.03f alpha:1.0f];
    }
    else
    {
        connectedToData.textColor =  [UIColor redColor];
    }
}


//this method is drived from
//http://stackoverflow.com/questions/782451/iphone-sdk-load-save-settings
- (BOOL) saveUserCredentials:(NSString *)token
{
    NSUserDefaults *userCredentials = [NSUserDefaults standardUserDefaults];
    bool saveCredentails = false;
    //only save credentials if user has remember me button to on
    if(rememberMeToggle.isOn)
    {
        
        if (
            (![username.text isEqualToString:@""]) &&
            (![password.text isEqualToString:@""] && ![password.text isEqualToString:@"password"]) &&
            (![token isEqualToString:@""] || ![token isEqualToString:@"token"] ||[token length] != 0 )
            )
        {
            [userCredentials setObject:username.text forKey:@"username"];
            [userCredentials setObject:password.text forKey:@"password"];
            [userCredentials setObject:token forKey:@"authcode"];
            return true;
        }
        else if ([username.text isEqualToString:@""] &&[password.text isEqualToString:@""])
        {
            username.text = @"";
            password.text = @"";
            [userCredentials setObject:username.text forKey:@"username"];
            [userCredentials setObject:password.text forKey:@"password"];
            return true;
        }
        else if([username.text isEqualToString:@""] ||[password.text isEqualToString:@""])
        {
            username.text = @"";
            password.text = @"";
            
            [userCredentials setObject:username.text forKey:@"username"];
            [userCredentials setObject:password.text forKey:@"password"];
            errorMessage.text = @"Invalid username or password";
            errorMessage.hidden = NO;
            return false;
        }
        
    }
    //do not save credentials
    else
    {
        username.text = @"";
        password.text = @"";
        [userCredentials setObject:username.text forKey:@"username"];
        [userCredentials setObject:password.text forKey:@"password"];
        return true;
    }
    return saveCredentails;
}

//This method is drived from
//http://stackoverflow.com/questions/3080713/method-with-2-return-values
+(NSArray*) displayUserCredentials
{
    NSUserDefaults *userCredentials = [NSUserDefaults standardUserDefaults];
    
    NSString *name = [userCredentials objectForKey:@"username"];
    NSString *pass =[userCredentials objectForKey:@"password"];
    NSString *token = [userCredentials objectForKey:@"authcode"];
    return [NSArray arrayWithObjects:name,pass,token,nil];
}

//hides the key when return button on keyboard is pressed
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}

- (IBAction)hideKeyboard
{
    [username resignFirstResponder];
    [password resignFirstResponder];
}
- (IBAction)signUp:(id)sender
{
    NSURL *url = [NSURL URLWithString:@"http://helpchildrenread.org/users/sign_up"];
    if (![[UIApplication sharedApplication] openURL:url])
        NSLog(@"%@%@",@"Failed to open url:",[url description]);
}
@end
