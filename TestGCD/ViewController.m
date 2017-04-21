//
//  ViewController.m
//  TestGCD
//
//  Created by ShowMe_FanJinxin on 16/8/22.
//  Copyright © 2016年 FanJinxin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
/*
 总结:
 1.同步串行       均未开启新的线程,而且是至上而下执行
 2.同步并行
 3.异步串行       从上而下执行,但是会多开启一条线程
 4.异步并行       不能确保执行顺序
 
 
 
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    [self syscConcurrent];
    [self syncSerial];
    [self ayncSerial];
    [self ayncCurrent];
    self.view.backgroundColor = [UIColor redColor];
}
//同步串行的,没有多开线程,从上而下执行,必须是上个线程执行完后,才能执行下一个线程
- (void)syncSerial {
    dispatch_queue_t queue = dispatch_queue_create("download", DISPATCH_QUEUE_SERIAL);
    NSLog(@"========download1=======");
    //定制任务(多任务)
    dispatch_sync(queue, ^{
        NSLog(@"download1 -- 当前线程%@",[NSThread currentThread]);
    });
    NSLog(@"========download2=======");
    dispatch_sync(queue, ^{
        NSLog(@"download2 -- 当前线程%@",[NSThread currentThread]);
    });
    NSLog(@"========download3=======");
    
    dispatch_sync(queue, ^{
        NSLog(@"download3 -- 当前线程%@",[NSThread currentThread]);
    });
    NSLog(@"========download4=======");
    dispatch_sync(queue, ^{
        NSLog(@"download4 -- 当前线程%@",[NSThread currentThread]);
    });
    NSLog(@"========download5=======");
    dispatch_sync(queue, ^{
        NSLog(@"download5 -- 当前线程%@",[NSThread currentThread]);
    });
    
}
//同步并行行队列,并没有多开线程,按照顺序执行
- (void)syscConcurrent {
    dispatch_queue_t queue = dispatch_queue_create("download", DISPATCH_QUEUE_CONCURRENT);
     NSLog(@"========download1=======");
    //定制任务(多任务)
    dispatch_sync(queue, ^{
        NSLog(@"download1 -- 当前线程%@",[NSThread currentThread]);
    });
     NSLog(@"========download2=======");
    dispatch_sync(queue, ^{
        NSLog(@"download2 -- 当前线程%@",[NSThread currentThread]);
    });
     NSLog(@"========download3=======");
    dispatch_sync(queue, ^{
        NSLog(@"download3 -- 当前线程%@",[NSThread currentThread]);
    });
     NSLog(@"========download4=======");
    dispatch_sync(queue, ^{
        NSLog(@"download4 -- 当前线程%@",[NSThread currentThread]);
    });
     NSLog(@"========download5=======");
    dispatch_sync(queue, ^{
        NSLog(@"download5 -- 当前线程%@",[NSThread currentThread]);
    });
}
//异步串行队列,会多开线程,但是从上到下执行,保证的顺序是从上到下的,只开启一条线程
- (void)ayncSerial {
    dispatch_queue_t queue = dispatch_queue_create("download", DISPATCH_QUEUE_SERIAL);
    //定制任务(多任务)
    NSLog(@"========download1=======");
    NSLog(@"========download2=======");
    NSLog(@"========download3=======");
    NSLog(@"========download4=======");
    NSLog(@"========download5=======");


    dispatch_async(queue, ^{
        NSLog(@"download1 -- 当前线程%@",[NSThread currentThread]);
    });
        dispatch_async(queue, ^{
        NSLog(@"download2 -- 当前线程%@",[NSThread currentThread]);
    });
    NSLog(@"========download3=======");
    dispatch_async(queue, ^{
        NSLog(@"download3 -- 当前线程%@",[NSThread currentThread]);
    });
     NSLog(@"========download4=======");
    dispatch_async(queue, ^{
        NSLog(@"download4 -- 当前线程%@",[NSThread currentThread]);
    });
     NSLog(@"========download5=======");
    dispatch_async(queue, ^{
        NSLog(@"download5 -- 当前线程%@",[NSThread currentThread]);
    });
}
- (void)ayncCurrent {
    dispatch_queue_t queue = dispatch_queue_create("download", DISPATCH_QUEUE_CONCURRENT);
    //定制任务(多任务)
    NSLog(@"========download1=======");
    dispatch_async(queue, ^{
        NSLog(@"download1 -- 当前线程%@",[NSThread currentThread]);
    });
    NSLog(@"========download2=======");
    dispatch_async(queue, ^{
        NSLog(@"download2 -- 当前线程%@",[NSThread currentThread]);
    });
    NSLog(@"========download3=======");
    dispatch_async(queue, ^{
        NSLog(@"download3 -- 当前线程%@",[NSThread currentThread]);
    });
    NSLog(@"========download4=======");
    dispatch_async(queue, ^{
        NSLog(@"download4 -- 当前线程%@",[NSThread currentThread]);
    });
    NSLog(@"========download5=======");
    dispatch_async(queue, ^{
        NSLog(@"download5 -- 当前线程%@",[NSThread currentThread]);
    });
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
