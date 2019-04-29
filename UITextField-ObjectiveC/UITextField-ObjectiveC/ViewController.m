//
//  ViewController.m
//  UITextField-ObjectiveC
//
//  Created by Carlos Santiago Cruz on 4/28/19.
//  Copyright © 2019 Carlos Santiago Cruz. All rights reserved.
//

#import "ViewController.h"

// the reason for adding it to the class extension rather than the header file is the same reason
// as always: add to the class extension if the information (conforming to a particular protocol in this case)
// does not need to be publicly visible, and add it to the header file if other objects do need to know
// about the information.

@interface ViewController () <UITextFieldDelegate>
@end

@implementation ViewController
{
    UITextField *textField;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self settingTextField];
}

- (void)settingTextField
{
    CGFloat widthTextField = 300;
    CGFloat heightTextField = 100;
    CGFloat abscissaCenteredTextField = self.view.frame.size.width/2 - widthTextField/2;
    CGFloat ordinateCenteredTextField = self.view.frame.size.height/2 - heightTextField/2;
    CGRect textFieldRect = CGRectMake(abscissaCenteredTextField,
                                      ordinateCenteredTextField,
                                      widthTextField,
                                      heightTextField);
    textField = [[UITextField alloc] initWithFrame:textFieldRect];
    // Setting the borderStyle on the text field will allow us to see it more easely.
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.placeholder = @"Write something";
    textField.returnKeyType = UIReturnKeyDone;
    textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    textField.delegate = self;
    [self.view addSubview:textField];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField.text isEqualToString:@""]) {
        NSLog(@"You didn't tapped anything, type something");
    } else {
        NSLog(@"you pressed enter and you typed this: %@", textField.text);
        [self drawHypnoticMessage:textField.text];
        [textField resignFirstResponder];
    }
    return YES;
}
- (void)clearButtonTapped
{
    // textFieldShouldClear: is an optional method.
    // so we check first
    SEL clearSelector = @selector(textFieldShouldClear:);
    if ([textField.delegate respondsToSelector:clearSelector]) {
        if ([textField.delegate textFieldShouldClear:textField]) {
            textField.text = @"I don`t know what it does";
        }
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"You tapped the first time into text field");
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"This method is called after the text field resigns its first responder status. ");
    NSLog(@" You can use this method to update your delegate’s state information. For example, you might use this method to hide overlay views that should be visible only while editing");
}

- (void)drawHypnoticMessage:(NSString *)message
{
    for (int i=0; i<20; i++) {
        UILabel *messageLabel = [[UILabel alloc] init];
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.textColor = [UIColor blackColor];
        messageLabel.text = message;
        [messageLabel sizeToFit];
        int width = self.view.bounds.size.width - messageLabel.bounds.size.width;
        int x = arc4random() % width;
        int height = self.view.bounds.size.height - messageLabel.bounds.size.height;
        int y = arc4random() % height;
        
        CGRect frame = messageLabel.frame;
        frame.origin = CGPointMake(x, y);
        messageLabel.frame = frame;
        
        [self.view addSubview:messageLabel];
    }
}
@end
