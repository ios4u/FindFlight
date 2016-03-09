//
//  EnterViewController.m
//  FindFlight
//
//  Created by spens on 28/02/16.
//  Copyright © 2016 ru.spens. All rights reserved.
//

#import "EnterViewController.h"

@interface EnterViewController ()

@property (weak, nonatomic) IBOutlet UIView *whitePlaceholder;

@end

@implementation EnterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.whitePlaceholder.alpha = 0;
    }];
}

@end
