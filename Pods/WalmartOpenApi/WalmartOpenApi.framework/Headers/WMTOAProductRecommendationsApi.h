#import <Foundation/Foundation.h>
#import "WMTOAItem.h"
#import "WMTOATrendingItems.h"
#import "WMTOAApi.h"

/**
 * NOTE: This class is auto generated by the swagger code generator program. 
 * https://github.com/swagger-api/swagger-codegen 
 * Do not edit the class manually.
 */


@interface WMTOAProductRecommendationsApi: NSObject <WMTOAApi>

extern NSString* kWMTOAProductRecommendationsApiErrorDomain;
extern NSInteger kWMTOAProductRecommendationsApiMissingParamErrorCode;

+(instancetype) sharedAPI;

/// Get the next best product recommendations
/// The Product recommendation API is an extension driven by the science that powers the recommended products container on Walmart.com. We have parsed 100s of millions of transactions over our product catalog of more than 6 million products to be able to deliver, with accuracy, the items in this response. Some example use cases where a partner might be interested in utilizing this data:  A recommended products advertising widget via e-mail delivered right after a transaction has been verified Retargeting on an ecommerce storefront anchored on a shared UPC between multiple merchants An upsell to an existing customer presenting an array of products due to knowing their order history The endpoint returns a maximum of 10 item responses, being ordered from most relevant to least relevant for the customer.
///
/// @param apiKey Your API access key.
/// @param itemId Walmart item id
/// @param format Type of response required, allowed values [json, xml]. (optional) (default to json)
/// @param lsPublisherId Your Linkshare access key (optional)
/// 
///  code:200 message:"successful operation",
///  code:400 message:"Invalid itemId",
///  code:500 message:"Internal Server error"
///
/// @return NSArray<WMTOAItem>*
-(NSNumber*) getNextBestProductsWithApiKey: (NSString*) apiKey
    itemId: (NSString*) itemId
    format: (NSString*) format
    lsPublisherId: (NSString*) lsPublisherId
    completionHandler: (void (^)(NSArray<WMTOAItem>* output, NSError* error)) handler;


/// Get the post browsed products recommendations
/// The post browsed products API allows you to recommend products to someone based on their product viewing history. Similar to the Product Recommendation API, this endpoint uses one item ID as the anchor for the output. For instance, if you know that one of your customers has recently viewed an Xbox one, it is likely that they may be also interested in purchasing a PlayStation 4, or Nintento Wii. Some example use cases for this data:  Retargeting to your customers based on knowing their recent viewing history. Understanding what other similar items a customer might purchase if the initial item they were interested in has gone out of stock. The endpoint returns a maximum of 10 item responses, being ordered from most relevant to least relevant for the customer.
///
/// @param apiKey Your API access key.
/// @param itemId Walmart item id
/// @param format Type of response required, allowed values [json, xml]. (optional) (default to json)
/// @param lsPublisherId Your Linkshare access key (optional)
/// 
///  code:200 message:"successful operation",
///  code:400 message:"Invalid itemId",
///  code:500 message:"Internal Server error"
///
/// @return NSArray<WMTOAItem>*
-(NSNumber*) getPostBrowseProductsWithApiKey: (NSString*) apiKey
    itemId: (NSString*) itemId
    format: (NSString*) format
    lsPublisherId: (NSString*) lsPublisherId
    completionHandler: (void (^)(NSArray<WMTOAItem>* output, NSError* error)) handler;


/// Get the trending products recommendations
/// Trending API is designed to give the information on what is bestselling on Walmart.com right now. The items are curated on the basis of user browse activity and sales activity, and updated multiple times a day. Expect a high clickthrough and conversion rate on these items if you choose to advertise them.  
///
/// @param apiKey Your API access key.
/// @param format Type of response required, allowed values [json, xml]. (optional) (default to json)
/// @param lsPublisherId Your Linkshare access key (optional)
/// 
///  code:200 message:"successful operation",
///  code:404 message:"Trending Items Unavailable",
///  code:500 message:"Internal Server error"
///
/// @return WMTOATrendingItems*
-(NSNumber*) getTrendingItemsWithApiKey: (NSString*) apiKey
    format: (NSString*) format
    lsPublisherId: (NSString*) lsPublisherId
    completionHandler: (void (^)(WMTOATrendingItems* output, NSError* error)) handler;



@end
