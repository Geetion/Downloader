//
//  ViewController.h
//  Downloader
//
//  Created by Geetion on 16/4/7.
//  Copyright © 2016年 Geetion. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DownloadTask.h"
#import "TableViewCell.h"
#import "Tasks.h"

@interface ViewController : NSViewController<NSTableViewDataSource,NSTableViewDelegate>
@property(nonatomic,copy)NSString* mUrl;
@property (weak) IBOutlet NSTextField *urlTextField;
@property (weak) IBOutlet NSTableView *tableView;

@end

