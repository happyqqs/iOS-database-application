//
//  DBAcess.h
//  Catalog
//
//  Created by 申倩倩 on 16/11/27.
//  Copyright © 2016年 申倩倩. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <sqlite3.h>
#import "Product.h"

@interface DBAcess : NSObject
{
    
}

- (NSMutableArray*) getAllProducts;
- (void) closeDatabase;
- (void) initializeDatabase;

@end
