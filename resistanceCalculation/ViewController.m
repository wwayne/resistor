//
//  ViewController.m
//  resistanceCalculation
//
//  Created by wayne on 15/6/8.
//  Copyright (c) 2015年 wayne. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UISlider *sliderRound1;
@property (weak, nonatomic) IBOutlet UISlider *sliderRound2;
@property (weak, nonatomic) IBOutlet UISlider *sliderRound3;
@property (weak, nonatomic) IBOutlet UISlider *sliderRound4;
@property (weak, nonatomic) IBOutlet UILabel *labelRound1;
@property (weak, nonatomic) IBOutlet UILabel *labelRound2;
@property (weak, nonatomic) IBOutlet UILabel *labelRound3;
@property (weak, nonatomic) IBOutlet UILabel *labelRound4;
@property (weak, nonatomic) IBOutlet UILabel *omegaLabel;
@property (nonatomic) float roundValue1;
@property (nonatomic) float roundValue2;
@property (nonatomic) float roundValue3;
@property (nonatomic) float roundValue4;
@property (weak, nonatomic) IBOutlet UILabel *dfferLabel;
@property (strong, nonatomic) NSMutableDictionary *colors;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.sliderRound1 addTarget:self action:@selector(changeSlider1:) forControlEvents:UIControlEventValueChanged];
    [self.sliderRound2 addTarget:self action:@selector(changeSlider2:) forControlEvents:UIControlEventValueChanged];
    [self.sliderRound3 addTarget:self action:@selector(changeSlider3:) forControlEvents:UIControlEventValueChanged];
    [self.sliderRound4 addTarget:self action:@selector(changeSlider4:) forControlEvents:UIControlEventValueChanged];
    self.colors = [[NSMutableDictionary alloc]
                   initWithObjects:@[[UIColor blackColor], [UIColor brownColor], [UIColor redColor], [UIColor orangeColor], [UIColor yellowColor], [UIColor greenColor], [UIColor blueColor], [UIColor purpleColor], [UIColor grayColor], [UIColor colorWithRed: 0.0 green:0.0 blue:0.0 alpha:0.1], [UIColor colorWithRed:226.0/255.0 green:226.0/255.0 blue:226.0/255.0 alpha:1.0], [UIColor colorWithRed:226.0/255.0 green:211.0/255.0 blue:77.0/255.0 alpha:1.0], [UIColor colorWithRed: 0.0 green:0.0 blue:0.0 alpha:0.1]]
                   forKeys:@[@"black", @"brown", @"red", @"orange", @"yellow", @"green", @"blue", @"purple", @"grey", @"white", @"silver", @"golden", @"clear"]];
    self.roundValue1 = [self CalcRound1:self.sliderRound1.value];
    self.roundValue2 = [self CalcRound2:self.sliderRound2.value];
    self.roundValue3 = [self CalcRound3:self.sliderRound3.value];
    self.roundValue4 = [self CalcRound4:self.sliderRound4.value];
    [self calculation];
}

-(void)changeSlider1:(id) sender {
    [self showLabel:self.sliderRound1.value target:1];
}
-(void)changeSlider2:(id) sender {
    [self showLabel:self.sliderRound2.value target:2];
}
-(void)changeSlider3:(id) sender {
    [self showLabel:self.sliderRound3.value target:3];
}
-(void)changeSlider4:(id) sender {
    [self showLabel:self.sliderRound4.value target:4];
}

-(void)showLabel:(float) value target:(int)slider{
    switch (slider) {
        case 1:
            self.roundValue1 = [self CalcRound1:value];
            break;
        case 2:
            self.roundValue2 = [self CalcRound2:value];
            break;
        case 3:
            self.roundValue3 = [self CalcRound3:value];
            break;
        case 4:
            self.roundValue4 = [self CalcRound4:value];
            break;
        default:
            break;
    }
    [self calculation];
}

-(float)CalcRound1:(float) value {
    NSArray *map = @[@"black", @"brown", @"red", @"orange", @"yellow", @"green", @"blue", @"purple", @"grey", @"white"];
    float relatedValue = floor(value);
    int index = (int)relatedValue != 10 ? (int)relatedValue : 9;
    self.labelRound1.text = map[index];
    self.labelRound1.textColor = self.colors[map[index]];
    return relatedValue;
}

-(float)CalcRound2:(float) value {
    NSArray *map = @[@"black", @"brown", @"red", @"orange", @"yellow", @"green", @"blue", @"purple", @"grey", @"white"];
    float relatedValue = floor(value);
    int index = (int)relatedValue != 10 ? (int)relatedValue : 9;
    self.labelRound2.text = map[index];
    self.labelRound2.textColor = self.colors[map[index]];
    return relatedValue;
}

-(float)CalcRound3:(float) value {
    NSArray *map = @[@"black", @"brown", @"red", @"orange", @"yellow", @"green", @"blue", @"purple", @"golden", @"silver"];
    NSArray * mapValue = @[@1, @10, @100, @1000, @10000, @100000, @1000000, @10000000, @0.1, @0.01];
    float relatedValue = floor(value);
    int index = (int)relatedValue != 10 ? (int)relatedValue : 9;
    self.labelRound3.text = map[index];
    self.labelRound3.textColor = self.colors[map[index]];
    return [mapValue[index] floatValue];
}

-(float)CalcRound4:(float) value {
    NSArray *map = @[@"brown", @"red", @"green", @"blue", @"purple", @"grey", @"golden", @"silver", @"clear"];
    NSArray *valueMap = @[@1, @2, @0.5, @0.25, @0.1, @0.05, @5, @10, @20];
    float relatedValue = floor(value*0.9);
    int index = (int)relatedValue != 9 ? (int)relatedValue : 8;
    
    self.labelRound4.text = map[index];
    NSNumber *resultValue = valueMap[index];
    
    self.labelRound4.textColor = self.colors[map[index]];
    return [resultValue floatValue];
}

-(void)calculation {
    int result1 = (int)self.roundValue1 * 10 + (int)self.roundValue2;
    float result2 = result1 * self.roundValue3;
    NSString *omiga = [NSString stringWithFormat:@"%.2f ~ %.2f",(float)(result2 - result2*self.roundValue4*0.01), (float)(result2 + result2*self.roundValue4*0.01)];
    self.dfferLabel.text = omiga;
    
    NSString *value = [NSString stringWithFormat:@"%.0f", result2];
    self.omegaLabel.text = value;
}

@end
