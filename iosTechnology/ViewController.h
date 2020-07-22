//
//  ViewController.h
//  iosTechnology
//
//  Created by Haobing Liu on 2020/7/22.
//  Copyright © 2020 Haobing Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

//首先声明属性，动态生成set，get方法
-(void)setHeight:(float)height;
-(float)height;

@end

