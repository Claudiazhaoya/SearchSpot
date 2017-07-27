//
//  WMTSDK.h
//  WMTSDKKit
//
//  Copyright © 2016 @WalmartLabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


/**
 * The main configuration class for Walmart SDK. Initializes variables required for sdk to function.
 */

@interface WMTSDK : NSObject



/**
 *  Gets the singeton instance of `WMTSDK` class. Use only this instance to initialize the SDK.
 *
 *  @return Singleton instance of `WMTSDK` class
 */
+ (instancetype)sharedInstance;



/**
 *  Initializes the Walmart SDK.
 *
 *  @warning Call this method only once.
 */
- (void)initSDK;



/**
 *  Initializes the Walmart SDK.
 *
 *  @param disableTracking Whether tracking of user information should be enabled.
 *  
 *  @warning Call this method only once.
 */
- (void)initSDKWithDisableTracking:(BOOL)disableTracking;

@end
