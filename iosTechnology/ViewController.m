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
#import<LinkAccount_Lib/LinkAccount.h>

static NSString *imageURLKey = @"imageURLKey";

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor redColor];
  
  [LMAuthSDKManager initWithKey:@"1ee12f2ab627b3d11ef7a38762c7cd2b" complete:^(NSDictionary * _Nonnull resultDic) {
      NSLog(@"%@", resultDic);
  }];
}

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  //NSLog(@"%f",self.height);
  
  //获得所有的属性
//  unsigned int count;
//  Ivar *allVariables = class_copyIvarList([person class], &count);
//  for (int i = 0; i < count; i++) {
//    //遍历每一个变量，包含名称和类型（此处没有"*"）
//    Ivar ivar = allVariables[i];
//    //runtime机制是纯c的api，所以用const char获取
//    //获取成员变量名称
//    const char *Variablename = ivar_getName(ivar);
//    //获取成员变量类型
//    const char *VariableType  = ivar_getTypeEncoding(ivar);
//     NSLog(@"(Name: %s) ----- (Type:%s)",Variablename,VariableType);
//  }
  
  //获取所有的方法
  //无符号 unsigned存储更多数据
//  unsigned int count;
//  //获取方法列表，所有在.m文件显式实现的方法都会被找到，包括setter+getter方法：
//  Method *allMethods = class_copyMethodList([person class], &count);
//  for(int i =0;i<count;i++)
//  {
//      //Method：runtime声明的一个宏，表示一个方法
//      Method md = allMethods[i];
//      //获取SEL：SEL类型,即获取方法选择器@selector()
//      SEL sel = method_getName(md);
//       //得到sel的方法名：以字符串格式获取sel的name，也即@selector()中的方法名称
//      const char *methodname = sel_getName(sel);
//      NSLog(@"(Method:%s)",methodname);
//  }
  
  //动态改变对应的属性的值
//  person *per = [person new];
//  per.str5 = @"123";
//  NSLog(@"改变前的person：%@",per.str5);
//  unsigned int count = 0;
//  Ivar *allList = class_copyIvarList([person class], &count);
//  //从第一个方法getAllVariable中输出的控制台信息，我们可以看到name为第一个实例属性；(如果不知道是哪个还要对应循环查找)
//  Ivar ivv = allList[0];
//  //name属性Tom被强制改为Mike（第一个值为对象，第二个值为变量，第三个值为改变变量的值）
//  object_setIvar(per, ivv, @"Mike");
//  NSLog(@"改变之后的person：%@",per.str5);
  
  //交换两种方法（功能对调）
//  Method method1 = class_getInstanceMethod([person class], @selector(test1));
//  Method method2 = class_getInstanceMethod([person class], @selector(test3));
//  method_exchangeImplementations(method1, method2);
//  [[person new] test1];  //输出交换后的效果，需要对比的可以尝试下交换前运行func1；
  
  //新增加属性
  class_addMethod([person class], @selector(newMethod), (IMP)myAddingFunction, 0);
     
  //调用 【如果使用[per method]方法！(在ARC下会报no visible @interface 错误)】
  person *per = [person new];
  [per performSelector:@selector(newMethod)];
    
}

//真正增加的方法
int myAddingFunction(id self, SEL _cmd)
{
    NSLog(@"已新增方法:NewMethod");
    return 10;
}

//只是方法名称而已
- (void)newMethod {
  NSLog(@"新方法已经执行");
}

- (void)setHeight:(float)height
{
    //runtime机制传递要用对象，所以要用nsnumber封装
    NSNumber *num = [[NSNumber alloc] initWithFloat:height];
    //参数1是执行者，参数2是要传递的地址，参数3是要传递的数据，参数4
    objc_setAssociatedObject(self, &imageURLKey, num, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (float)height
{
    NSNumber *number =  objc_getAssociatedObject(self, &imageURLKey);
    //nsnumber解封
    return [number floatValue];
}


@end
