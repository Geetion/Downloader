//
//  DowloadTask.m
//  Downloader
//
//  Created by Geetion on 16/7/16.
//  Copyright © 2016年 Geetion. All rights reserved.
//

#import "DownloadTask.h"

@implementation DownloadTask{
    NSString *msavePath;
    NSString *mdownloadUrl;
    NSString *mfileName;
    BOOL isDownloading;
    NSData *tempData;
    NSURLSession *session;
    NSURLSessionDownloadTask *task;
    NSString *mfileSizeText;
    NSFileManager *manager;
}

- (instancetype)initWithUrl:(NSString*)downloadUrl cell:(TableViewCell *)cell
{
    self = [super init];
    if (self) {
        mdownloadUrl = downloadUrl;
        isDownloading = false;
        self.cell = cell;
        [self selectSavePath];
        manager= [NSFileManager defaultManager];
    }
    return self;
}

-(void)moveDataToDirectory{
    [task cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
        tempData = resumeData;
    }];
    NSString *tmpDataPath = [NSString stringWithFormat:@"%@%@%@%@",msavePath,@"/",mfileName,@".tmp"];
    [manager createFileAtPath:tmpDataPath contents:tempData attributes:NULL];
}

-(void)pauseTask{
    if(isDownloading){
        [task cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
            tempData = resumeData;
        }];

    }else{
        task = [session downloadTaskWithResumeData:tempData];
        [task resume];
        
    }
    isDownloading = !isDownloading;
}

-(void)selectSavePath{
    NSSavePanel *savePanel = [NSSavePanel savePanel];
    [savePanel setPrompt: @"打开"];
    [self DownloadRequest];
    [savePanel beginSheetModalForWindow:[NSApp mainWindow] completionHandler:^(NSInteger result) {
        if (result == NSFileHandlingPanelOKButton){
            msavePath = savePanel.directoryURL.path;
            mfileName = savePanel.nameFieldStringValue;
            [task resume];
        }
    }];
}


-(void)DownloadRequest{
    
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:nil];
    
    NSURL *nsurl = [[NSURL alloc]initWithString:mdownloadUrl];
    
    task =  [session downloadTaskWithURL:nsurl];
    
    [task resume];
    
    isDownloading = true;
}

-(void)setInterfaceInfo:(NSString *)currentSpead remainText:(NSString *)remainText
       downloadProgress:(double)downloadProgress{
    self.cell.downloadSpeed.stringValue = currentSpead;
    //mcell.remainData.stringValue = remainText;
    self.cell.taskName.stringValue = mfileName;
    [self.cell.downloadProgress setDoubleValue:downloadProgress];
}

#pragma NSURLSessionDownload Delegate
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location{
    
    NSString *file = [NSString stringWithFormat:@"%@%@%@",msavePath,@"/",mfileName];
    
    
    BOOL fileIsExists = [manager fileExistsAtPath:file];

    BOOL success = [manager moveItemAtPath:location.path toPath:file error:nil];
    //    if(success){
    //
    //    }else{
    //    }
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite;{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    //    计算文件大小
        Float32 fileSize = task.response.expectedContentLength/1024.0/1024.0;
        mfileSizeText = [NSString stringWithFormat:@"%.2f%@",fileSize,@"M"];
        
        mfileName = downloadTask.response.suggestedFilename;
    });
    
    
    //    计算当前进度
    double currentDownloadProgress = totalBytesWritten/(double)totalBytesExpectedToWrite*100;
    
    //    计算当前下载速度
    NSString *currentSpeadText = [NSString stringWithFormat:@"%lld",bytesWritten/1024];
    currentSpeadText = [currentSpeadText stringByAppendingString:@"k/s"];
    
    //    计算文件剩余大小
    NSString *bytesWrittenText = [NSString stringWithFormat:@"%.2f",totalBytesWritten/1024.0/1024.0];
    NSString *remainText = [NSString stringWithFormat:@"%@%@%@",bytesWrittenText,@"M/",
                            mfileSizeText];
    //    更新界面信息
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.cell.downloadProgress setDoubleValue:currentDownloadProgress];
        [self setInterfaceInfo:currentSpeadText remainText:remainText
              downloadProgress:currentDownloadProgress];
    });
}
@end
