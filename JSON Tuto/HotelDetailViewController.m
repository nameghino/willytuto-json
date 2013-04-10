//
//  HotelDetailViewController.m
//  JSON Tuto
//
//  Created by Nicolas Ameghino on 10/04/13.
//  Copyright (c) 2013 Nicolas Ameghino. All rights reserved.
//

#import "HotelDetailViewController.h"

@interface HotelDetailViewController ()
@property(nonatomic, strong) NSArray *sortedKeys;
@end

@implementation HotelDetailViewController

-(void)setSelectedHotel:(id)selectedHotel {
    _selectedHotel = selectedHotel;
    self.navigationItem.title = selectedHotel[@"name"];
    self.sortedKeys = [[selectedHotel allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:NSClassFromString(@"UITableViewCell") forCellReuseIdentifier:@"Cell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.selectedHotel allKeys] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    id key = self.sortedKeys[indexPath.section];
    
    id value = self.selectedHotel[key];
    if (![value isKindOfClass:NSClassFromString(@"NSString")]) {
        value = [value description];
    }
    
    cell.textLabel.text = value;
    return cell;
}

-(NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.sortedKeys[section] capitalizedString];
}

#pragma mark - Table view delegate

-(BOOL) tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath { return NO; }


@end
