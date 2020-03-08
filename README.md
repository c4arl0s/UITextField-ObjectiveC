# UITextField-ObjectiveC
UITextField-ObjectiveC

1. Delete Main
2. Add a xib view
3. make file`s Owner to ViewController
4. connect the view with file´s owner 
5. in AppDelegate.m #import <ViewController.h>
6. in AppDelegare.m declare an Viewcontroller *viewcontroller;
7. in application didFinishLaunchingWithOptions do the magic 

``` objective-c
self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
self.window.rootViewController = viewController;
[self.window makeKeyAndVisible];
```
# UIResponder

- UIView
- UIViewController
- UIApplication

### The UIWindow has a pointer called firstResponder which indicates who should respond to the other type of events.

![Captura de Pantalla 2019-04-28 a la(s) 12 36 34](https://user-images.githubusercontent.com/24994818/56868016-fc03ae80-69a9-11e9-9796-e0f628cbf9c3.png)

- when you select a textField, the window moves its firstResponder pointer to that text field.
- Motion and remote controls events are sent to the first responder.
- Most views refuse to become first responder; they do not want to steal focus from the currently selected text field or text view.

# Delegation



``` objective-c
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
- (void)settingTextField;
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

@end
```

![Captura de Pantalla 2019-04-28 a la(s) 18 39 07](https://user-images.githubusercontent.com/24994818/56871534-97157c00-69dc-11e9-8963-95453c74594b.png)

# Adding labels to the screen

``` objective-c
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
```

![Captura de Pantalla 2019-04-28 a la(s) 18 30 09](https://user-images.githubusercontent.com/24994818/56871495-f9ba4800-69db-11e9-803a-cf3aed804afe.png)

![Captura de Pantalla 2019-04-28 a la(s) 18 30 13](https://user-images.githubusercontent.com/24994818/56871497-fb840b80-69db-11e9-9c20-9997fd9b6391.png)

# [Using both: UITextFieldDelegate and Targe-Action PatterniGG]()

```objective-c
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
```

![Screen Recording 2020-03-07 at 22 55 34 2020-03-07 22_57_30](https://user-images.githubusercontent.com/24994818/76156923-28f31880-60c7-11ea-83ba-005097f3caaa.gif)

