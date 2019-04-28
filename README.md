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


