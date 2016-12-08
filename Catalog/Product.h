//
//  Product.h
//  Catalog
//
//  Created by 申倩倩 on 16/11/27.
//  Copyright © 2016年 申倩倩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject{
    int ID;
    NSString * name;
    NSString* manufacturer;
    NSString* details;
    float price;
    int quantity;
    NSString* countryOfOrigin;
    NSString* image;
}

@property (nonatomic) int ID;
@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* manufacturer;
@property (strong, nonatomic) NSString* details;
@property (nonatomic) float price;
@property (nonatomic) int quantity;
@property (strong, nonatomic) NSString* countryOfOrigin;
@property (strong, nonatomic) NSString* image;
@property NSInteger section;//保存区段号码，用于索引

@end
