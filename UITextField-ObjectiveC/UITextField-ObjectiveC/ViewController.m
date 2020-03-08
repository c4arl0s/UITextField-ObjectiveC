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
{
    UITextField *textField;
}
@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTextField];
}

- (void)setTextField
{
    CGRect textFieldCenteredRect = [self setCenteredTextFieldWithWidth:300 textFieldHeight:30];
    textField = [[UITextField alloc] initWithFrame: textFieldCenteredRect];
    
    // Setting the borderStyle on the text field will allow us to see it more easely.
    [self setTextFieldBorder:UITextBorderStyleRoundedRect placeHolder:@"write something" returnKeyType:UIReturnKeyDone autocapitalizationType:UITextAutocapitalizationTypeWords];
    
    // set delegate
    textField.delegate = self;
    
    // target-action pattern
    [textField addTarget:self action: @selector(keyboardReturnKey) forControlEvents:UIControlEventPrimaryActionTriggered];
    [textField addTarget:self action: @selector(textChanged) forControlEvents:UIControlEventEditingChanged];
    
    // add the textfield to the view hierarchy
    [self.view addSubview:textField];
}

// MARK: UITextField Delegate methods

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
        UILabel *messageLabel = [self createLabelWithMessage:message];
        [self.view addSubview:messageLabel];
    }
}

- (UILabel *)createLabelWithMessage:(NSString *)message
{
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
    return messageLabel;
}

// MARK: selectors

- (void)keyboardReturnKey
{
    NSLog(@"return key pressed");
    if ([textField.text isEqualToString:@""])
    {
        NSLog(@"You didn't tapped anything, type something");
    }
    else
    {
        NSLog(@"You pressed enter and typed: %@", textField.text);
    }
}

-(void)textChanged
{
    NSLog(@"text changed");
    NSLog(@"you typed: %@", textField.text);
}

-(CGRect)setCenteredTextFieldWithWidth:(CGFloat)widthTextField textFieldHeight:(CGFloat)heightTextField
{
    CGFloat abscissaCenteredTextField = self.view.frame.size.width/2 - widthTextField/2;
    CGFloat ordinateCenteredTextField = self.view.frame.size.height/2 - heightTextField/2;
    CGRect textFieldRect = CGRectMake(abscissaCenteredTextField,
                                      ordinateCenteredTextField,
                                      widthTextField,
                                      heightTextField);
    return textFieldRect;
}

-(void)setTextFieldBorder:(UITextBorderStyle)textBorderStyle placeHolder:(NSString *)placeHolder returnKeyType:(UIReturnKeyType)returnKeyType autocapitalizationType:(UITextAutocapitalizationType)autocapitalizationType
{
    textField.borderStyle = textBorderStyle;//UITextBorderStyleRoundedRect;
    textField.placeholder = placeHolder;//@"Write something";
    textField.returnKeyType = returnKeyType;//UIReturnKeyDone;
    textField.autocapitalizationType = autocapitalizationType;//UITextAutocapitalizationTypeWords;
}

@end
