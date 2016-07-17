//
//  Tasks.h
//  Downloader
//
//  Created by Geetion on 16/7/17.
//  Copyright © 2016年 Geetion. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Tasks : NSObject
@property(strong,nonatomic) NSMutableArray *list;

+(Tasks*)sharedTasks;
@end
