//
//  CatalogProductView.h
//  Catalog
//
//  Created by 申倩倩 on 16/11/30.
//  Copyright © 2016年 申倩倩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"

@interface CatalogProductView : UIView
{
    Product *theProduct;
}

- (void)setProduct:(Product *)inputProduct;

@end
