//
//  person.m
//  iosTechnology
//
//  Created by Haobing Liu on 2020/7/22.
//  Copyright © 2020 Haobing Liu. All rights reserved.
//

#import "person.h"

@interface person ()

@property(nonatomic, strong) NSString *str1;
@property(nonatomic, strong) NSString *str2;
@property(nonatomic, strong) NSString *str3;

@end

@implementation person

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) test1 {
  NSLog(@"我是test1");
  NSLog(@"我是test2");
}

- (void) test2 {
  NSLog(@"我是test2");
}

- (void) test3 {
  NSLog(@"我是test3");
}

@end
