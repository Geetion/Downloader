//
//  TableViewCell.h
//  Downloader
//
//  Created by Geetion on 16/7/17.
//  Copyright © 2016年 Geetion. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface TableViewCell : NSTableCellView
@property (weak) IBOutlet NSTextField *taskName;
@property (weak) IBOutlet NSProgressIndicator *downloadProgress;
@property (weak) IBOutlet NSTextField *downloadSpeed;

@end
