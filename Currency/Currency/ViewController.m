//
//  ViewController.m
//  Currency
//
//  Created by 徐冰 on 22/12/2015.
//  Copyright © 2015 Bing. All rights reserved.
//

#import "ViewController.h"
#import "CurrencyRequest/CRCurrencyRequest.h"
#import "CurrencyRequest/CRCurrencyResults.h"

@interface ViewController () <CRCurrencyRequestDelegate>
@property (nonatomic) CRCurrencyRequest *req;

@property (weak, nonatomic) IBOutlet UITextField *inputField;
@property (weak, nonatomic) IBOutlet UIButton *convertButton;
@property (weak, nonatomic) IBOutlet UILabel *currencyA;
@property (weak, nonatomic) IBOutlet UILabel *currencyB;
@property (weak, nonatomic) IBOutlet UILabel *currencyC;

@end

@implementation ViewController
- (IBAction)buttonTapped:(id)sender {
    self.convertButton.enabled = NO;
    
    self.req = [[CRCurrencyRequest alloc] init];
    self.req.delegate = self;
    [self.req start];
}

- (void)currencyRequest:(CRCurrencyRequest *)req
    retrievedCurrencies:(CRCurrencyResults *)currencies {
    self.convertButton.enabled = YES;
    
    double inputValue = [self.inputField.text floatValue];
    double euro = inputValue * currencies.EUR;
    double jpy = inputValue * currencies.JPY;
    double gbp = inputValue * currencies.GBP;
    NSString *euroV = [NSString stringWithFormat:@"%.2f", euro];
    NSString *jpyV = [NSString stringWithFormat:@"%.2f", jpy];
    NSString *gbpV = [NSString stringWithFormat:@"%.2f", gbp];
    self.currencyA.text = euroV;
    self.currencyB.text = jpyV;
    self.currencyC.text =  gbpV;
    //this is a test
}


@end
