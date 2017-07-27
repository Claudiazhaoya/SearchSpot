//
//  WMTItem.h
//  WMTSDKKit
//
//  Copyright © 2016 @WalmartLabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WalmartOpenApi/WalmartOpenApi.h>


/**
 *  Type of Walmart Item Id.
 */
typedef NS_ENUM(NSUInteger, WMTItemIdType) {
    /**
     *  The walmart id for the item
     */
    WMTItemIdTypeWalmartId,
    /**
     *  The upc id for the item
     */
    WMTItemIdTypeUPC
};



/**
 *  WMTItem class provides Walmart Item object.
 */
@interface WMTItem : NSObject



/**
 *  The item id as string
 */
@property(nonatomic, strong) NSString *itemId;



/**
 *  The type of item id
 *
 *  Refer to `WMTItemIdType` for available Walmart item id types.
 */
@property(nonatomic) WMTItemIdType itemIdType;



/**
 *  Initializes a WMTItem with the specified itemId and itemIdType.
 *
 *  @param itemId     The item id string
 *  @param itemIdType The type of item id
 *
 *  @return The WMTItem instance with the specified parameters.
 */
- (instancetype)initWithItemId:(NSString *)itemId
                    itemIdType:(WMTItemIdType)itemIdType;



/**
 *  Initializes a WMTItem with the specified WMTOAItem.
 *
 *  @param wmtoaItem WalmartOpenApi item
 *
 *  @return The WMTItem instance
 */
- (instancetype)initWithWMTOAItem:(WMTOAItem *)wmtoaItem;



/**
 *  Returns a WMTItem with the specified itemId and itemIdType.
 *
 *  @param itemId     The item id string
 *  @param itemIdType The type of item id.
 *
 *  @return The WMTItem object with the specified parameters
 */
+ (instancetype)createItemWithItemId:(NSString *)itemId
                          itemIdType:(WMTItemIdType)itemIdType;




/**
 *  Returns a WMTItem with the specified WMTOAItem
 *
 *  @param wmtoaItem WalmartOpenApi item
 *
 *  @return The WMTItem instance
 */
+ (instancetype)createItemWithWMTOAItem:(WMTOAItem *)wmtoaItem;



- (BOOL)isEqual:(id)object;



- (NSUInteger)hash;

@end
