//
//  ViewController.swift
//  iosTechnology
//
//  Created by Haobing Liu on 2021/1/12.
//  Copyright © 2021 Haobing Liu. All rights reserved.
//

import UIKit

//串行：因为人多需要排队依次购买，这时就可称为串行。
//并行：因为忙不过来，第二天一个摊子由两个人同时制作和售卖，这时就可称为并行，同理也可以是八个人同时制作和售卖。
//同步：保证先来后到，禁止插队购买。
//异步：可以进行插队购买，照顾特殊人群。

@objcMembers class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
      
        //串行同步队列
      //serialSynchronousQueue()
      
        //串行异步队列
      //serialAsyncSynchronousQueue()
      
      //并行串行队列
      //correntSynchronousQueue()
      
      //wait
      //waitQueue()
      
      //耗时操作执行完，才进行下一步操作
      //notifyQueue()
      
      serialQueue()
    }
  
  func serialSynchronousQueue() {
    let 队列 = DispatchQueue.init(label: "队列的名称")
    
    队列.sync {
      for i in 0..<3 {
        print("\(i)  ")
      }
      print(Thread.current)
    }
    for i in 4..<6 {
      print("\(i)  ")
    }
    print(Thread.current)
  }
  
  func serialAsyncSynchronousQueue() {
    let 队列 = DispatchQueue.init(label: "队列的名称")
    
    队列.async {
      for i in 10..<19 {
        print("\(i)  ")
      }
      print(Thread.current)
    }
    for i in 4..<6 {
      print("\(i)  ")
    }
    print(Thread.current)
    
  }
  
  func correntSynchronousQueue() {
    let 队列 = DispatchQueue.init(label: "队列的名称", attributes: .concurrent)
    
    队列.sync {
      for i in 10..<19 {
        print("\(i)  ")
      }
      print(Thread.current)
    }
    for i in 4..<6 {
      print("\(i)  ")
    }
    print(Thread.current)
  }
  
  func waitQueue() {
    
    let myQueue = DispatchQueue(label: "第一条线程")
    let group = DispatchGroup()
     
    myQueue.async(group: group, qos: .default, flags: []) {
        for _ in 0...10 {
            print("耗时任务一")
        }
    }
     
    myQueue.async(group: group, qos: .default, flags: []) {
        for _ in 0...10 {
            print("耗时任务二")
            sleep(UInt32(3))
        }
    }
    //等待上面任务执行，会阻塞当前线程，超时就执行下面的，上面的继续执行。可以无限等待 .distantFuture
    let result = group.wait(timeout: .now() + 2.0)
    switch result {
    case .success:
        print("不超时, 上面的两个任务都执行完")
    case .timedOut:
        print("超时了, 上面的任务还没执行完执行这了")
    }
  }
  
  func notifyQueue() {
    let myQueue = DispatchQueue(label: "第一条线程")
    let group = DispatchGroup()
    
         myQueue.async(group: group, qos: .default, flags: [], execute: {
             for _ in 0...10 {
      
             print("耗时任务一")
             }
         })
         myQueue.async(group: group, qos: .default, flags: [], execute: {
             for _ in 0...10 {
      
                 print("耗时任务二")
             }
         })
         //执行完上面的两个耗时操作, 回到myQueue队列中执行下一步的任务
         group.notify(queue: myQueue) {
             print("回到该队列中执行")
         }
  }
  
  
    
  func serialQueue() {
    let queue = DispatchQueue(label: "ness")
    let group = DispatchGroup()
    
    print("------- 开始 -------")

    group.enter()
    queue.async {
        sleep(3)
        print("------- 异步 A -------")
        group.leave()
    }


    group.enter()
    queue.sync {
        print("------- 同步 A -------")
        group.leave()
    }
    print("------- 同步 A 结束 -------")


    group.enter()
    queue.sync {
        print("------- 同步 B -------")
        group.leave()
    }
    print("------- 同步 B 结束 -------")


    group.enter()
    queue.async {
        sleep(1)
        print("------- 异步 B -------")
        group.leave()
    }

    print("------- 等待 -------")
    // wait 会阻塞线程
    group.wait()
    print("------- 结束 -------")
    
    
  }
  
  func Parallel() {
    
  }
  


    

}
