//
//  ViewController.m
//  Downloader
//
//  Created by Geetion on 16/4/7.
//  Copyright © 2016年 Geetion. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController{
    NSString *mdownloadUrl;
}

-(void)loadView{
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSNib *nib = [[NSNib alloc]initWithNibNamed:@"TableViewCell" bundle:nil];
    [self.tableView registerNib:nib forIdentifier:@"customCell"];
    self.tableView.rowHeight = 50;
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
    
    // Update the view, if already loaded.
}

- (IBAction)onDownloadButtonClick:(NSButton *)sender {
    mdownloadUrl = [self.urlTextField stringValue];
    if(mdownloadUrl.length != 0){
        
        TableViewCell *cell = [self.tableView makeViewWithIdentifier:@"customCell" owner:self];
        DownloadTask *task = [[DownloadTask alloc] initWithUrl:mdownloadUrl cell:cell];
        [[Tasks sharedTasks] addObject:task];
        [self.tableView reloadData];
    }
}

- (IBAction)onPauseButtonClick:(NSButton *)sender {
    NSMutableArray *tasklist = [Tasks sharedTasks];
    DownloadTask *downloadTask = tasklist[self.tableView.selectedRow];
    [downloadTask pauseTask];
}
#pragma NSTableView delegate&datasource
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    NSMutableArray *list = [Tasks sharedTasks];
    return list.count;
}

- (nullable NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(nullable NSTableColumn *)tableColumn row:(NSInteger)row{
    NSMutableArray *list = [Tasks sharedTasks];
    DownloadTask *task = list[row];
    
    return task.cell;
}


@end
