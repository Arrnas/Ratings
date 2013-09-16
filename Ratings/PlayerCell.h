//
//  PlayerCell.h
//  Ratings
//
//  Created by Gludis on 9/10/13.
//  Copyright (c) 2013 Gludis. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AsyncImageView;

@interface PlayerCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *gameLabel;
@property (nonatomic, strong) IBOutlet UIImageView *ratingImageView;
@property (nonatomic, strong) IBOutlet AsyncImageView *icon;

@end
