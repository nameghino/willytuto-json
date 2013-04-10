//
//  HotelListViewController.m
//  JSON Tuto
//
//  Created by Nicolas Ameghino on 10/04/13.
//  Copyright (c) 2013 Nicolas Ameghino. All rights reserved.
//

#import "HotelListViewController.h"

#import "HotelDetailViewController.h"

@interface HotelListViewController ()

@property(nonatomic, strong) id hotels;

@end

@implementation HotelListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) loadHotels {
    // Path to json data file
    NSString *jsonDataFilePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"DataHotel.json"];
    
    // Get bytes from source
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonDataFilePath];
    
    // Parse and sort using the "name" key
    self.hotels = [[NSJSONSerialization JSONObjectWithData:jsonData
                                                   options:0
                                                     error:nil]
                   sortedArrayUsingDescriptors:@[
                    [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]
                   ]];
    
    // Reload table when done
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set controller title
    self.navigationItem.title = @"Hoteles";
    
    // Register cell type
    [self.tableView registerClass:NSClassFromString(@"UITableViewCell") forCellReuseIdentifier:@"HotelCell"];
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Load hotels
    [self loadHotels];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(UIImage*) getStarImageForHotel:(id) hotel {
    NSString* pattern = @"%d-star@full.png";
    NSString* starCountString = [hotel[@"stars"] substringWithRange:NSMakeRange(5, 1)];
    NSInteger starCount = [starCountString integerValue];
    return [UIImage imageNamed:[NSString stringWithFormat:pattern, starCount]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.hotels count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"HotelCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    id hotel = self.hotels[indexPath.row];
    cell.textLabel.text = hotel[@"name"];
    cell.imageView.image = [self getStarImageForHotel:hotel];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    id hotel = self.hotels[indexPath.row];
    
    HotelDetailViewController *hdvc = [[HotelDetailViewController alloc] initWithStyle:UITableViewStyleGrouped];
    hdvc.selectedHotel = hotel;
    
    [self.navigationController pushViewController:hdvc animated:YES];
}

@end
