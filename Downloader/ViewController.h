//
//  ViewController.h
//  Downloader
//
//  Created by Geetion on 16/4/7.
//  Copyright © 2016年 Geetion. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController<NSURLSessionDownloadDelegate,NSOpenSavePanelDelegate>
@property(nonatomic,copy)NSString* mUrl;
@property (weak) IBOutlet NSTextField *urlTextField;
@property (weak) IBOutlet NSTextField *fileSizeLable;
@property (weak) IBOutlet NSProgressIndicator *downloadProgress;
@property (weak) IBOutlet NSTextField *currentSpead;
@property (weak) IBOutlet NSTextField *remainData;
//@property(atomic,weak);

@end

