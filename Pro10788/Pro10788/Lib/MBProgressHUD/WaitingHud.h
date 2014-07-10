//
//  WaitingHud.h
//  CardMaster
//
//  Created by sy on 8/12/13.
//  Copyright (c) 2013 GL. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

@protocol ProgressHUDDelegate;

typedef enum {
	/** Progress is shown using an UIActivityIndicatorView. This is the default. */
	ProgressHUDModeIndeterminate,
	/** Progress is shown using a round, pie-chart like, progress view. */
	ProgressHUDModeDeterminate,
	/** Progress is shown using a ring-shaped progress view. */
	ProgressHUDModeAnnularDeterminate,
	/** Shows a custom view */
	ProgressHUDModeCustomView,
	/** Shows only labels */
	ProgressHUDModeText
} ProgressHUDMode;

typedef enum {
	/** Opacity animation */
	ProgressHUDAnimationFade,
	/** Opacity + scale animation */
	ProgressHUDAnimationZoom,
	ProgressHUDAnimationZoomOut = ProgressHUDAnimationZoom,
	ProgressHUDAnimationZoomIn
} ProgressHUDAnimation;

#ifndef MB_STRONG
#if __has_feature(objc_arc)
#define MB_STRONG strong
#else
#define MB_STRONG retain
#endif
#endif

#ifndef MB_WEAK
#if __has_feature(objc_arc_weak)
#define MB_WEAK weak
#elif __has_feature(objc_arc)
#define MB_WEAK unsafe_unretained
#else
#define MB_WEAK assign
#endif
#endif

#if NS_BLOCKS_AVAILABLE
typedef void (^ProgressHUDCompletionBlock)();
#endif

@interface WaitingHud : UIView
+ (WaitingHud *)showHUDAddedTo:(UIView *)view animated:(BOOL)animated;
+ (BOOL)hideHUDForView:(UIView *)view animated:(BOOL)animated;
+ (NSUInteger)hideAllHUDsForView:(UIView *)view animated:(BOOL)animated;
+ (WaitingHud *)HUDForView:(UIView *)view;
+ (NSArray *)allHUDsForView:(UIView *)view;
- (id)initWithWindow:(UIWindow *)window;
- (id)initWithView:(UIView *)view;
- (void)show:(BOOL)animated;
- (void)hide:(BOOL)animated;
- (void)hide:(BOOL)animated afterDelay:(NSTimeInterval)delay;
- (void)showWhileExecuting:(SEL)method onTarget:(id)target withObject:(id)object animated:(BOOL)animated;

#if NS_BLOCKS_AVAILABLE
- (void)showAnimated:(BOOL)animated whileExecutingBlock:(dispatch_block_t)block;
- (void)showAnimated:(BOOL)animated whileExecutingBlock:(dispatch_block_t)block completionBlock:(ProgressHUDCompletionBlock)completion;

- (void)showAnimated:(BOOL)animated whileExecutingBlock:(dispatch_block_t)block onQueue:(dispatch_queue_t)queue;

- (void)showAnimated:(BOOL)animated whileExecutingBlock:(dispatch_block_t)block onQueue:(dispatch_queue_t)queue
     completionBlock:(ProgressHUDCompletionBlock)completion;

@property (atomic, copy) ProgressHUDCompletionBlock completionBlock;

#endif

@property (atomic, assign) ProgressHUDMode mode;
@property (atomic, assign) ProgressHUDAnimation animationType;
@property (atomic, MB_STRONG) UIView *customView;
@property (atomic, MB_WEAK) id<ProgressHUDDelegate> delegate;
@property (atomic, copy) NSString *labelText;
@property (atomic, copy) NSString *detailsLabelText;
@property (atomic, assign) float opacity;
@property (atomic, MB_STRONG) UIColor *color;
@property (atomic, assign) float xOffset;
@property (atomic, assign) float yOffset;
@property (atomic, assign) float margin;
@property (atomic, assign) BOOL dimBackground;
@property (atomic, assign) float graceTime;
@property (atomic, assign) float minShowTime;
@property (atomic, assign) BOOL taskInProgress;
@property (atomic, assign) BOOL removeFromSuperViewOnHide;
@property (atomic, MB_STRONG) UIFont* labelFont;
@property (atomic, MB_STRONG) UIFont* detailsLabelFont;
@property (atomic, assign) float progress;
@property (atomic, assign) CGSize minSize;
@property (atomic, assign, getter = isSquare) BOOL square;
@end

@protocol ProgressHUDDelegate <NSObject>

@optional

- (void)hudWasHidden:(WaitingHud *)hud;

@end

@interface RoundProgressView : UIView

@property (nonatomic, assign) float progress;

@property (nonatomic, assign, getter = isAnnular) BOOL annular;

@end
