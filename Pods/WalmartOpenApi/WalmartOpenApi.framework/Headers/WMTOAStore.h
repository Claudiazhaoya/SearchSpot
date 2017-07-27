#import <Foundation/Foundation.h>
#import "WMTOAObject.h"

/**
 * NOTE: This class is auto generated by the swagger code generator program.
 * https://github.com/swagger-api/swagger-codegen
 * Do not edit the class manually.
 */



@protocol WMTOAStore
@end

@interface WMTOAStore : WMTOAObject


@property(nonatomic) NSNumber* no;

@property(nonatomic) NSString* name;

@property(nonatomic) NSString* country;

@property(nonatomic) NSArray<NSNumber*>* coordinates;

@property(nonatomic) NSString* streetAddress;

@property(nonatomic) NSString* city;

@property(nonatomic) NSString* stateProvCode;

@property(nonatomic) NSString* zip;

@property(nonatomic) NSString* phoneNumber;

@property(nonatomic) NSNumber* sundayOpen;

@property(nonatomic) NSString* timezone;

@end
