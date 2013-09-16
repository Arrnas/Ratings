//
//  PDetailViewController.h
//  Ratings
//
//  Created by Gludis on 9/11/13.
//  Copyright (c) 2013 Gludis. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Player;


@interface PDetailViewController : UITableViewController

@property (nonatomic, strong) id delegate;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UITableViewCell *ratingCell;
@property (strong, nonatomic) IBOutlet UIStepper *stepper;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *gameLabel;
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *gameTextField;

-(void) getDetails:(Player*)player;
- (IBAction)stepperChanged:(id)sender;
- (IBAction)editSelected:(id)sender;

@end
