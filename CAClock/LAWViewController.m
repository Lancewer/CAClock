//
//  LAWViewController.m
//  CAClock
//
//  Created by Lawrence on 7/2/15.
//  Copyright (c) 2015 lancewer. All rights reserved.
//

#import "LAWViewController.h"

@interface LAWViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *hourHand;
@property (weak, nonatomic) IBOutlet UIImageView *minuteHand;
@property (weak, nonatomic) IBOutlet UIImageView *secondHand;
@property (weak, nonatomic) IBOutlet UIImageView *clockFace;
@property (nonatomic, weak) NSTimer *timer;

@end

@implementation LAWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Adjust anchor points
    self.secondHand.layer.anchorPoint = CGPointMake(0.5f, 0.9f);
    self.minuteHand.layer.anchorPoint = CGPointMake(0.5f, 0.9f);
    self.hourHand.layer.anchorPoint = CGPointMake(0.5f, 0.9f);
    UIScreen *mainScreen = [UIScreen mainScreen];
    CGPoint center = CGPointMake(mainScreen.bounds.size.width / 2.0f, mainScreen.bounds.size.height / 2.0f);
    self.secondHand.center = center;
    self.minuteHand.center = center;
    self.hourHand.center = center;
    self.clockFace.center = center;
    
    //Timer
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick) userInfo:nil repeats:YES];
    [self tick];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)tick{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger units = kCFCalendarUnitHour | kCFCalendarUnitMinute | kCFCalendarUnitSecond;
    NSDateComponents *components = [calendar components:units fromDate:[NSDate date]];
    //2pi = 360 degree
    CGFloat hoursAngle = (components.hour / 12.0) * M_PI * 2.0;
    CGFloat minutesAngle = (components.minute / 60.0) * M_PI * 2.0;
    CGFloat secondsAngle = (components.second / 60.0) * M_PI * 2.0;
    
    //rotate hands
    self.hourHand.transform = CGAffineTransformMakeRotation(hoursAngle);
    self.minuteHand.transform = CGAffineTransformMakeRotation(minutesAngle);
    self.secondHand.transform = CGAffineTransformMakeRotation(secondsAngle);
}

@end
