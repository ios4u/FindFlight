//
//  UIViewController+AlertView.m
//  Helpers
//
//  Created by spens on 08/10/15.
//  Copyright © 2015 ru.spens. All rights reserved.
//

#import "UIViewController+AlertView.h"

@implementation UIViewController (AlertView)

- (void)showAlertwithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelButtonTitle otherButtonsTitles:(NSArray *)otherButtonsTitles animated:(BOOL)animated completitionBlock:(void (^)(UIAlertAction *action))completitionBlock
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    if (cancelButtonTitle) {
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
            if (completitionBlock) {
                completitionBlock(action);
            }
        }];
        [alert addAction:cancel];
    }
    
    for (NSString *title in otherButtonsTitles) {
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            if (completitionBlock) {
                completitionBlock(action);
            }
        }];
        [alert addAction:otherAction];
    }
    [self presentViewController:alert animated:animated completion:nil];
}


@end
