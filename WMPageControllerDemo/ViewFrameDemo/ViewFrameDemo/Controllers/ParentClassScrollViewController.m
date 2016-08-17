//
//  ParentClassScrollViewController.m
//  Kitchen
//
//  Created by su on 16/7/8.
//  Copyright © 2016年 susu. All rights reserved.
//

#import "ParentClassScrollViewController.h"

@interface ParentClassScrollViewController ()<UIGestureRecognizerDelegate>

@end

@implementation ParentClassScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptMsg:) name:@"goTop" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptMsg:) name:@"leaveTop" object:nil];
}

-(void)acceptMsg : (NSNotification *)notification{
    
    NSString *notificationName = notification.name;
    
    if ([notificationName isEqualToString:@"goTop"]) {
        NSDictionary *userInfo = notification.userInfo;
        NSString *canScroll = userInfo[@"canScroll"];
        if ([canScroll isEqualToString:@"1"]) {
            self.canScroll = YES;
            self.scrollView.showsVerticalScrollIndicator = YES;
        }
    }else if([notificationName isEqualToString:@"leaveTop"]){
        self.scrollView.contentOffset = CGPointZero;
        self.canScroll = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
    }
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
   
    if (!self.canScroll) {
        
        [scrollView setContentOffset:CGPointZero];
    }
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY<0) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"leaveTop" object:nil userInfo:@{@"canScroll":@"1"}];
    }
    
    _scrollView = scrollView;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
