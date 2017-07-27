//
//  WMTBuyNowControl.h
//  WMTSDKKit
//
//  Copyright © 2016 @WalmartLabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WMTButtonEnum.h"
#import "WMTItem.h"
#import "WMTLineItem.h"

/**
 `WMTBuyNowControl` class is responsible for creating and managing the WMTBuyNow buttons.
 
 Every `WMTBuyNowControl` instance has an associated WMTBuyNow button.
 You can modify the look and feel as well as the Walmart items associated with the WMTBuyNow button.
 
 */
@interface WMTBuyNowControl : UIControl



/**
 *  The size scheme for the `WMTBuyNowControl` instance. Default value is `WMTButtonSizeSchemePrimary`.
 *
 *  This property can be used to override the default size scheme for the WMTBuyNow button of the `WMTBuyNowControl` instance.
 *  
 *  @see WMTButtonSizeScheme enum for possible size schemes values for this property.
 */
@property(nonatomic) WMTButtonSizeScheme sizeScheme;



/**
 *  The color scheme for the `WMTBuyNowControl` instance. Default value is `WMTButtonSizeSchemeOrange`.
 *
 *  This property can be used to override the default color scheme for the WMTBuyNow button of the `WMTBuyNowControl` instance.
 *  
 *  @see WMTButtonColorScheme enum for possible color schemes values for this property.
 */
@property(nonatomic) WMTButtonColorScheme colorScheme;



- (instancetype)init;



/**
 *  Initializes a new `WMTBuyNowControl` object with the specified set of WMTLineItems.
 *
 *  @param wmtLineItems The set of WMTLineItems with which the `WMTBuyNowControl` object gets initialized.
 *
 *  @return The `WMTBuyNowControl` object.
 */
- (instancetype)initWithWMTLineItems:(NSSet<WMTLineItem *> *)wmtLineItems;



/**
 *  Get the set of WMTLineItems associated with `WMTBuyNowControl` object.
 *
 *  @return Set of WMTLineItems
 */
- (NSSet<WMTLineItem *> *)getWMTLineItems;



/**
 *  Sets the WMTLineItem list of `WMTBuyNowControl` object to the specified WMTLineItem set.
 *
 *  @param wmtLineItems The set of WMTLineItems to be set.
 */
- (void)setWMTLineItems:(NSSet<WMTLineItem *> *)wmtLineItems;



/**
 *  Sets the wmtItem in WTTLineItem list with the specified quantity.
 *  If the wmtItem doesn't exists in the WMTLineItem list, it is added to the it with that quantity.
 *
 *  @param wmtItem  The WMTItem to be set.
 *  @param quantity The quantity with which wmtItem has to be set.
 */
- (void)setWMTItem:(WMTItem *)wmtItem
      withQuantity:(NSUInteger)quantity;



/**
 *  Adds the specified quantity of wmtItem to the corresponding WMTItem in the WMTLineItem list.
 *  If the wmtItem doesn't exist in the WMTLineItem list, it is added to it.
 *
 *  @param wmtItem The WMTItem to be added.
 *  @param quantity The quantity of wmtItem to be added.
 */
- (void)addWMTItem:(WMTItem *)wmtItem
      withQuantity:(NSUInteger)quantity;



/**
 *  Removes the specified wmtItem from the WMTLineItem list.
 *  If the wmtItem doesn't exists in the WMTLineItem list, WMTException is raised.
 *
 *  @param wmtItem The WMTItem to be removed.
 */
- (void)removeWMTItem:(WMTItem *)wmtItem;



/**
 *  Removes the specified quantity of wmtItem from the corresponding WMTItem in the WMTLineItem list.
 *  If the wmtItem doesn't exists in the WMTLineItem list, or if the specified quantity is more than what exists in the list
 *  WMTException is raised.
 *
 *  @param wmtItem The WMTItem to be removed.
 *  @param quantity The quantity of wmtItem to be removed.
 */
- (void)removeWMTItem:(WMTItem *)wmtItem
         withQuantity:(NSUInteger)quantity;



/**
 *  Removes all the WMTItems from the WMTLineItem list associated with WMTBuyNowControl object.
 */
- (void)removeAllWMTItems;

@end
