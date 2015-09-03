//
//  MNMediaViewController.m
//  38-视频播放器
//
//  Created by Mac on 14-11-2.
//  Copyright (c) 2014年 MN. All rights reserved.
//

#import "MNMediaViewController.h"
#import  <MediaPlayer/MediaPlayer.h>

@interface MNMediaViewController ()

@property(nonatomic,strong) MPMoviePlayerController *moviePlay;

@end

@implementation MNMediaViewController



-(MPMoviePlayerController *)moviePlay
{
    if (_moviePlay==nil) {
        
        //  负责实现播放器的控制器
        
        _moviePlay = [[MPMoviePlayerController alloc]  initWithContentURL:self.url];
        _moviePlay.view.frame = self.view.bounds;
        _moviePlay.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:_moviePlay.view];
    }

    return _moviePlay;

}

- (void)viewDidLoad

{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.moviePlay play];
    // 返回上级的思路：代理，通知 （KVO是什么？)
    
    [self addNotification];
    
}

-(void)viewDidAppear:(BOOL)animated
{

    [self.moviePlay setFullscreen:YES animated:YES];

}


-(void)addNotification
{
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    [nc addObserver:self selector:@selector(stateChange) name:MPMoviePlayerPlaybackStateDidChangeNotification object:nil];
    
    [nc addObserver:self selector:@selector(finish) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    [nc addObserver:self selector:@selector(finish) name:MPMoviePlayerDidExitFullscreenNotification object:nil];
    
    //   MPMovieTimeOptionNearestKeyFrame   大概是那个时间
    //   MPMovieTimeOptionExact  精确的那个时间
    [nc addObserver:self selector:@selector(capture:) name:MPMoviePlayerThumbnailImageRequestDidFinishNotification  object:nil];
    
    [self.moviePlay requestThumbnailImagesAtTimes:@[@(5.0),@(10.0)] timeOption:  MPMovieTimeOptionExact];
}


//MPMoviePlaybackStateStopped,
//MPMoviePlaybackStatePlaying,
//MPMoviePlaybackStatePaused,
//MPMoviePlaybackStateInterrupted,
//MPMoviePlaybackStateSeekingForward,
//MPMoviePlaybackStateSeekingBackward  前

- (void)stateChange
{
    switch (self.moviePlay.playbackState) {
        case MPMoviePlaybackStatePlaying:
            
            break;
            
        case MPMoviePlaybackStatePaused:
            
            break;
        case MPMoviePlaybackStateInterrupted:
            
            break;
            
        case MPMoviePlaybackStateSeekingForward:
            
            break;
        case MPMoviePlaybackStateStopped:
            // [self.moviePlay stop]; called 或者 前进后退无视频的时候 被调用
            
            break;
        
        default:
            
            break;
    }
}


- (void)finish{
    // 通过通知中心添加了监听者 结束的话时候就要删除监听者
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    //返回上级控制器：谁申请谁释放 （OC ,  C 的原则）
    [self.delegate movieDidFinished];
    
}


- (void)capture:(NSNotification *) notice
{
    
    NSLog(@"%@",notice);
    
    [self.delegate movieDidCaptureFinished:notice.userInfo[@"MPMoviePlayerThumbnailImageKey"]];

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
