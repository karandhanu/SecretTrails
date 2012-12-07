//
//  GameInputOutput.h
//  secret trails
//
//  Created by Jesse Rintoul on 2012-11-23.
//  Copyright (c) 2012 Jesse Rintoul. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GameInputOutput : NSObject
+ (void)gameDataFromJSON:(NSString *)filePath outputWordsTo:(NSMutableArray *)outputWordsArray outputSpellingsTo:(NSMutableArray *)outputSpellingsArray;
+ (void) writeJsonToFile:(NSString *)token;
+ (BOOL)isDataSourceAvailable;





@end
