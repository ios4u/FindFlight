//
//  ResultsViewController.m
//  FindFlight
//
//  Created by spens on 01/03/16.
//  Copyright © 2016 ru.spens. All rights reserved.
//

#import "ResultsViewController.h"
#import "FlightCell.h"

@interface ResultsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *navbarLabel;

@end

@implementation ResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.view.layer.cornerRadius = 5;
    
    self.tableView.estimatedRowHeight = 150;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.navbarLabel.text = self.navbarText;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonHandler:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.offers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.single) {
        NSString *cellId = @"FlightCellSingle";
        FlightCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[FlightCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        
        NSDictionary *offer = self.offers[indexPath.row];
        
        NSString *dateString = offer[@"departure_at"];
        dateString = [dateString stringByReplacingOccurrencesOfString:@":00Z" withString:@""];
        NSArray *arr = [dateString componentsSeparatedByString:@"T"];
        
        cell.price.text = string(@"$ %.2f", [offer[@"price"] floatValue]);
        cell.destinationTo.text = string(@"%@ • %@", self.fromCode, self.toCode);
        cell.timeTo.text = string(@"%@ - %@", arr.lastObject, @"");
        cell.flightTimeTo.text = @"00h 00m";
        
        [[RequestManager sharedInstance] getLogoForCompany:offer[@"airline"] completion:^(UIImage *image) {
            cell.logo.image = image;
        }];

        return cell;
    } else {
        NSString *cellId = @"FlightCell";
        FlightCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[FlightCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        
        NSDictionary *offer = self.offers[indexPath.row];
        
        NSString *dateString = offer[@"departure_at"];
        dateString = [dateString stringByReplacingOccurrencesOfString:@":00Z" withString:@""];
        NSArray *arr = [dateString componentsSeparatedByString:@"T"];
        
        cell.price.text = string(@"$ %.2f", [offer[@"price"] floatValue]);
        cell.destinationTo.text = string(@"%@ • %@", self.fromCode, self.toCode);
        cell.timeTo.text = string(@"%@ - %@", arr.lastObject, @"");
        cell.flightTimeTo.text = @"00h 00m";
        
        dateString = offer[@"return_at"];
        dateString = [dateString stringByReplacingOccurrencesOfString:@":00Z" withString:@""];
        arr = [dateString componentsSeparatedByString:@"T"];
        
        cell.destinationReturn.text = string(@"%@ • %@", self.toCode, self.fromCode);
        cell.timeReturn.text = string(@"%@ - %@", arr.lastObject, @"");
        cell.flightTimeReturn.text = @"00h 00m";
        
        [[RequestManager sharedInstance] getLogoForCompany:offer[@"airline"] completion:^(UIImage *image) {
            cell.logo.image = image;
        }];
        
        return cell;
    }
}

@end
