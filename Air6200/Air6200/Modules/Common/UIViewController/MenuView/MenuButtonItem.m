//
//  MenuButtonItem.m
//  Air6200
//
//  Created by Jianglei Wang on 2014/08/22.
//  Copyright (c) 2014年 Jianglei Wang. All rights reserved.
//

#import "MenuButtonItem.h"

const CGFloat kOffset  = 3.0f;
const CGFloat kFontSize       = 12.0f;
const CGFloat heightMenuButtonItem = 50;
@implementation MenuButtonItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
- (id)initWithTitle:(NSString *)title image:(UIImage *)image tag:(NSInteger)tag{
    
    return nil;
}
- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage NS_AVAILABLE_IOS(7_0){
    return nil;
}
- (id)initWithTabBarSystemItem:(UITabBarSystemItem)systemItem tag:(NSInteger)tag{
    return nil;
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect bounds = self.bounds;
    CGSize imageSize = self.image.size;
    CGFloat imageOffset = self.title.length > 0 ? kOffset : 0.f;
    
    // draw image overlay?
    if (self.image != nil) {
        CGContextSaveGState(context);
        
        // flip the coordinates system
        CGContextTranslateCTM(context, 0.f, bounds.size.height);
        CGContextScaleCTM(context, 1.f, -1.f);
        

        CGRect imageRect = CGRectMake(floorf(((bounds.size.width-imageSize.width)/2.f)),
                                      floorf(((bounds.size.height-imageSize.height)/2.f)) + imageOffset,
                                      imageSize.width,
                                      imageSize.height);
        if (self.selected) {
            CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
            CGColorSpaceRelease(colorSpace);
            CGContextClipToMask(context, imageRect, [self.image CGImage]);
            CGContextSetFillColorWithColor(context, SELECT_COLOR.CGColor);
            CGContextFillRect(context, imageRect);
        } else {
            CGContextDrawImage(context, imageRect, self.image.CGImage);
        }
        
        CGContextRestoreGState(context);
    }
    if (![self.title isEqualToString:@""]) {
        CGContextSaveGState(context);
 
        CGRect titleRect = CGRectMake(0,
                                      floorf(self.bounds.size.height) - kFontSize - kOffset,
                                      bounds.size.width,
                                      kFontSize + kOffset);
        
        UIFont *helveticaFont = [UIFont fontWithName:@"Arial" size:kFontSize];
        NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        /// Set line break mode
        paragraphStyle.lineBreakMode = NSLineBreakByClipping;
        /// Set text alignment
        paragraphStyle.alignment = NSTextAlignmentCenter;

        if (!self.selected) {
            [self.title drawInRect:titleRect withAttributes:
                @{NSFontAttributeName:helveticaFont,
                  NSParagraphStyleAttributeName:paragraphStyle,
                  NSForegroundColorAttributeName:[UIColor blackColor]
                  }];
        } else {
            [self.title drawInRect:titleRect withAttributes:
                @{NSFontAttributeName:helveticaFont,
                  NSParagraphStyleAttributeName:paragraphStyle,
                  NSForegroundColorAttributeName:SELECT_COLOR
                  }];
        }
        CGContextRestoreGState(context);
    }
}
- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    return YES;
}
- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    return YES;
}
- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    if (self.block_Select) {
        self.block_Select(self.index);
    }
}

-(void)setIsSelected:(BOOL)selected{
    self.selected = selected;
    [self setNeedsDisplay];
}
@end
