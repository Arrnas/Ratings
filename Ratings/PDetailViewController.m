//
//  PDetailViewController.m
//  Ratings
//
//  Created by Gludis on 9/11/13.
//  Copyright (c) 2013 Gludis. All rights reserved.
//

#import "PDetailViewController.h"
#import "PlayersViewController.h"
#import "Player.h"

@interface PDetailViewController (){
    Player *playa;
}
@end

@implementation PDetailViewController

@synthesize gameLabel;
@synthesize nameLabel;
@synthesize imageView;
@synthesize ratingCell;
@synthesize stepper;
@synthesize nameTextField;
@synthesize gameTextField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void) viewWillDisappear:(BOOL)animated{
    
}
- (IBAction)stepperChanged:(UIStepper*)sender {
    NSUInteger value = sender.value;
    playa.rating = (int)value;
    self.imageView.image = [self imageForRating:value];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animate
{
    [super setEditing:editing animated:animate];
    if(editing)
    {
        //edit
        self.stepper.hidden = false;
        nameLabel.hidden = true;
        gameLabel.hidden = true;
        nameTextField.text = nameLabel.text;
        gameTextField.text = gameLabel.text;
        nameTextField.hidden = false;
        gameTextField.hidden = false;
    }
    else
    {
        //done
        PlayersViewController *contrl = (PlayersViewController *) self.delegate;
        [contrl recievePlayer:playa];
        [[self navigationController] popViewControllerAnimated:true];
        
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view endEditing:YES];
	self.gameLabel.text = playa.game;
    self.nameLabel.text = playa.name;
    self.stepper.value = playa.rating;
    self.stepper.maximumValue = 5; //oh noes hard code
    self.stepper.minimumValue = 0; //oh noes hard code
    self.stepper.hidden = true;
    self.ratingCell.autoresizesSubviews = true;
    self.imageView.image = [self imageForRating:playa.rating];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(UIImage *)imageForRating:(int)rating{
    switch(rating){
        case 1:
            return [UIImage imageNamed:@"1StarSmall.png"];
        case 2:
            return [UIImage imageNamed:@"2StarsSmall.png"];
        case 3:
            return [UIImage imageNamed:@"3StarsSmall.png"];
        case 4:
            return [UIImage imageNamed:@"4StarsSmall.png"];
        case 5:
            return [UIImage imageNamed:@"5StarsSmall.png"];
    }
    return nil;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) getDetails:(Player*)player{
    playa = player;
}

@end
