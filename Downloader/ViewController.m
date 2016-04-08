//
//  ViewController.m
//  Downloader
//
//  Created by Geetion on 16/4/7.
//  Copyright © 2016年 Geetion. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    isDownloading = false;
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
    
    // Update the view, if already loaded.
}

- (IBAction)onDownloadButtonClick:(NSButton *)sender {
    self.mUrl = [self.urlTextField stringValue];
    [self DownloadRequest:self.mUrl];
}

- (IBAction)onPauseButtonClick:(NSButton *)sender {
    
    if(isDownloading){
        
        [task cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
            tempData = resumeData;
        }];
        NSLog(@"PAUSE");
        isDownloading = false;
    }else{
        task = [session downloadTaskWithResumeData:tempData];
        [task resume];
        isDownloading = true;
        NSLog(@"START");
    }
    
}

-(void)DownloadRequest:(NSString*)url{
    
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:nil];
    
    NSURL *nsurl = [[NSURL alloc]initWithString:url];

    task =  [session downloadTaskWithURL:nsurl];
    
    isDownloading = true;
    
    [task resume];
    
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location{
    
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    
    NSString *file = [NSString stringWithFormat:@"%@%@%@",documentPath,@"/",mfileName];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    BOOL fileIsExists = [manager fileExistsAtPath:file];
    if (fileIsExists) {
    }
    BOOL success = [manager copyItemAtPath:location.path toPath:file error:nil];
    if(success){
        
    }else{
    }
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite;{
    
    //    计算文件大小
    Float32 fileSize = task.response.expectedContentLength/1024.0/1024.0;
    NSString *filsizeText = [NSString stringWithFormat:@"%.2f%@",fileSize,@"M"];
    
//    计算当前进度
    double currentDownloadProgress = totalBytesWritten/(double)totalBytesExpectedToWrite*100;
    
//    计算当前下载速度
    NSString *currentSpeadText = [NSString stringWithFormat:@"%lld",bytesWritten];
    currentSpeadText = [currentSpeadText stringByAppendingString:@"k/s"];
    
//    计算文件剩余大小
    NSString *bytesWrittenText = [NSString stringWithFormat:@"%.2f",totalBytesWritten/1024.0/1024.0];
    NSString *remainText = [NSString stringWithFormat:@"%@%@%@",bytesWrittenText,@"M/",
                            filsizeText];
    
//    更新界面信息
    dispatch_async(dispatch_get_main_queue(), ^{
        self.currentSpead.stringValue = currentSpeadText;
        self.remainData.stringValue = remainText;
        [self.downloadProgress setDoubleValue:currentDownloadProgress];
    });
}
@end
