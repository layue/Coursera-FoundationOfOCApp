//
//  ViewController.m
//  PeerReview4
//
//  Created by 徐冰 on 05/02/2016.
//  Copyright © 2016 Bing. All rights reserved.
//

#import "ViewController.h"
#import "DistanceGetter/DGDistanceRequest.h"

@interface ViewController ()

@property (nonatomic) DGDistanceRequest *req;

@property (weak, nonatomic) IBOutlet UITextField *startLocation;

@property (weak, nonatomic) IBOutlet UITextField *endLocationA;
@property (weak, nonatomic) IBOutlet UITextField *endLocationB;
@property (weak, nonatomic) IBOutlet UITextField *endLocationC;
@property (weak, nonatomic) IBOutlet UITextField *endLocationD;

@property (weak, nonatomic) IBOutlet UILabel *distanceA;
@property (weak, nonatomic) IBOutlet UILabel *distanceB;
@property (weak, nonatomic) IBOutlet UILabel *distanceC;
@property (weak, nonatomic) IBOutlet UILabel *distanceD;


@property (weak, nonatomic) IBOutlet UISegmentedControl *unitSelection;
@property (weak, nonatomic) IBOutlet UIButton *calculateButton;

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

- (IBAction)calculateButtonTapped:(id)sender {
    self.calculateButton.enabled = NO;
    
    self.req = [DGDistanceRequest alloc];
    
    NSString *start = self.startLocation.text;
    NSString *destA = self.endLocationA.text;
    NSString *destB = self.endLocationB.text;
    NSString *destC = self.endLocationC.text;
    NSString *destD = self.endLocationD.text;
    
    NSArray *dests = @[destA, destB, destC, destD];
    
    self.req = [self.req initWithLocationDescriptions:dests sourceDescription:start];
    
    __weak ViewController *weakSelf = self;
    
    self.req.callback = ^void(NSArray *responses){
        ViewController *strongSelf = weakSelf;
        if (!strongSelf)  return;
        
        NSNull *badResult = [NSNull null];
        
        if (strongSelf.unitSelection.selectedSegmentIndex == 0) {
            if (responses[0] != badResult) {
                double num = [responses[0] floatValue] / 1.0;
                NSString *x = [NSString stringWithFormat:@"%0.2f m", num];
                strongSelf.distanceA.text = x;
            }
            else {
                strongSelf.distanceA.text = @"Error";
            }
            
            if (responses[1] != badResult) {
                double num = [responses[1] floatValue] / 1.0;
                NSString *x = [NSString stringWithFormat:@"%0.2f m", num];
                strongSelf.distanceB.text = x;
            }
            else {
                strongSelf.distanceB.text = @"Error";
            }
            
            if (responses[2] != badResult) {
                double num = [responses[2] floatValue] / 1.0;
                NSString *x = [NSString stringWithFormat:@"%0.2f m", num];
                strongSelf.distanceC.text = x;
            }
            else {
                strongSelf.distanceC.text = @"Error";
            }
            
            if (responses[3] != badResult) {
                double num = [responses[3] floatValue] / 1.0;
                NSString *x =[NSString stringWithFormat:@"%0.2f m", num];
                strongSelf.distanceD.text = x;
            }
            else {
                strongSelf.distanceD.text = @"Error";
            }
        } else if(strongSelf.unitSelection.selectedSegmentIndex == 1){
            if (responses[0] != badResult) {
                double num = [responses[0] floatValue] / 1000.0;
                NSString *x = [NSString stringWithFormat:@"%0.2f km", num];
                strongSelf.distanceA.text = x;
            }
            else {
                strongSelf.distanceA.text = @"Error";
            }
            
            if (responses[1] != badResult) {
                double num = [responses[1] floatValue] / 1000.0;
                NSString *x = [NSString stringWithFormat:@"%0.2f km", num];
                strongSelf.distanceB.text = x;
            }
            else {
                strongSelf.distanceB.text = @"Error";
            }
            
            if (responses[2] != badResult) {
                double num = [responses[2] floatValue] / 1000.0;
                NSString *x = [NSString stringWithFormat:@"%0.2f km", num];
                strongSelf.distanceC.text = x;
            }
            else {
                strongSelf.distanceC.text = @"Error";
            }
            
            if (responses[3]) {
                double num = [responses[3] floatValue] / 1000.0;
                NSString *x = [NSString stringWithFormat:@"%0.2f km", num];
                strongSelf.distanceD.text = x;
            } else {
                strongSelf.distanceD.text = @"Error";
            }
        } else {
            if (responses[0] != badResult) {
                double num = [responses[0] floatValue] * 0.000621;
                NSString *x = [NSString stringWithFormat:@"%0.2f mile", num];
                strongSelf.distanceA.text = x;
            }
            else {
                strongSelf.distanceA.text = @"Error";
            }
            
            if (responses[1] != badResult) {
                double num = [responses[1] floatValue] * 0.000621;
                NSString *x = [NSString stringWithFormat:@"%0.2f mile", num];
                strongSelf.distanceB.text = x;
            }
            else {
                strongSelf.distanceB.text = @"Error";
            }
            
            if (responses[2] != badResult) {
                double num = [responses[2] floatValue] * 0.000621;
                NSString *x = [NSString stringWithFormat:@"%0.2f mile", num];
                strongSelf.distanceC.text = x;
            }
            else {
                strongSelf.distanceC.text = @"Error";
            }
            
            if (responses[3] != badResult) {
                double num = [responses[3] floatValue] * 0.000621;
                NSString *x = [NSString stringWithFormat:@"%0.2f mile", num];
                strongSelf.distanceD.text = x;
            } else {
                strongSelf.distanceD.text = @"Error";
            }
        }
        
        strongSelf.req = nil;
        strongSelf.calculateButton.enabled = YES ;
    };
    
    [self.req start];
    
}

@end
