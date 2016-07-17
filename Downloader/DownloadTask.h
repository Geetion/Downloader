//
//  DowloadTask.h
//  Downloader
//
//  Created by Geetion on 16/7/16.
//  Copyright © 2016年 Geetion. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "TableViewCell.h"

@interface DownloadTask : NSObject<NSURLSessionDownloadDelegate,NSOpenSavePanelDelegate>
@property(strong,nonatomic) TableViewCell *cell;

- (instancetype)initWithUrl:(NSString*)downloadUrl cell:(TableViewCell *)cell;
@end
