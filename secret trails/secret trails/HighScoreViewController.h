//
//  HighScoreViewController.h
//  secret trails
//
//  Created by Jesse Rintoul on 2012-12-05.
//  Copyright (c) 2012 Jesse Rintoul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HighScoreViewController : UIViewController


@property (weak, nonatomic) IBOutlet UILabel *playerName1;
@property (weak, nonatomic) IBOutlet UILabel *playerName2;
@property (weak, nonatomic) IBOutlet UILabel *playerName3;
@property (weak, nonatomic) IBOutlet UILabel *playerName4;
@property (weak, nonatomic) IBOutlet UILabel *playerName5;
@property (weak, nonatomic) IBOutlet UILabel *playerName6;
@property (weak, nonatomic) IBOutlet UILabel *playerName7;
@property (weak, nonatomic) IBOutlet UILabel *playerName8;
@property (weak, nonatomic) IBOutlet UILabel *playerName9;
@property (weak, nonatomic) IBOutlet UILabel *playerName10;

@property (weak, nonatomic) IBOutlet UILabel *highScore1;
@property (weak, nonatomic) IBOutlet UILabel *highScore2;
@property (weak, nonatomic) IBOutlet UILabel *highScore3;
@property (weak, nonatomic) IBOutlet UILabel *highScore4;
@property (weak, nonatomic) IBOutlet UILabel *highScore5;
@property (weak, nonatomic) IBOutlet UILabel *highScore6;
@property (weak, nonatomic) IBOutlet UILabel *highScore7;
@property (weak, nonatomic) IBOutlet UILabel *highScore8;
@property (weak, nonatomic) IBOutlet UILabel *highScore9;
@property (weak, nonatomic) IBOutlet UILabel *highScore10;





+(void)saveScore: (NSString *)score;
+(void)calculateHighScore:(int)totalWordsCompleted;





@end
