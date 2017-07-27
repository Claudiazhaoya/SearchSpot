//
//  WMTLogger.h
//  WMTSDKKit
//
//  Copyright © 2016 @WalmartLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

#define WMTLogFormat @"%@ line:%d | %s | "

#define WMTLogError(fmt, ...)    [[WMTLogger defaultLogger] log:WMTLogLevelError format:(WMTLogFormat fmt), [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, __PRETTY_FUNCTION__, ##__VA_ARGS__]
#define WMTLogWarn(fmt, ...)    [[WMTLogger defaultLogger] log:WMTLogLevelWarn format:(WMTLogFormat fmt), [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, __PRETTY_FUNCTION__, ##__VA_ARGS__]
#define WMTLogInfo(fmt, ...)    [[WMTLogger defaultLogger] log:WMTLogLevelInfo format:(WMTLogFormat fmt), [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, __PRETTY_FUNCTION__, ##__VA_ARGS__]
#define WMTLogDebug(fmt, ...)    [[WMTLogger defaultLogger] log:WMTLogLevelDebug format:(WMTLogFormat fmt), [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, __PRETTY_FUNCTION__, ##__VA_ARGS__]
#define WMTLogVerbose(fmt, ...)    [[WMTLogger defaultLogger] log:WMTLogLevelVerbose format:(WMTLogFormat fmt), [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, __PRETTY_FUNCTION__, ##__VA_ARGS__]


/**
 *  The available logging levels/
 */
typedef NS_ENUM(NSInteger, WMTLogLevel) {
    /**
     * The log level is unknown.
     */
    WMTLogLevelUnknown = -1,
    /**
     * No logging.
     */
    WMTLogLevelNone = 0,
    /**
     * The Error logging level.
     */
    WMTLogLevelError = 1,
    /**
     * The Warn logging level.
     */
    WMTLogLevelWarn = 2,
    /**
     * The Info logging level.
     */
    WMTLogLevelInfo = 3,
    /**
     * The Debug logging level.
     */
    WMTLogLevelDebug = 4,
    /**
     * The Verbose logging level.
     */
    WMTLogLevelVerbose = 5
};


/**
 *  WMTLogger is an utility class that handles logging to the console. Changing log levels during development may make debugging easier. You can change the log level by
 *
 *  ```[WMTLogger defaultLogger].logLevel = WMTLogLevelVerbose;```
 *
 *  The following logging level options are available:
 *
 *      1. WMTLogLevelNone
 *      2. WMTLogLevelError (This is the default. Only error logs are printed to the console.)
 *      3. WMTLogLevelWarn
 *      4. WMTLogLevelInfo
 *      5. WMTLogLevelDebug
 *      6. WMTLogLevelVerbose
 *
 */

@interface WMTLogger : NSObject



/**
 *  The log level setting. The default is `WMTLogLevelError`.
 *
 *  Refer to `WMTogLevel` for available logging levels.
 */
@property (atomic, assign) WMTLogLevel logLevel;



/**
 *  The default shared logger object.
 *
 *  @return The default shared logger object.
 */
+ (instancetype)defaultLogger;



/**
 *  Prints out the formatted logs to the console. You can use the following predefined shorthand methods instead:
 *
 *  @param logLevel The level of this log.
 *  @param fmt      The formatted string to log.
 */
- (void)log:(WMTLogLevel)logLevel format:(NSString *)fmt, ... NS_FORMAT_FUNCTION(2, 3);

@end

