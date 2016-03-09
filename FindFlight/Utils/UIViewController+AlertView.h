//
//  UIViewController+AlertView.h
//  Helpers
//
//  Created by spens on 08/10/15.
//  Copyright © 2015 ru.spens. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (AlertView)

- (void)showAlertwithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelButtonTitle otherButtonsTitles:(NSArray *)otherButtonsTitles animated:(BOOL)animated completitionBlock:(void (^)(UIAlertAction *action))completitionBlock;

@end
