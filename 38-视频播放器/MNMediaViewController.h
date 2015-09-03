//
//  MNMediaViewController.h
//  38-视频播放器
//
//  Created by Mac on 14-11-2.
//  Copyright (c) 2014年 MN. All rights reserved.
//

//可以从苹果官⽹网:http://support.apple.com/kb/HT1425下载⼀一些⽤用来测试的视频⽂文件,⽂件都⽐比较⼩小

//视频编码解码的第三方框架  VLC  // http://github.com/videolan.vlc  下载超过10亿次

#import <UIKit/UIKit.h>

@protocol MNMediaViewControllerDelegate
@optional
-(void)movieDidFinished;
-(void)movieDidCaptureFinished:(UIImage*)image;
@end


@interface MNMediaViewController : UIViewController
@property(nonatomic,weak) id <MNMediaViewControllerDelegate>delegate;
@property(nonatomic,strong) NSURL *url;
@end
