//
//  ViewController.m
//  iosTechnology
//
//  Created by Haobing Liu on 2020/7/22.
//  Copyright © 2020 Haobing Liu. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "person.h"
#import "Test.h"
#import "Test1.h"

@interface ViewController ()

@property(nonatomic,strong) Test *test1;
@property(nonatomic,strong) UIButton *btn;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor redColor];
  [self.view addSubview:self.btn];
  
  self.test1 = [[Test alloc] init];
  
  //第一个参数 observer：观察者 （这里观察self.myKVO对象的属性变化）
  //第二个参数 keyPath： 被观察的属性名称(这里观察 self.myKVO 中 num 属性值的改变)
  //第三个参数 options： 观察属性的新值、旧值等的一些配置（枚举值，可以根据需要设置，例如这里可以使用两项）
  //第四个参数 context： 上下文，可以为 KVO 的回调方法传值（例如设定为一个放置数据的字典）
  [self.test1 addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
//   //Test生成对象
//   Test *test = [[Test alloc] init];
//   //Test1生成对象
//   Test1 *test1 = [[Test1 alloc] init];
//   //通过KVC设值test的"test1"(如果不调用，会取不到test1中的那么值)
//   [test setValue:test1 forKey:@"test1"];
//   //通过KVC设值test的"test1的name"
//   [test setValue:@"xiaoming" forKeyPath:@"test1.name"];
//   //通过KVC取值age打印（ ）
//   NSLog(@"test的\"test1的name\"是%@", [test valueForKeyPath:@"test1.name"]);
}

/* 2.只要object的keyPath属性发生变化，就会调用此回调方法，进行相应的处理：UI更新：*/
-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary<NSString *,id> *)change
                      context:(void *)context
{
    // 判断是否为self.myKVO的属性“num”:
    if([keyPath isEqualToString:@"name"] && object == self.test1) {
        // 响应变化处理：UI更新（label文本改变）
        NSLog(@"%@",[NSString stringWithFormat:@"当前的num值为：%@",
        [change valueForKey:@"new"]]);
        
        //change的使用：上文注册时，枚举为2个，因此可以提取change字典中的新、旧值的这两个方法
        NSLog(@"\\noldnum:%@ newnum:%@",
              [change valueForKey:@"old"],
              [change valueForKey:@"new"]);
    }
}

- (UIButton *)btn
{
  if (!_btn)
  {
    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn.backgroundColor = [UIColor blueColor];
    _btn.frame = CGRectMake(50, 50, 80, 80);
    [_btn addTarget:self action:@selector(btns) forControlEvents:UIControlEventTouchUpInside];
  }
  return _btn;
}



-(void)btns
{
  self.test1.name = @"34";
  
}

@end
