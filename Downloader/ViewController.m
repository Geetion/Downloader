//
//  ViewController.m
//  Downloader
//
//  Created by Geetion on 16/4/7.
//  Copyright © 2016年 Geetion. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController{

}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
    
    // Update the view, if already loaded.
}

- (IBAction)onDownloadButtonClick:(NSButton *)sender {
//    mdownloadUrl = [self.urlTextField stringValue];
//    if(mdownloadUrl.length != 0)
}

- (IBAction)onPauseButtonClick:(NSButton *)sender {
    DownloadTask* downloadTask = [[DownloadTask alloc] initWithUrl:self.urlTextField.stringValue];
    
//    if(isDownloading){
//        
//        [task cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
//            tempData = resumeData;
//        }];
//        NSLog(@"PAUSE");
//    }else{
//        task = [session downloadTaskWithResumeData:tempData];
//        [task resume];
//
//    }
    
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    return 3;
}
- (nullable id)tableView:(NSTableView *)tableView objectValueForTableColumn:(nullable NSTableColumn *)tableColumn row:(NSInteger)row{
    return [NSString stringWithFormat:@"%ld", row];
}

@end
