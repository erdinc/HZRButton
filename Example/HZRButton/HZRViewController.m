//
//  HZRViewController.m
//  HZRButton
//
//  Created by Erdinc Akkaya on 11/21/2014.
//  Copyright (c) 2014 Erdinc Akkaya. All rights reserved.
//

#import "HZRViewController.h"
#import <HZRButton/HZRButton.h>
@interface HZRViewController ()

@end

@implementation HZRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    HZRButton *button = [[HZRButton alloc]init];
    button.frame = CGRectMake(80, 200, 160, 50);
    [button setTitle:@"SAVE" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor colorWithRed:0.10196f green:0.73725f blue:0.61176f alpha:1.0];
    [self.view addSubview:button];
    
    HZRButton *buttonYellow = [[HZRButton alloc]init];
    buttonYellow.frame = CGRectMake(80, 270, 160, 50);
    [buttonYellow setTitle:@"SAVE" forState:UIControlStateNormal];
    [buttonYellow addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
    buttonYellow.backgroundColor = [UIColor colorWithRed:0.901f green:0.4941f blue:0.1333f alpha:1.0];
    [self.view addSubview:buttonYellow];
    
    
}


- (void)save:(HZRButton *)sender{
    [sender updatePercentage:1.0];
}

- (void)animatingButtonDidFinishLoading:(HZRButton *)button{
    NSLog(@"loading finished %@", button);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
