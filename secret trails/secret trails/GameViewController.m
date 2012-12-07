//
//  GameViewController.m
//  Secret Trails
//
//  Created by Jesse Rintoul on 12-10-29
//  Edited by Karan Dhanu and Christian Wood
//  Copyright (c) 2012 TeamB. All rights reserved.
//

#import "GameViewController.h"
#import "levelCompleteViewController.h"
#import "GameInputOutput.h"
#import "HighScoreViewController.h"



@interface GameViewController ()

@end

@implementation GameViewController

@synthesize cell_1_1;
@synthesize cell_1_2;
@synthesize cell_1_3;
@synthesize cell_1_4;
@synthesize cell_1_5;
@synthesize cell_1_6;
@synthesize cell_1_7;
@synthesize cell_2_1;
@synthesize cell_2_2;
@synthesize cell_2_3;
@synthesize cell_2_4;
@synthesize cell_2_5;
@synthesize cell_2_6;
@synthesize cell_2_7;
@synthesize cell_3_1;
@synthesize cell_3_2;
@synthesize cell_3_3;
@synthesize cell_3_4;
@synthesize cell_3_5;
@synthesize cell_3_6;
@synthesize cell_3_7;
@synthesize cell_4_1;
@synthesize cell_4_2;
@synthesize cell_4_3;
@synthesize cell_4_4;
@synthesize cell_4_5;
@synthesize cell_4_6;
@synthesize cell_4_7;
@synthesize cell_5_1;
@synthesize cell_5_2;
@synthesize cell_5_3;
@synthesize cell_5_4;
@synthesize cell_5_5;
@synthesize cell_5_6;
@synthesize cell_5_7;
@synthesize cell_6_1;
@synthesize cell_6_2;
@synthesize cell_6_3;
@synthesize cell_6_4;
@synthesize cell_6_5;
@synthesize cell_6_6;
@synthesize cell_6_7;
@synthesize cell_7_1;
@synthesize cell_7_2;
@synthesize cell_7_3;
@synthesize cell_7_4;
@synthesize cell_7_5;
@synthesize cell_7_6;
@synthesize cell_7_7;
@synthesize playAgain;
@synthesize Feedback;
@synthesize clear;
@synthesize Score;
@synthesize correctionButton;
@synthesize wordLength;



int currentWordIndex = 0;
int gameScore = 0;

NSString *currentWord = @"starwar";
NSString *alphabet = @"abcdefghijklmnopqrstuvwxyz";
NSMutableArray *WordList;
NSMutableArray *spellingSequenceArray;
NSString *userString = @"";

NSMutableArray *ButtonArray;
int LastButtonIndex = 0;
int CorrectionArray[] = {-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1};





-(void)initUIArrays
{
    WordList = [[NSMutableArray alloc] init];
    spellingSequenceArray = [[NSMutableArray alloc] init];
}

//this creates the wordlist from the jsonfile that was downloaded when game was set up
//by Team Red Panda
- (void) loadGameData
{
    NSUserDefaults *userCredentials = [NSUserDefaults standardUserDefaults];
    NSString *token = [userCredentials objectForKey:@"authcode"];
    NSLog(@"%@", token);
    NSString *filePath = @"" ;
    if(![token isEqualToString:@""] && [token length] != 0)
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,@"data.json"];
    }
    else
    {
        filePath = [[NSBundle mainBundle] pathForResource:@"wordlist" ofType:@"json"];
    }
    
    
    //here is error
    [GameInputOutput gameDataFromJSON:filePath outputWordsTo:WordList outputSpellingsTo:spellingSequenceArray];
    
}




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;
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
    
    
    
    [self initButtonArray];
    
    
    
    [self initUIArrays];
    
    [self loadGameData];
    
    
    if([WordList count] == 0 || WordList[0] == nil){
       WordList = [NSMutableArray arrayWithObjects: @"digital",@"colony",@"dead",@"souls",@"a",@"means",@"to",@"an",@"end", nil ];
    }
    
    //screenUsername.title = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"].uppercaseString;
    
    
    
    NSLog(@"%@",WordList);
    if([WordList count] == 0){
        [self generateGrid:currentWord];
    }else{
        currentWord = [WordList objectAtIndex:currentWordIndex];
        [self generateGrid:currentWord];
    }
    
    [Score setText:[NSString stringWithFormat:@"Score %d",gameScore]];
    
    
    
    
    	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)initButtonArray {//create an array of the buttons to access easily
    ButtonArray = [[NSMutableArray alloc] init];
    [ButtonArray insertObject:cell_1_1 atIndex:0];
    [ButtonArray insertObject:cell_1_2 atIndex:1];
    [ButtonArray insertObject:cell_1_3 atIndex:2];
    [ButtonArray insertObject:cell_1_4 atIndex:3];
    [ButtonArray insertObject:cell_1_5 atIndex:4];
    [ButtonArray insertObject:cell_1_6 atIndex:5];
    [ButtonArray insertObject:cell_1_7 atIndex:6];
    [ButtonArray insertObject:cell_2_1 atIndex:7];
    [ButtonArray insertObject:cell_2_2 atIndex:8];
    [ButtonArray insertObject:cell_2_3 atIndex:9];
    [ButtonArray insertObject:cell_2_4 atIndex:10];
    [ButtonArray insertObject:cell_2_5 atIndex:11];
    [ButtonArray insertObject:cell_2_6 atIndex:12];
    [ButtonArray insertObject:cell_2_7 atIndex:13];
    [ButtonArray insertObject:cell_3_1 atIndex:14];
    [ButtonArray insertObject:cell_3_2 atIndex:15];
    [ButtonArray insertObject:cell_3_3 atIndex:16];
    [ButtonArray insertObject:cell_3_4 atIndex:17];
    [ButtonArray insertObject:cell_3_5 atIndex:18];
    [ButtonArray insertObject:cell_3_6 atIndex:19];
    [ButtonArray insertObject:cell_3_7 atIndex:20];
    [ButtonArray insertObject:cell_4_1 atIndex:21];
    [ButtonArray insertObject:cell_4_2 atIndex:22];
    [ButtonArray insertObject:cell_4_3 atIndex:23];
    [ButtonArray insertObject:cell_4_4 atIndex:24];
    [ButtonArray insertObject:cell_4_5 atIndex:25];
    [ButtonArray insertObject:cell_4_6 atIndex:26];
    [ButtonArray insertObject:cell_4_7 atIndex:27];
    [ButtonArray insertObject:cell_5_1 atIndex:28];
    [ButtonArray insertObject:cell_5_2 atIndex:29];
    [ButtonArray insertObject:cell_5_3 atIndex:30];
    [ButtonArray insertObject:cell_5_4 atIndex:31];
    [ButtonArray insertObject:cell_5_5 atIndex:32];
    [ButtonArray insertObject:cell_5_6 atIndex:33];
    [ButtonArray insertObject:cell_5_7 atIndex:34];
    [ButtonArray insertObject:cell_6_1 atIndex:35];
    [ButtonArray insertObject:cell_6_2 atIndex:36];
    [ButtonArray insertObject:cell_6_3 atIndex:37];
    [ButtonArray insertObject:cell_6_4 atIndex:38];
    [ButtonArray insertObject:cell_6_5 atIndex:39];
    [ButtonArray insertObject:cell_6_6 atIndex:40];
    [ButtonArray insertObject:cell_6_7 atIndex:41];
    [ButtonArray insertObject:cell_7_1 atIndex:42];
    [ButtonArray insertObject:cell_7_2 atIndex:43];
    [ButtonArray insertObject:cell_7_3 atIndex:44];
    [ButtonArray insertObject:cell_7_4 atIndex:45];
    [ButtonArray insertObject:cell_7_5 atIndex:46];
    [ButtonArray insertObject:cell_7_6 atIndex:47];
    [ButtonArray insertObject:cell_7_7 atIndex:48];
}





- (void)buttonPressGeneric:(id)sender{
    correctionButton.hidden = NO;
    clear.hidden = NO;
    //adds the selected button's letter to the user string, the "word" the user has selected so far
    userString = [userString stringByAppendingString:[(UIButton *)sender currentTitle]];
    
    //after the button has been pressed it can not be pressed again until the word is guessed or the grid is cleared
    UIButton *buttonThatWasPressed = (UIButton *)sender;
    buttonThatWasPressed.enabled = NO;
    
    //checks if the word given by the user is correct and if it is allows the user to play again
    if([userString isEqualToString:currentWord]){
        [Feedback setText:[NSString stringWithFormat:@"Correct"]];
        gameScore = gameScore + 10;
        [Score setText:[NSString stringWithFormat:@"Score %d",gameScore]];
        playAgain.hidden = NO;
        clear.hidden = YES;
        correctionButton.hidden = YES;
        [self disableAllButtonCells];
    }
    


}

//all the actions preformed by each button
- (IBAction)cellButtonPress_1_1:(id)sender {
    [self buttonPressGeneric:sender];
    
    CorrectionArray[LastButtonIndex] = 0;
    LastButtonIndex = LastButtonIndex + 1;

}
- (IBAction)cellButtonPress_1_2:(id)sender {
    [self buttonPressGeneric:sender];
    CorrectionArray[LastButtonIndex] = 1;
    LastButtonIndex = LastButtonIndex + 1;
}
- (IBAction)cellButtonPress_1_3:(id)sender {
    [self buttonPressGeneric:sender];
    CorrectionArray[LastButtonIndex] = 2;
    LastButtonIndex = LastButtonIndex + 1;
}
- (IBAction)cellButtonPress_1_4:(id)sender {
    [self buttonPressGeneric:sender];
    CorrectionArray[LastButtonIndex] = 3;
    LastButtonIndex = LastButtonIndex + 1;
}
- (IBAction)cellButtonPress_1_5:(id)sender {
    [self buttonPressGeneric:sender];
    CorrectionArray[LastButtonIndex] = 4;
    LastButtonIndex = LastButtonIndex + 1;
}
- (IBAction)cellButtonPress_1_6:(id)sender {
    [self buttonPressGeneric:sender];
    CorrectionArray[LastButtonIndex] = 5;
    LastButtonIndex = LastButtonIndex + 1;
}
- (IBAction)cellButtonPress_1_7:(id)sender {
    [self buttonPressGeneric:sender];
    CorrectionArray[LastButtonIndex] = 6;
    LastButtonIndex = LastButtonIndex + 1;
}
- (IBAction)cellButtonPress_2_1:(id)sender {
    [self buttonPressGeneric:sender];
    CorrectionArray[LastButtonIndex] = 7;
    LastButtonIndex = LastButtonIndex + 1;
}
- (IBAction)cellButtonPress_2_2:(id)sender {
    [self buttonPressGeneric:sender];
    CorrectionArray[LastButtonIndex] = 8;
    LastButtonIndex = LastButtonIndex + 1;
}
- (IBAction)cellButtonPress_2_3:(id)sender {
    [self buttonPressGeneric:sender];
    CorrectionArray[LastButtonIndex] = 9;
    LastButtonIndex = LastButtonIndex + 1;
}
- (IBAction)cellButtonPress_2_4:(id)sender {
    [self buttonPressGeneric:sender];
    CorrectionArray[LastButtonIndex] = 10;
    LastButtonIndex = LastButtonIndex + 1;
}
- (IBAction)cellButtonPress_2_5:(id)sender {
    [self buttonPressGeneric:sender];
    CorrectionArray[LastButtonIndex] = 11;
    LastButtonIndex = LastButtonIndex + 1;
}
- (IBAction)cellButtonPress_2_6:(id)sender {
    [self buttonPressGeneric:sender];
    CorrectionArray[LastButtonIndex] = 12;
    LastButtonIndex = LastButtonIndex + 1;
}
- (IBAction)cellButtonPress_2_7:(id)sender {
    [self buttonPressGeneric:sender];
    CorrectionArray[LastButtonIndex] = 13;
    LastButtonIndex = LastButtonIndex + 1;
}
- (IBAction)cellButtonPress_3_1:(id)sender {
    [self buttonPressGeneric:sender];
    CorrectionArray[LastButtonIndex] = 14;
    LastButtonIndex = LastButtonIndex + 1;
}
- (IBAction)cellButtonPress_3_2:(id)sender {
    [self buttonPressGeneric:sender];
    CorrectionArray[LastButtonIndex] = 15;
    LastButtonIndex = LastButtonIndex + 1;
}
- (IBAction)cellButtonPress_3_3:(id)sender {
    [self buttonPressGeneric:sender];
    CorrectionArray[LastButtonIndex] = 16;
    LastButtonIndex = LastButtonIndex + 1;
}
- (IBAction)cellButtonPress_3_4:(id)sender {
    [self buttonPressGeneric:sender];
    CorrectionArray[LastButtonIndex] = 17;
    LastButtonIndex = LastButtonIndex + 1;
}
- (IBAction)cellButtonPress_3_5:(id)sender {
    [self buttonPressGeneric:sender];
    CorrectionArray[LastButtonIndex] = 18;
    LastButtonIndex = LastButtonIndex + 1;
}
- (IBAction)cellButtonPress_3_6:(id)sender {
    [self buttonPressGeneric:sender];
    CorrectionArray[LastButtonIndex] = 19;
    LastButtonIndex = LastButtonIndex + 1;
}
- (IBAction)cellButtonPress_3_7:(id)sender {
    [self buttonPressGeneric:sender];
    CorrectionArray[LastButtonIndex] = 20;
    LastButtonIndex = LastButtonIndex + 1;
}
- (IBAction)cellButtonPress_4_1:(id)sender {
    [self buttonPressGeneric:sender];
    CorrectionArray[LastButtonIndex] = 21;
    LastButtonIndex = LastButtonIndex + 1;
}
- (IBAction)cellButtonPress_4_2:(id)sender {
    [self buttonPressGeneric:sender];
    CorrectionArray[LastButtonIndex] = 22;
    LastButtonIndex = LastButtonIndex + 1;
}
- (IBAction)cellButtonPress_4_3:(id)sender {
    [self buttonPressGeneric:sender];
    CorrectionArray[LastButtonIndex] = 23;
    LastButtonIndex = LastButtonIndex + 1;
}
- (IBAction)cellButtonPress_4_4:(id)sender {
    [self buttonPressGeneric:sender];
    CorrectionArray[LastButtonIndex] = 24;
    LastButtonIndex = LastButtonIndex + 1;
}
- (IBAction)cellButtonPress_4_5:(id)sender {
    [self buttonPressGeneric:sender];
    CorrectionArray[LastButtonIndex] = 25;
    LastButtonIndex = LastButtonIndex + 1;
}
- (IBAction)cellButtonPress_4_6:(id)sender {
    [self buttonPressGeneric:sender];
    CorrectionArray[LastButtonIndex] = 26;
    LastButtonIndex = LastButtonIndex + 1;
}
- (IBAction)cellButtonPress_4_7:(id)sender {
    [self buttonPressGeneric:sender];
    CorrectionArray[LastButtonIndex] = 27;
    LastButtonIndex = LastButtonIndex + 1;
}
- (IBAction)cellButtonPress_5_1:(id)sender {
    [self buttonPressGeneric:sender];
    CorrectionArray[LastButtonIndex] = 28;
    LastButtonIndex = LastButtonIndex + 1;
}
- (IBAction)cellButtonPress_5_2:(id)sender {
    [self buttonPressGeneric:sender];
    CorrectionArray[LastButtonIndex] = 29;
    LastButtonIndex = LastButtonIndex + 1;
}
- (IBAction)cellButtonPress_5_3:(id)sender {
    [self buttonPressGeneric:sender];
    CorrectionArray[LastButtonIndex] = 30;
    LastButtonIndex = LastButtonIndex + 1;
}
- (IBAction)cellButtonPress_5_4:(id)sender {
    [self buttonPressGeneric:sender];
    CorrectionArray[LastButtonIndex] = 31;
    LastButtonIndex = LastButtonIndex + 1;
}
- (IBAction)cellButtonPress_5_5:(id)sender {
    [self buttonPressGeneric:sender];
    CorrectionArray[LastButtonIndex] = 32;
    LastButtonIndex = LastButtonIndex + 1;
}
- (IBAction)cellButtonPress_5_6:(id)sender {
    [self buttonPressGeneric:sender];
    CorrectionArray[LastButtonIndex] = 33;
    LastButtonIndex = LastButtonIndex + 1;
}
- (IBAction)cellButtonPress_5_7:(id)sender {
    [self buttonPressGeneric:sender];
    CorrectionArray[LastButtonIndex] = 34;
    LastButtonIndex = LastButtonIndex + 1;
}
- (IBAction)cellButtonPress_6_1:(id)sender {
    [self buttonPressGeneric:sender];
    CorrectionArray[LastButtonIndex] = 35;
    LastButtonIndex = LastButtonIndex + 1;
}
- (IBAction)cellButtonPress_6_2:(id)sender {
    [self buttonPressGeneric:sender];
    CorrectionArray[LastButtonIndex] = 36;
    LastButtonIndex = LastButtonIndex + 1;
}
- (IBAction)cellButtonPress_6_3:(id)sender {
    [self buttonPressGeneric:sender];
    CorrectionArray[LastButtonIndex] = 37;
    LastButtonIndex = LastButtonIndex + 1;
}
- (IBAction)cellButtonPress_6_4:(id)sender {
    [self buttonPressGeneric:sender];
    CorrectionArray[LastButtonIndex] = 38;
    LastButtonIndex = LastButtonIndex + 1;
}
- (IBAction)cellButtonPress_6_5:(id)sender {
    [self buttonPressGeneric:sender];
    CorrectionArray[LastButtonIndex] = 39;
    LastButtonIndex = LastButtonIndex + 1;
}
- (IBAction)cellButtonPress_6_6:(id)sender {
    [self buttonPressGeneric:sender];
    CorrectionArray[LastButtonIndex] = 40;
    LastButtonIndex = LastButtonIndex + 1;
}
- (IBAction)cellButtonPress_6_7:(id)sender {
    [self buttonPressGeneric:sender];
    CorrectionArray[LastButtonIndex] = 41;
    LastButtonIndex = LastButtonIndex + 1;
}
- (IBAction)cellButtonPress_7_1:(id)sender {
    [self buttonPressGeneric:sender];
    CorrectionArray[LastButtonIndex] = 42;
    LastButtonIndex = LastButtonIndex + 1;
}
- (IBAction)cellButtonPress_7_2:(id)sender {
    [self buttonPressGeneric:sender];
    CorrectionArray[LastButtonIndex] = 43;
    LastButtonIndex = LastButtonIndex + 1;
}
- (IBAction)cellButtonPress_7_3:(id)sender {
    [self buttonPressGeneric:sender];
    CorrectionArray[LastButtonIndex] = 44;
    LastButtonIndex = LastButtonIndex + 1;
}
- (IBAction)cellButtonPress_7_4:(id)sender {
    [self buttonPressGeneric:sender];
    CorrectionArray[LastButtonIndex] = 45;
    LastButtonIndex = LastButtonIndex + 1;
}
- (IBAction)cellButtonPress_7_5:(id)sender {
    [self buttonPressGeneric:sender];
    CorrectionArray[LastButtonIndex] = 46;
    LastButtonIndex = LastButtonIndex + 1;
}
- (IBAction)cellButtonPress_7_6:(id)sender {
    [self buttonPressGeneric:sender];
    CorrectionArray[LastButtonIndex] = 47;
    LastButtonIndex = LastButtonIndex + 1;
}
- (IBAction)cellButtonPress_7_7:(id)sender {
    [self buttonPressGeneric:sender];
    CorrectionArray[LastButtonIndex] = 48;
    LastButtonIndex = LastButtonIndex + 1;
}

- (void)enableAllButtonCells{
    //enable all the buttons again
    cell_1_1.enabled = YES;
    cell_1_2.enabled = YES;
    cell_1_3.enabled = YES;
    cell_1_4.enabled = YES;
    cell_1_5.enabled = YES;
    cell_1_6.enabled = YES;
    cell_1_7.enabled = YES;
    cell_2_1.enabled = YES;
    cell_2_2.enabled = YES;
    cell_2_3.enabled = YES;
    cell_2_4.enabled = YES;
    cell_2_5.enabled = YES;
    cell_2_6.enabled = YES;
    cell_2_7.enabled = YES;
    cell_3_1.enabled = YES;
    cell_3_2.enabled = YES;
    cell_3_3.enabled = YES;
    cell_3_4.enabled = YES;
    cell_3_5.enabled = YES;
    cell_3_6.enabled = YES;
    cell_3_7.enabled = YES;
    cell_4_1.enabled = YES;
    cell_4_2.enabled = YES;
    cell_4_3.enabled = YES;
    cell_4_4.enabled = YES;
    cell_4_5.enabled = YES;
    cell_4_6.enabled = YES;
    cell_4_7.enabled = YES;
    cell_5_1.enabled = YES;
    cell_5_2.enabled = YES;
    cell_5_3.enabled = YES;
    cell_5_4.enabled = YES;
    cell_5_5.enabled = YES;
    cell_5_6.enabled = YES;
    cell_5_7.enabled = YES;
    cell_6_1.enabled = YES;
    cell_6_2.enabled = YES;
    cell_6_3.enabled = YES;
    cell_6_4.enabled = YES;
    cell_6_5.enabled = YES;
    cell_6_6.enabled = YES;
    cell_6_7.enabled = YES;
    cell_7_1.enabled = YES;
    cell_7_2.enabled = YES;
    cell_7_3.enabled = YES;
    cell_7_4.enabled = YES;
    cell_7_5.enabled = YES;
    cell_7_6.enabled = YES;
    cell_7_7.enabled = YES;
}

- (void)disableAllButtonCells{
    cell_1_1.enabled = NO;
    cell_1_2.enabled = NO;
    cell_1_3.enabled = NO;
    cell_1_4.enabled = NO;
    cell_1_5.enabled = NO;
    cell_1_6.enabled = NO;
    cell_1_7.enabled = NO;
    cell_2_1.enabled = NO;
    cell_2_2.enabled = NO;
    cell_2_3.enabled = NO;
    cell_2_4.enabled = NO;
    cell_2_5.enabled = NO;
    cell_2_6.enabled = NO;
    cell_2_7.enabled = NO;
    cell_3_1.enabled = NO;
    cell_3_2.enabled = NO;
    cell_3_3.enabled = NO;
    cell_3_4.enabled = NO;
    cell_3_5.enabled = NO;
    cell_3_6.enabled = NO;
    cell_3_7.enabled = NO;
    cell_4_1.enabled = NO;
    cell_4_2.enabled = NO;
    cell_4_3.enabled = NO;
    cell_4_4.enabled = NO;
    cell_4_5.enabled = NO;
    cell_4_6.enabled = NO;
    cell_4_7.enabled = NO;
    cell_5_1.enabled = NO;
    cell_5_2.enabled = NO;
    cell_5_3.enabled = NO;
    cell_5_4.enabled = NO;
    cell_5_5.enabled = NO;
    cell_5_6.enabled = NO;
    cell_5_7.enabled = NO;
    cell_6_1.enabled = NO;
    cell_6_2.enabled = NO;
    cell_6_3.enabled = NO;
    cell_6_4.enabled = NO;
    cell_6_5.enabled = NO;
    cell_6_6.enabled = NO;
    cell_6_7.enabled = NO;
    cell_7_1.enabled = NO;
    cell_7_2.enabled = NO;
    cell_7_3.enabled = NO;
    cell_7_4.enabled = NO;
    cell_7_5.enabled = NO;
    cell_7_6.enabled = NO;
    cell_7_7.enabled = NO;
}


- (IBAction)clearButtonPress:(id)sender {//clear button has been pressesd
    
    
    if(gameScore >= 5) {
        gameScore = gameScore - 5;
    }else{
        gameScore = 0;
    }
    
    [Score setText:[NSString stringWithFormat:@"Score %d",gameScore]];
    
    [self enableAllButtonCells];
    
    //reset user string
    userString = @"";
    
    [Feedback setText:@"Try again"];
    clear.hidden = YES;
    correctionButton.hidden = YES;
    LastButtonIndex = 0;
}

//reset with next word
- (IBAction)PlayAgainButtonPress:(id)sender {
    
    NSString *score = [NSString stringWithFormat:@"%d", gameScore];
    if(![score isEqualToString:@"0"])
    {
        [HighScoreViewController saveScore:score];
    }
    

     if (currentWordIndex != [WordList count]-1) {//nil adds to the size of the word list
         currentWordIndex = currentWordIndex + 1;
     }else{
         currentWordIndex = 0;
         [self performSegueWithIdentifier:@"Identifier_levelComplete" sender:(self)];
         
     }
    
     
    currentWord = [WordList objectAtIndex:currentWordIndex];
    
    
    
    [self enableAllButtonCells];
    
    //reset user string
    userString = @"";
    
    
    
    
    //generate the grid again
    [self generateGrid:currentWord];
    
    //reset the instruction label and hide play again button
    [Feedback setText:@"Guess the next word"];
    playAgain.hidden = YES;
    clear.hidden =YES;
    LastButtonIndex = 0;
    
    
    for(int i = 0;i <= 48;i++) {
        
        
        UIButton *myButton = ButtonArray[i];
        myButton.hidden = NO;
        
    }
    //generate the grid again
    [self generateGrid:currentWord];
    
    
}

- (IBAction)CorrectionButtonPress:(id)sender{
    
    if(LastButtonIndex > 0) {
        
        LastButtonIndex = LastButtonIndex - 1;
        

        
        UIButton *myButton = ButtonArray[CorrectionArray[LastButtonIndex]];
        myButton.enabled = YES;
        
    }else{
        UIButton *myButton = ButtonArray[CorrectionArray[LastButtonIndex]];
        myButton.enabled = YES;
        correctionButton.hidden = YES;
        clear.hidden = YES;
    }

    if(LastButtonIndex == 0){
        correctionButton.hidden = YES;
        clear.hidden = YES;
    }
    
    
    if([userString length] >= 1){
        userString = [userString substringToIndex:[userString length]-1];
        
    }else{
        NSLog(@"string is empty");
    }
    
    if(gameScore >=2) {
        gameScore = gameScore - 2;
    }else{
        gameScore = 0;
    }
    [Score setText:[NSString stringWithFormat:@"Score %d",gameScore]];
    
    
        
    
    
}

//the actual generation of the grid
-(void) generateGrid:(NSString *)inString{
    
    [wordLength setText: [NSString stringWithFormat:@"WordLength: %d",[currentWord length]]];
    
    int randNum;//random number used for various things, used and then disregarded
    int nextLetterIndex;//index of the next letter to be added
    
    NSString *lastPos = @"0";//position start default
    
    
    
    
    
    
    for(int i = 0;i<49;i++){//Fills Grid With Random Letters
        
        randNum = arc4random()%(25);
        
        [[ButtonArray objectAtIndex:i] setTitle:[alphabet substringWithRange:NSMakeRange(randNum,1) ] forState:UIControlStateNormal];
        
    }

    //starts off the first letter in the first column
    nextLetterIndex = arc4random()%(6)*7;
    
    [[ButtonArray objectAtIndex:nextLetterIndex] setTitle:[inString substringWithRange:NSMakeRange(0,1) ] forState:UIControlStateNormal];
    
    //for each letter in the word
    for(int i = 1;i<[inString length];i++){
        
        
        if(nextLetterIndex<=6){//top row
            if([lastPos isEqualToString:@"0"] || [lastPos isEqualToString:@"below"]){
                //to ensure a square is not written over
                
                nextLetterIndex = nextLetterIndex + 1;
                lastPos = @"left";
            
            }else if([lastPos isEqualToString:@"left"]){
                //last place was to the left
                
                randNum = arc4random()%(2)+1;
                
                if(randNum == 1){//move left
                    
                    nextLetterIndex = nextLetterIndex + 1;
                    lastPos = @"left";
                    
                }else if(randNum == 2){//move down
                    
                    nextLetterIndex = nextLetterIndex + 7;
                    lastPos = @"above";
                    
                }else{
                    NSLog(@"randNum error in word generation, top row");
                }
                
                
            }

            
            [[ButtonArray objectAtIndex:nextLetterIndex] setTitle:[inString substringWithRange:NSMakeRange(i,1) ] forState:UIControlStateNormal];
            
            
            
            
            
            
        }else if(nextLetterIndex >6 && nextLetterIndex < 42){//not top or bottom row
            
            if ([lastPos isEqualToString:@"0"]) {
                nextLetterIndex = nextLetterIndex + 1;
                lastPos = @"left";
                
                
            }else if([lastPos isEqualToString:@"below"]){
                //last was below
                
                
                randNum = arc4random()%(2);
                
                if(randNum == 0){//move up
                    
                    nextLetterIndex = nextLetterIndex - 7;
                    lastPos = @"below";
                    
                }else if(randNum == 1){//move over
                    
                    nextLetterIndex = nextLetterIndex + 1;
                    lastPos = @"left";
                    
                }else{
                    NSLog(@"randNum error in word generation, middle row, last was below");
                }

            }else if([lastPos isEqualToString:@"left"]){
                //last was to the left
                
                randNum = arc4random()%(3);
                
                
                if(randNum == 0){//move up
                    
                    nextLetterIndex = nextLetterIndex - 7;
                    lastPos = @"below";
                    
                }else if(randNum == 1){//move over
                    
                    nextLetterIndex = nextLetterIndex + 1;
                    lastPos = @"left";
                    
                }else if(randNum == 2){//move down
                    
                    nextLetterIndex = nextLetterIndex + 7;
                    lastPos = @"above";
                    
                    
                }else{
                    NSLog(@"randNum error in word generation, middle row, last was left");
                }

                
                
                
            }else if([lastPos isEqualToString:@"above"]){
                //last was above
                
                randNum = arc4random()%(2);
                
                if(randNum == 0){//move over
                    
                    nextLetterIndex = nextLetterIndex +1;
                    lastPos = @"left";
                    
                }else if(randNum == 1){//move down
                    
                    nextLetterIndex = nextLetterIndex + 7;
                    lastPos = @"above";
                    
                }else{
                    NSLog(@"randNum error in word generation, middle row, last was above");
                }

                
                
                
            }else{
                NSLog(@"if error: lastPos != above, below, left or 0");
            }

            
            
            
            
           
            [[ButtonArray objectAtIndex:nextLetterIndex] setTitle:[inString substringWithRange:NSMakeRange(i,1) ] forState:UIControlStateNormal];
            
        }else if (nextLetterIndex >= 42){
            //bottom row
            
            
            
            if([lastPos isEqualToString:@"above"] || [lastPos isEqualToString:@"0"]){
                //last position was above
                
                nextLetterIndex = nextLetterIndex + 1;
                lastPos = @"left";
                
            }else if([lastPos isEqualToString:@"left"]){
                
                randNum = arc4random()%(1);
                
                
                if(randNum == 0){
                    
                    nextLetterIndex = nextLetterIndex - 7;
                    lastPos = @"below";
                    
                }else if(randNum == 1){
                    
                    nextLetterIndex = nextLetterIndex + 1;
                    lastPos = @"left";
                    
                }else{
                    NSLog(@"randNum error in word generation, bottom row");
                }

            }
            
            
            [[ButtonArray objectAtIndex:nextLetterIndex] setTitle:[inString substringWithRange:NSMakeRange(i,1) ] forState:UIControlStateNormal];
            
        }else{
            NSLog(@"Next letter index error");
        }

    }//endfor
    
    
    
    int i;
    i=0;
    for(int i = 0;i <= 48;i++) {
        if((i)%7 > (nextLetterIndex)%7){
            
            UIButton *myButton = ButtonArray[i];
            myButton.hidden = YES;
        }//endif
    }//endfor
    
    

}//end generateGrid


@end