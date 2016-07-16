//
//  DowloadTask.h
//  Downloader
//
//  Created by Geetion on 16/7/16.
//  Copyright © 2016年 Geetion. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface DownloadTask : NSObject<NSURLSessionDownloadDelegate,NSOpenSavePanelDelegate>
- (instancetype)initWithUrl:(NSString*)downloadUrl;
@end
