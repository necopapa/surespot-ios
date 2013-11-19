//
//  LoadingView.m
//  LoadingView
//

// Modified by 2fours

//  Created by Matt Gallagher on 12/04/09.
//  Copyright Matt Gallagher 2009. All rights reserved.
//
//  Permission is given to use this source code file, free of charge, in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.
//

#import "LoadingView.h"
#import "LoadingView.h"
#import <QuartzCore/QuartzCore.h>
#import "UIUtils.h"


@implementation LoadingView

//
// loadingViewInView:
//
// Constructor for this view. Creates and adds a loading view for covering the
// provided aSuperview.
//
// Parameters:
//    aSuperview - the superview that will be covered by the loading view
//
// returns the constructed view, already added as a subview of the aSuperview
//	(and hence retained by the superview)
//
+ (id)loadingViewInView:(UIView *)aSuperview textKey: (NSString *) textKey
{
	LoadingView *loadingView =
    [[LoadingView alloc] initWithFrame:[aSuperview bounds]];
	if (!loadingView)
	{
		return nil;
	}
	
    loadingView.backgroundColor = [UIUtils surespotTransparentGrey];
	loadingView.opaque = NO;
	loadingView.autoresizingMask =
    UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	[aSuperview addSubview:loadingView];
    
	const CGFloat DEFAULT_LABEL_WIDTH = aSuperview.bounds.size.width;

    UIView * labelView = [[UIView alloc] initWithFrame:CGRectZero];
    labelView.backgroundColor = [UIColor whiteColor];
    [loadingView addSubview:labelView];

	   
    UIImage * image =[UIImage imageNamed:@"surespot_logo.png"];
    UIImageView * imageView = [[UIImageView alloc] initWithImage: image];
    
	[loadingView addSubview:imageView];
    imageView.autoresizingMask =
    UIViewAutoresizingFlexibleLeftMargin |
    UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin |
    UIViewAutoresizingFlexibleBottomMargin;
	
    CABasicAnimation *rotation;
    rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotation.fromValue = [NSNumber numberWithFloat:0];
    rotation.toValue = [NSNumber numberWithFloat:(2*M_PI)];
    rotation.duration = 1.1; // Speed
    rotation.repeatCount = HUGE_VALF; //
    [imageView.layer addAnimation:rotation forKey:@"spin"];
    
  


    CGRect labelFrame = CGRectMake(0, 0, DEFAULT_LABEL_WIDTH - (imageView.frame.size.width + 50), imageView.frame.size.height);
    
    UILabel *loadingLabel =
    [[UILabel alloc]
     initWithFrame:labelFrame];
    
	loadingLabel.text = NSLocalizedString(textKey, nil);
    loadingLabel.numberOfLines = 0;
    loadingLabel.lineBreakMode = NSLineBreakByWordWrapping;
	loadingLabel.textColor = [UIColor blackColor];
	loadingLabel.backgroundColor = [UIColor clearColor];
	loadingLabel.textAlignment = NSTextAlignmentLeft;
	loadingLabel.font = [UIFont boldSystemFontOfSize:[UIFont labelFontSize]];
	loadingLabel.autoresizingMask =
    UIViewAutoresizingFlexibleLeftMargin |
    UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin |
    UIViewAutoresizingFlexibleBottomMargin;
    
    [loadingLabel sizeToFit];
	
	[loadingView addSubview:loadingLabel];

    
	
    CGFloat totalHeight =  MAX(loadingLabel.frame.size.height ,imageView.frame.size.height);
		
	CGRect activityIndicatorRect = imageView.frame;
	activityIndicatorRect.origin.x =floor(0.5 * (loadingView.frame.size.width - DEFAULT_LABEL_WIDTH + 50));
	activityIndicatorRect.origin.y = floor(0.5 * (loadingView.frame.size.height - totalHeight));
	imageView.frame = activityIndicatorRect;
    
   
    labelFrame.origin.x = imageView.frame.origin.x + imageView.frame.size.width + 20;
	labelFrame.origin.y = floor(0.5 * (loadingView.frame.size.height - totalHeight));
	loadingLabel.frame = labelFrame;

        CGRect viewFrame = CGRectMake(0, 0, DEFAULT_LABEL_WIDTH, totalHeight + 10);
    viewFrame.origin.y =(loadingView.frame.size.height - (totalHeight + 10))/2;
    labelView.frame =viewFrame;

    
	
	// Set up the fade-in animation
	CATransition *animation = [CATransition animation];
	[animation setType:kCATransitionFade];
	[[aSuperview layer] addAnimation:animation forKey:@"layerAnimation"];
	
	return loadingView;
}

//
// removeView
//
// Animates the view out from the superview. As the view is removed from the
// superview, it will be released.
//
- (void)removeView
{
	UIView *aSuperview = [self superview];
	[super removeFromSuperview];
    
	// Set up the animation
	CATransition *animation = [CATransition animation];
	[animation setType:kCATransitionFade];
	
	[[aSuperview layer] addAnimation:animation forKey:@"layerAnimation"];
}

//
// drawRect:
//
// Draw the view.
//
- (void)drawRect:(CGRect)rect
{
//	rect.size.height -= 1;
//	rect.size.width -= 1;
//	
//	const CGFloat RECT_PADDING = 0.0;
//	rect = CGRectInset(rect, RECT_PADDING, RECT_PADDING);
//	
//	const CGFloat ROUND_RECT_CORNER_RADIUS = 0.0;
//	CGPathRef roundRectPath = NewPathWithRoundRect(rect, ROUND_RECT_CORNER_RADIUS);
//	
//	CGContextRef context = UIGraphicsGetCurrentContext();
//    
//	const CGFloat BACKGROUND_OPACITY = 0.85;
//	CGContextSetRGBFillColor(context, 0, 0, 0, BACKGROUND_OPACITY);
//	CGContextAddPath(context, roundRectPath);
//	CGContextFillPath(context);
//    
//	const CGFloat STROKE_OPACITY = 0.25;
//	CGContextSetRGBStrokeColor(context, 1, 1, 1, STROKE_OPACITY);
//	CGContextAddPath(context, roundRectPath);
//	CGContextStrokePath(context);
//	
//	CGPathRelease(roundRectPath);
}



@end