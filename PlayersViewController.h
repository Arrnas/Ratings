//
//  PlayersViewController.h
//  Ratings
//
//  Created by Gludis on 9/10/13.
//  Copyright (c) 2013 Gludis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayerDetailsViewController.h"
#import "AsyncImageView.h"

@interface PlayersViewController : UITableViewController <PlayerDetailsViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *players;

-(void) recievePlayer:(Player *) player;
-(void) fetchedData:(NSData *)responseData;
-(void) addPlayerToList:(Player *)player;
@end
