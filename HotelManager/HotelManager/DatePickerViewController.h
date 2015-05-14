//
//  DatePickerViewController.h
//  HotelManager
//
//  Created by Ed Abrahamsen on 5/7/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DatePickerViewController : UIViewController

@property (strong,nonatomic) UIDatePicker *datePicker;
@property (strong,nonatomic) UILabel *instructionsLabel;
@property (strong,nonatomic) UIButton *nextButton;
@end
