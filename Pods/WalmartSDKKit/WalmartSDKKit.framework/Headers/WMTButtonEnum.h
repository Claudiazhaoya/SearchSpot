//
//  WMTButtonEnum.h
//  WMTSDKKit
//
//  Copyright © 2016 @WalmartLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  WMTButtonColorScheme captures the available color schemes constants for walmart buttons.
 */
typedef NS_ENUM(NSUInteger, WMTButtonColorScheme) {
    /**
     *  The orange color scheme for the walmart button.
     */
    WMTButtonColorSchemeOrange = 0,
    /**
     *  The blue color scheme for the walmart button.
     */
    WMTButtonColorSchemeBlue = 1,
};



/**
 *  WMTButtonSizeScheme captures the available size schemes constant for the walmart buttons.
 */
typedef NS_ENUM(NSUInteger, WMTButtonSizeScheme) {
    /**
     *  The primary size scheme for the walmart button.
     */
    WMTButtonSizeSchemePrimary = 0,
    /**
     *  The compact size scheme for the walmart button.
     */
    WMTButtonSizeSchemeCompact = 1,
    /**
     *  The mini size scheme for the walmart button.
     */
    WMTButtonSizeSchemeMini = 2,
};