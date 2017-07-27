//
//  WMTLineItem.h
//  WMTSDKKit
//
//  Copyright © 2016 @WalmartLabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WMTItem.h"

/**
 *  WMTLineItem class provides Walmart Line Item objects.
 */
@interface WMTLineItem : NSObject



/**
 *  The WMTItem associated with WMTLineItem object.
 */
@property(nonatomic, strong) WMTItem *wmtItem;



/**
 *  The quantity of the WMTItem associated with the WMTLineItem object.
 */
@property(nonatomic) NSUInteger quantity;



/**
 *  Initializes a WMTLineItem object.
 *
 *  @param wmtItem  The WMTItem object.
 *  @param quantity The quantity of WMTItem.
 *
 *  @return The WMTLineItem object.
 */
- (instancetype)initWithWMTItem:(WMTItem *)wmtItem
                       quantity:(NSUInteger)quantity;



/**
 *  Returns a WMTLineItem object.
 *
 *  @param wmtItem  The WMTItem
 *  @param quantity The quantity of WMTItem
 *
 *  @return The WMTLineItem object.
 */
+ (instancetype)createItemWithWMTItem:(WMTItem *)wmtItem
                           quantity:(NSUInteger)quantity;

@end
