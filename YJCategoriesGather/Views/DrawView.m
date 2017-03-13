//
//  DrawView.m
//  YJCategoriesGather
//
//  Created by YJHou on 2014/11/4.
//  Copyright © 2014年 侯跃军 houmanager@Hotmail.com. All rights reserved.
//

#import "DrawView.h"

@implementation DrawView


- (void)drawRect:(CGRect)rect {
    
    UIColor *color = [UIColor orangeColor];
    [color set];
    
    UIBezierPath *drawPath = [UIBezierPath yj_customBezierPathOfPencilSymbolWithRect:CGRectMake(50, 100, 100, 100) scale:2 thick:3];
    [drawPath fill];
    
    
}

@end
