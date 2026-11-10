#import <UIKit/UIKit.h>

UITextView *scriptInput;
UIView *menuWindow;

@interface MenuController : NSObject
- (void)executeButtonTapped:(UIButton *)sender;
@end

@implementation MenuController
- (void)executeButtonTapped:(UIButton *)sender {
    NSString *userCode = scriptInput.text;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Text Captured!"
                                                                   message:[NSString stringWithFormat:@"You entered:\n%@", userCode]
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okAction];
    
    [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:alert animated:YES completion:nil];
}
@end

%hook UIWindow
- (void)makeKeyAndVisible {
    %orig;
    
    menuWindow = [[UIView alloc] initWithFrame:CGRectMake(20, 100, 340, 280)];
    menuWindow.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.95];
    menuWindow.layer.cornerRadius = 12.0;
    menuWindow.layer.borderWidth = 1.5;
    menuWindow.layer.borderColor = [UIColor grayColor].CGColor;
    
    scriptInput = [[UITextView alloc] initWithFrame:CGRectMake(20, 20, 300, 150)];
    scriptInput.backgroundColor = [UIColor colorWithWhite:0.05 alpha:1.0];
    scriptInput.textColor = [UIColor greenColor];
    scriptInput.font = [UIFont fontWithName:@"Courier" size:14.0];
    scriptInput.layer.cornerRadius = 6.0;
    [menuWindow addSubview:scriptInput];
    
    UIButton *runButton = [UIButton buttonWithType:UIButtonTypeCustom];
    runButton.frame = CGRectMake(20, 190, 300, 44);
    runButton.backgroundColor = [UIColor systemBlueColor];
    [runButton setTitle:@"Process Input" forState:UIControlStateNormal];
    runButton.layer.cornerRadius = 6.0;
    
    MenuController *controller = [[MenuController alloc] init];
    [runButton addTarget:controller action:@selector(executeButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [menuWindow addSubview:runButton];
    
    [self addSubview:menuWindow];
}
%end
