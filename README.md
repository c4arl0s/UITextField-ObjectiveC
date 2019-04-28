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



- when you select a textField, the window moves its firstResponder pointer to that text field.
- Motion and remote controls events are sent to the first responder.



