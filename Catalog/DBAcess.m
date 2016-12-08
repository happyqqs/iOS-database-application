//
//  DBAcess.m
//  Catalog
//
//  Created by 申倩倩 on 16/11/27.
//  Copyright © 2016年 申倩倩. All rights reserved.
//

#import "DBAcess.h"

sqlite3* database;

@implementation DBAcess

-(instancetype) init
{
    if (self = [super init]) {
        [self initializeDatabase];
    }
    return self;
}

-(void) initializeDatabase
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"directory" ofType:@"sqlite3"];

    if(sqlite3_open([path UTF8String], &database) == SQLITE_OK) {
        NSLog(@"Opening Database");
    } else {
        sqlite3_close(database);
        NSAssert1(0, @"Failed to open database: '%s'.", sqlite3_errmsg(database));
    }
    
}

-(void) closeDatabase
{
    if(sqlite3_close(database) != SQLITE_OK) {
        NSAssert1(0, @"Failed to close database: '%s'.", sqlite3_errmsg(database));
    }
}

-(NSMutableArray*) getAllProducts
{
    NSMutableArray* products = [[NSMutableArray alloc] init];
    //const char* sql = "select product.ID, product.name, \
    Manufacturer.name, product.details, product.price, \
    product.quantityonhand, country.country, \
    product.image FROM Product, Manufacturer, \
    Country where manufacturer.manufacturerID = product.manufacturerID \
    and product.countryoforiginid = country.countryid";
    
    const char *sql = "SELECT product.ID,product.Name,Manufacturer.name,product.details,product.price,product.quantityonhand, country.country, product.image FROM Product,Manufacturer, Country where manufacturer.manufacturerid=product.manufacturerid and product.countryoforiginalid=country.countryid";
    
    sqlite3_stmt *statement;
    
    int sqlResult = sqlite3_prepare_v2(database, sql, -1, &statement, NULL);
    
    if (sqlResult == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            //每一行分配一个Product对象
            Product *product = [[Product alloc] init];
            
            char *name = (char*)sqlite3_column_text(statement, 1);
            char *manufacturer = (char*)sqlite3_column_text(statement, 2);
            char *details = (char*)sqlite3_column_text(statement, 3);
            char *countryOfOrigin = (char*)sqlite3_column_text(statement, 6);
            char *image = (char*)sqlite3_column_text(statement, 7);
            
            product.ID = sqlite3_column_int(statement, 0);
            
            product.name = (name) ? [NSString stringWithUTF8String:name] : @"";
            product.manufacturer = (manufacturer) ? [NSString stringWithUTF8String:manufacturer] : @"";
            product.details = (details) ? [NSString stringWithUTF8String:details] : @"";
            product.countryOfOrigin = (countryOfOrigin) ? [NSString stringWithUTF8String:countryOfOrigin] : @"";
            product.image = (image) ? [NSString stringWithUTF8String:image] : @"";
            
            product.price = sqlite3_column_double(statement, 4);
            product.quantity = sqlite3_column_int(statement, 5);
            
            [products addObject:product];
        }
        sqlite3_finalize(statement);
    } else {
        NSLog(@"Problem with the database");
        NSLog(@"%d", sqlResult);
    }
    return products;
}

@end
