#import <Foundation/Foundation.h>

@interface ToolbarWithText : UIView {
  UIToolbar *theBar;
  UIActivityIndicatorView *spinner;
  UILabel *displayText;
  NSObject *target;
  UIBarButtonItem *spinnerButton;
  UIBarButtonItem *refreshButton;
}

@property (nonatomic, retain) UIActivityIndicatorView *spinner;
@property (nonatomic, retain) UILabel *displayText;
@property (nonatomic, retain) NSObject *target;
@property (nonatomic, retain) UIBarButtonItem *spinnerButton;
@property (nonatomic, retain) UIBarButtonItem *refreshButton;
@property (nonatomic, retain) UIToolbar *theBar;

- (id)initWithFrame:(CGRect)frame target:(NSObject *)theTarget;

- (void)displayCheckingNew;
- (void)replaceRefreshWithSpinner;
- (void)replaceSpinnerWithRefresh;
- (void)setText:(NSString *)text;
- (void)setTextToCurrentTime;
- (void)removeCompose;

@end