//
//  AppDelegate.m
//  Downloader
//
//  Created by Geetion on 16/4/7.
//  Copyright © 2016年 Geetion. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    [Tasks sharedTasks] = [[NSUserDefaults standardUserDefaults] setObject:self forKey:@"tasks"]
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
    
}
- (void)applicationDidResignActive:(NSNotification *)notification{
    NSMutableArray *taskList = [Tasks sharedTasks];
    NSLog(@"123");
    for(int i = 0;i<taskList.count;i++){
        DownloadTask *task = taskList[i];
        [task moveDataToDirectory];
    }
    [[NSUserDefaults standardUserDefaults] setObject:self forKey:@"tasks"];
}

@end
