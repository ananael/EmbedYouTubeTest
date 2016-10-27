//
//  ViewController.m
//  EmbedYouTubeTest
//
//  Created by Michael Hoffman on 10/21/16.
//  Copyright © 2016 Strong Atomic. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@interface ViewController ()

@property (strong, nonatomic) IBOutlet YTPlayerView *playerView;
@property NSInteger indexValue;
@property (weak, nonatomic) IBOutlet UIButton *playVideo;
@property (weak, nonatomic) IBOutlet UIButton *stopVideo;
@property (weak, nonatomic) IBOutlet UIButton *pauseVideo;
@property (weak, nonatomic) IBOutlet UIButton *nextVideo;
@property (weak, nonatomic) IBOutlet UIButton *previousVideo;

- (IBAction)playTapped:(id)sender;
- (IBAction)stopTapped:(id)sender;
- (IBAction)pauseTapped:(id)sender;
- (IBAction)nextTapped:(id)sender;
- (IBAction)previousTapped:(id)sender;


@property AVPlayerViewController *videoPlayerController;
@property AVPlayerItem *playerItem;
@property AVAsset *vidAsset;
@property AVPlayer *player;
@property AVPlayerLayer *frameLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.playerView.delegate = self;
    [self buttonFormat:[self buttonArray] borderColor:[UIColor blackColor] borderWidth:1];
    [self videoFrameFormat:self.playerView borderColor:[UIColor blackColor] borderWidth:3];
    
    self.indexValue = 0;
    
    NSDictionary *playerVars = @{
                                 @"playsinline" : @1,
                                 };
    [self.playerView loadWithVideoId:[[self videoArray]objectAtIndex:self.indexValue] playerVars:playerVars];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)buttonFormat:(NSArray *)array borderColor:(UIColor *)color borderWidth:(NSInteger)number
{
    for (UIButton *button in [self buttonArray])
    {
        button.layer.borderColor = color.CGColor;
        button.layer.borderWidth = number;
    }
}

-(void)videoFrameFormat:(UIView *)view borderColor:(UIColor *)color borderWidth:(NSInteger)number
{
    view.layer.borderColor = color.CGColor;
    view.layer.borderWidth = number;
}

-(NSArray *)buttonArray
{
    NSArray *buttons = @[self.playVideo, self.pauseVideo, self.stopVideo, self.previousVideo, self.nextVideo];
    return buttons;
}

-(NSArray *)videoArray
{
    NSString *loganTrailer = @"ny3hScFgCIQ";
    NSString *erbJacksonPresley = @"0M0RbaPxq2k";
    NSString *collegeHumorTrumps = @"EBlJYtgVQMs";
    NSString *hisheSuicideSquad = @"Wje0SdFWrzU";
    
    NSArray *videos = @[loganTrailer ,erbJacksonPresley, collegeHumorTrumps, hisheSuicideSquad];
    return videos;
}

- (void)playerView:(YTPlayerView *)playerView didChangeToState:(YTPlayerState)state {
    switch (state) {
            case kYTPlayerStatePlaying:
            NSLog(@"Started playback");
            break;
            case kYTPlayerStatePaused:
            NSLog(@"Paused playback");
            break;
        default:
            break;
    }
}

-(void)nextSelect
{
    if (self.indexValue > [[self videoArray]count]-1)
    {
        self.indexValue = [[self videoArray]count]-1;
    } else
    {
        self.indexValue++;
    }
}

-(void)previousSelect
{
    if (self.indexValue < 0)
    {
        self.indexValue = 0;
    } else
    {
        self.indexValue--;
    }
}

- (IBAction)playTapped:(id)sender
{
    [self.playerView playVideo];
}

- (IBAction)stopTapped:(id)sender
{
    [self.playerView stopVideo];
}

- (IBAction)pauseTapped:(id)sender
{
    [self.playerView pauseVideo];
}

- (IBAction)nextTapped:(id)sender
{
    [self nextSelect];
    
    [self.playerView stopVideo];
    
    [self.playerView cuePlaylistByVideos:[self videoArray]
                                   index:self.indexValue+0.0
                            startSeconds:0.01
                        suggestedQuality:kYTPlaybackQualityAuto];
    
}

- (IBAction)previousTapped:(id)sender
{
    [self previousSelect];
    
    [self.playerView stopVideo];
    
    [self.playerView cuePlaylistByVideos:[self videoArray]
                                   index:self.indexValue+0.0
                            startSeconds:0.01
                        suggestedQuality:kYTPlaybackQualityAuto];
}










@end
