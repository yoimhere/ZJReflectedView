//
//  ViewController.m
//  Test
//
//  Created by 余志杰 on 15/11/12.
//  Copyright © 2015年 余志杰. All rights reserved.
//

#import "ViewController.h"
#import "ZJReflectedView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor redColor];
    
    
    ZJReflectedView *view = [[ZJReflectedView alloc] initWithFrame:CGRectMake(0, 0, 96, 116)];
    view.imageSize = CGSizeMake(80, 80);//(96 = 8 + 80 + 8 , 116 = 8 + 80 + x + 8 )
    view.image = [UIImage imageNamed:@"222"];
    view.center = self.view.center;
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
