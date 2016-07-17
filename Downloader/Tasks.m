//
//  Tasks.m
//  Downloader
//
//  Created by Geetion on 16/7/17.
//  Copyright © 2016年 Geetion. All rights reserved.
//

#import "Tasks.h"

@implementation Tasks

- (id)init
{
    if (self) {
        self.list = [[NSMutableArray alloc] init];
    }
    return self;
}

+(Tasks*)sharedTasks{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}
@end
