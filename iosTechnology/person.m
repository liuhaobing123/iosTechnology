//
//  person.m
//  iosTechnology
//
//  Created by Haobing Liu on 2020/7/22.
//  Copyright © 2020 Haobing Liu. All rights reserved.
//

#import "person.h"

@interface person ()

{
  NSString *_name;
}
@property (nonatomic, strong, readonly) NSString *name;


@end

@implementation person

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)setName:(NSString *)name
{
    NSLog(@"%s----------%@",__func__,name);
  name = name;
}

- (NSString *)name
{
    NSLog(@"%s----------%@",__func__,_name);
    return _name;
}


@end
