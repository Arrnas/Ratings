//
//  PlayersViewController.m
//  Ratings
//
//  Created by Gludis on 9/10/13.
//  Copyright (c) 2013 Gludis. All rights reserved.
//http://s1.15cdn.lt/static/json/mobile_app_cosite.json
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) 
#define kLatestKivaLoansURL [NSURL URLWithString:@"http://api.kivaws.org/v1/loans/search.json"]
#define k15MinURL [NSURL URLWithString:@"http://s1.15cdn.lt/static/json/mobile_app_cosite.json"]

#import "PlayersViewController.h"
#import "PDetailViewController.h"
#import "Player.h"
#import "PlayerCell.h"
#import "MFSideMenu.h"
#import "AsyncImageView.h"
#import <QuartzCore/QuartzCore.h>

@implementation PlayersViewController{
    int selected_row;
}

@synthesize players;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)sidebarMenu:(id)sender {
    [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
}

-(void) recievePlayer:(Player *) player{
    for(Player *playa in players){
        if([player isEqual:playa])
            playa.rating = player.rating;
    }
}

- (void)fetchedData:(NSData *)responseData {
    //parse out the json data
    NSError* error;
    NSArray* json = [NSJSONSerialization
                          JSONObjectWithData:responseData //1
                          
                          options:kNilOptions
                          error:&error];
   for(NSDictionary *data in json){
        Player *player = [[Player alloc] init];
        player.name = [data objectForKey:@"name"];
        player.game = [data objectForKey:@"url"];
        player.rating = 4;
        player.iconURL = [NSURL URLWithString:[data objectForKey:@"icon"]];
        [self addPlayerToList:player];
    }
    //NSArray* latestLoans = [json allValues]; //2
    
    //NSLog(@"loans: %@", [json objectAtIndex:0]); //3
}

- (void)viewDidLoad
{
    self.players = [NSMutableArray arrayWithCapacity:20];
    [super viewDidLoad];
    dispatch_async(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL:k15MinURL];
        [self performSelectorOnMainThread:@selector(fetchedData:)
                               withObject:data waitUntilDone:YES];
    });
//    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
//                                          initWithTarget:self action:@selector(handleLongPress:)];
//    lpgr.minimumPressDuration = 2.0; //seconds
//    lpgr.delegate = self;
    //[self.tableView addGestureRecognizer:lpgr];
    
    // Change button color

    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
       
    // Set the gesture
    //[self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

    //[lpgr release];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    CGPoint p = [gestureRecognizer locationInView:self.tableView];
    
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:p];
    if (indexPath == nil)
        NSLog(@"long press on table view but not on a row");
    else{
        NSLog(@"long press on table view at row %d", indexPath.row);
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.players count];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (editingStyle == UITableViewCellEditingStyleDelete)
	{
		[self.players removeObjectAtIndex:indexPath.row];
		[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
	}
}
-(void) viewDidAppear:(BOOL)animated
{
    [self.tableView reloadData];
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
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PlayerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlayerCell"];
	Player *player = [self.players objectAtIndex:indexPath.row];
    cell.nameLabel.text = player.name;
    cell.gameLabel.text = player.game;
    cell.ratingImageView.image = [self imageForRating:player.rating];
    [cell.icon setImageURL:player.iconURL];

    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"AddPlayer"])
	{
		UINavigationController *navigationController = segue.destinationViewController;
		PlayerDetailsViewController *playerDetailsViewController = [[navigationController viewControllers] objectAtIndex:0];
		playerDetailsViewController.delegate = self;
	}
    else if ([segue.identifier isEqualToString:@"ShowTheD"])
	{
		PDetailViewController *navigationController = segue.destinationViewController;
        navigationController.delegate = self;
		[navigationController getDetails:[players objectAtIndex:selected_row]];
    }
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selected_row = indexPath.row;
    [self performSegueWithIdentifier:@"ShowTheD" sender:self];
  //  [self performSegueWithIdentifier: @"ShowDetail" sender: self];
}
#pragma mark - PlayerDetailsViewControllerDelegate

- (void)playerDetailsViewControllerDidCancel:
(PlayerDetailsViewController *)controller
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)playerDetailsViewControllerDidSave:
(PlayerDetailsViewController *)controller
{
	[self dismissViewControllerAnimated:YES completion:nil];
}
-(void)addPlayer:(Player *)player{
    [self.players addObject:player];
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.players count] - 1 inSection:0];
	[self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}
-(void)addPlayerToList:(Player *)player{
    [self.players addObject:player];
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.players count] - 1 inSection:0];
	[self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}
- (void)playerDetailsViewController:
(PlayerDetailsViewController *)controller
                       didAddPlayer:(Player *)player
{
    [self addPlayerToList:player];
	[self dismissViewControllerAnimated:YES completion:nil];
}
@end
