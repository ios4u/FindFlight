//
//  CitySelectionViewController.m
//  FindFlight
//
//  Created by spens on 01/03/16.
//  Copyright © 2016 ru.spens. All rights reserved.
//

#import "CitySelectionViewController.h"
#import "CityCell.h"

@interface CitySelectionViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation CitySelectionViewController
{
    NSArray *cities;
    BOOL isSearching;
    NSMutableArray *searchResults;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    searchResults = [NSMutableArray new];
    
    self.view.layer.cornerRadius = 5;
    self.tableView.rowHeight = 70;
    
    cities = [DataManager sharedInstance].cities;
    
    [self.searchBar becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isSearching) {
       return searchResults.count;
    }
    return cities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellId = @"CityCell";
    CityCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[CityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    NSDictionary *city;
    if (isSearching) {
        city = searchResults[indexPath.row];
    } else {
        city = cities[indexPath.row];
    }
    cell.nameLabel.text = city[@"name"];
    cell.codeLabel.text = city[@"code"];
    cell.locationLabel.text = [[DataManager sharedInstance] airportNameForCityCode:city[@"code"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.completion) {
        if (isSearching) {
            self.completion(searchResults[indexPath.row]);
        } else {
            self.completion(cities[indexPath.row]);
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length) {
        isSearching = YES;
        
        [searchResults removeAllObjects];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            for (NSDictionary *city in cities) {
                if ([[city[@"name"] lowercaseString]  ?: @"" containsString:searchText.lowercaseString])
                {
                    [searchResults addObject:city];
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        });
    } else {
        if ([searchBar respondsToSelector:@selector(resignFirstResponder)]) {
            [searchBar performSelectorOnMainThread:@selector(resignFirstResponder) withObject:nil waitUntilDone:NO];
        }
        isSearching = NO;
        [self.tableView reloadData];
    }
}


- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    if ([searchBar respondsToSelector:@selector(resignFirstResponder)]) {
        [searchBar performSelectorOnMainThread:@selector(resignFirstResponder) withObject:nil waitUntilDone:NO];
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    if ([searchBar respondsToSelector:@selector(resignFirstResponder)]) {
        [searchBar performSelectorOnMainThread:@selector(resignFirstResponder) withObject:nil waitUntilDone:NO];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if ([searchBar respondsToSelector:@selector(resignFirstResponder)]) {
        [searchBar performSelectorOnMainThread:@selector(resignFirstResponder) withObject:nil waitUntilDone:NO];
    }
}

@end
