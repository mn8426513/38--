//
//  ViewController.m
//  38-视频播放器
//
//  Created by Mac on 14-11-2.
//  Copyright (c) 2014年 MN. All rights reserved.
//

#import "ViewController.h"
#import "MNMediaViewController.h"

@interface ViewController ()<MNMediaViewControllerDelegate>


@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
   
        MNMediaViewController *mvc = segue.destinationViewController;
        mvc.delegate =self;
        mvc.url = [[NSBundle mainBundle] URLForResource:@"西游降魔篇黄渤教舒淇跳舞搞笑片段" withExtension:@"mp4"];
 
}
-(void)movieDidFinished
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
  
}

-(void)movieDidCaptureFinished:(UIImage *)image
{
    
    for ( int i = 0;i<1;i++){
        if(i==0){
           self.capture1.image = image;
        }
        self.capture2.image =image;
    }
}

@end
