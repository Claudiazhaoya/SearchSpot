//
//  WMTException.h
//  WMTSDKKit
//
//  Copyright © 2016 @WalmartLabs. All rights reserved.
//

#import <Foundation/Foundation.h>



/**
 *  These constants indicate the type of error that resulted in an operation's
 *  failure.
 */
typedef NS_ENUM(NSUInteger, WMTError) {
    /**
     *  Indicates the Walmart SDK has not been initialized. Call ```[[WMTSDK sharedInstance]initSDK]``` first.
     */
    WMTErrorSDKNotInitialized,
    /**
     *  Indicates that Walmart SDK calls has been made more than once. Call ```[[WMTSDK sharedInstance]initSDK]``` only once.
     */
    WMTErrorSDKAlreadyInitialized,
    /**
     *  Indicates that publihser id is missing in Info.plist file. Refer to documentation for more details.
     */
    WMTErrorPublisherIdNotFound,
    /**
     *  Indicates that walmart item is missing in the Walmart Line Item list associated with `WMTBuyNowControl` object.
     */
    WMTErrorItemNotFound
};



/**
 * WMTException is the wrapper class for NSExceptions for raising any `WMTError`.
 *
 * Refer to WMTError for possible error that may result in operation's failure.
 */
@interface WMTException : NSException

- (instancetype)initWithError:(WMTError)wmtError;

+ (instancetype)exceptionWithError:(WMTError)error;

@end
