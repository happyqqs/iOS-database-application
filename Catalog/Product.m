//
//  Product.m
//  Catalog
//
//  Created by 申倩倩 on 16/11/27.
//  Copyright © 2016年 申倩倩. All rights reserved.
//

#import "Product.h"

@implementation Product

@synthesize ID;
@synthesize name;
@synthesize manufacturer;
@synthesize details;
@synthesize price;
@synthesize quantity;
@synthesize countryOfOrigin;
@synthesize image;

-(NSString*) description
{
    NSString *description = [[NSString alloc] initWithFormat:@"ID:%d  Name:%@  Manufacturer:%@  Details:%@  Price:%.2f  Quantity:%d  Country:%@  Image:%@  ", self.ID, self.name, self.manufacturer, self.details, self.price, self.quantity, self.countryOfOrigin, self.image];
    return description;
}

@end
