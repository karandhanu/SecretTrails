//
//  HighScoreViewController.m
//  secret trails
//
//  Created by Jesse Rintoul on 2012-12-05.
//  Copyright (c) 2012 Jesse Rintoul. All rights reserved.
//

#import "HighScoreViewController.h"

@interface HighScoreViewController ()

@end

@implementation HighScoreViewController

@synthesize playerName1;
@synthesize playerName2;
@synthesize playerName3;
@synthesize playerName4;
@synthesize playerName5;
@synthesize playerName6;
@synthesize playerName7;
@synthesize playerName8;
@synthesize playerName9;
@synthesize playerName10;
@synthesize highScore1;
@synthesize highScore2;
@synthesize highScore3;
@synthesize highScore4;
@synthesize highScore5;
@synthesize highScore6;
@synthesize highScore7;
@synthesize highScore8;
@synthesize highScore9;
@synthesize highScore10;

int baseScore = 100;
int highScore = 0;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //[HighScoreViewController saveScore:@"100"];
    [self displayScores];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


+(void)calculateHighScore:(int)totalWordsCompleted
{
    [HighScoreViewController saveScore:@"10"];
}

//(NSString *)baseURL
+(void)saveScore: (NSString *)score
{
    int counter = 1;
    
    //find the user
    NSUserDefaults *userCredentials = [NSUserDefaults standardUserDefaults];
    NSString *name = [userCredentials objectForKey:@"username"];
    
    //saving score
    NSUserDefaults *userScore = [NSUserDefaults standardUserDefaults];
    
    
    //1. Retrieve the counter
    NSString *retrievedCounter = [userCredentials objectForKey:@"playerCounter"];
    
    if([retrievedCounter isEqualToString:@""] ||[retrievedCounter isEqualToString:@"0"])
    {
        counter = 1;
    }
    else if([retrievedCounter isEqualToString:@"10"])
    {
        counter = 0;
    }
    else
    {
        counter = [retrievedCounter intValue];
    }
    //increment counter
    counter ++ ;
    
    
    NSString *count = [NSString stringWithFormat:@"%d", counter];
    
    //this the string which will be used to save the playername
    NSString *playerName = [NSString stringWithFormat:@"%@%@", @"playerName",count];
    
    //string that will be used to store high score
    NSString *highscore = [NSString stringWithFormat:@"%@%@", @"highScore",count];
    
    if([name isEqualToString:@""])
    {
        name = @"Player";
    }
    //saving score
    [userScore setObject:name forKey:playerName];
    [userScore setObject:score forKey:highscore];
    [userScore setObject:count forKey:@"playerCounter"];
}

//this method displays the top ten scores
-(void)displayScores
{
    NSUserDefaults *userScore = [NSUserDefaults standardUserDefaults];
    for(int i = 1;  i <= 10; i++)
    {
        NSString *count = [NSString stringWithFormat:@"%d", i];
        
        //this the string which will be used to save the playername
        NSString *playerName = [NSString stringWithFormat:@"%@%@", @"playerName",count];
        
        //string that will be used to store high score
        NSString *highscore = [NSString stringWithFormat:@"%@%@", @"highScore",count];
        
        //now display the score
        if([playerName1.text isEqualToString:playerName])
        {
            playerName1.text = [userScore objectForKey:playerName];
            highScore1.text = [userScore objectForKey:highscore];
            playerName1.hidden = NO;
            highScore1.hidden = NO;
        }
        
        else if([playerName2.text isEqualToString:playerName])
        {
            playerName2.text = [userScore objectForKey:playerName];
            highScore2.text = [userScore objectForKey:highscore];
            playerName2.hidden = NO;
            highScore2.hidden = NO;
        }
        
        else if([playerName3.text isEqualToString:playerName])
        {
            playerName3.text = [userScore objectForKey:playerName];
            highScore3.text = [userScore objectForKey:highscore];
            playerName3.hidden = NO;
            highScore3.hidden = NO;
        }
        
        else if([playerName4.text isEqualToString:playerName])
        {
            playerName4.text = [userScore objectForKey:playerName];
            highScore4.text = [userScore objectForKey:highscore];
            playerName4.hidden = NO;
            highScore4.hidden = NO;
        }
        
        else if([playerName5.text isEqualToString:playerName])
        {
            playerName5.text = [userScore objectForKey:playerName];
            highScore5.text = [userScore objectForKey:highscore];
            playerName5.hidden = NO;
            highScore5.hidden = NO;
        }
        
        else if([playerName6.text isEqualToString:playerName])
        {
            playerName6.text = [userScore objectForKey:playerName];
            highScore6.text = [userScore objectForKey:highscore];
            playerName6.hidden = NO;
            highScore6.hidden = NO;
        }
        
        else if([playerName7.text isEqualToString:playerName])
        {
            playerName7.text = [userScore objectForKey:playerName];
            highScore7.text = [userScore objectForKey:highscore];
            playerName7.hidden = NO;
            highScore7.hidden = NO;
        }
        
        else if([playerName8.text isEqualToString:playerName])
        {
            playerName8.text = [userScore objectForKey:playerName];
            highScore8.text = [userScore objectForKey:highscore];
            playerName8.hidden = NO;
            highScore8.hidden = NO;
        }
        
        else if([playerName9.text isEqualToString:playerName])
        {
            playerName9.text = [userScore objectForKey:playerName];
            highScore9.text = [userScore objectForKey:highscore];
            playerName9.hidden = NO;
            highScore9.hidden = NO;
        }
        
        else if([playerName10.text isEqualToString:playerName])
        {
            playerName10.text = [userScore objectForKey:playerName];
            highScore10.text = [userScore objectForKey:highscore];
            playerName10.hidden = NO;
            highScore10.hidden = NO;
        }
        
    }
}




@end
