//
//  ViewController.m
//  KLNetworking
//
//  Created by user on 17/7/21.
//  Copyright © 2017年 user. All rights reserved.
//

#import "ViewController.h"
#import "KLPrestoClient+Version.h"
#import "JVersionInfoModel.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[KLPrestoClient prestoClient]getVersionVersionSuccess:^(JVersionInfoModel *model) {
        NSLog(@"2222222");
    } failure:^(id error) {
        
    }];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
