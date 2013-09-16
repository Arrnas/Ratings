//
//  Player.h
//  Ratings
//
//  Created by Gludis on 9/10/13.
//  Copyright (c) 2013 Gludis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *game;
@property (nonatomic, copy) NSURL *iconURL;
@property (nonatomic, assign) int rating;

@end
