//
//  CatalogProductView.m
//  Catalog
//
//  Created by 申倩倩 on 16/11/30.
//  Copyright © 2016年 申倩倩. All rights reserved.
//

#import "CatalogProductView.h"

@implementation CatalogProductView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.opaque = YES;//设置为不透明的，使用透明视图会导致严重的性能下降
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setProduct:(Product *)inputProduct
{
    if (theProduct != inputProduct) {
        theProduct = inputProduct;
    }
    //视图需要重画
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    [theProduct.name drawAtPoint:CGPointMake(45.0, 0.0)
                        forWidth:120
                        withFont:[UIFont systemFontOfSize:18.0]
                     minFontSize:12.0
                  actualFontSize:NULL
                   lineBreakMode:UILineBreakModeTailTruncation
              baselineAdjustment:UIBaselineAdjustmentAlignBaselines];
    //设置绘制颜色
    [[UIColor darkGrayColor] set];
    
    [theProduct.manufacturer drawAtPoint:CGPointMake(45.0, 25.0)
                        forWidth:120
                        withFont:[UIFont systemFontOfSize:12.0]
                     minFontSize:12.0
                  actualFontSize:NULL
                   lineBreakMode:UILineBreakModeTailTruncation
              baselineAdjustment:UIBaselineAdjustmentAlignBaselines];
    
    [[UIColor blackColor] set];
    
    [[[NSNumber numberWithFloat:theProduct.price] stringValue] drawAtPoint:CGPointMake(200.0, 10.0)
                        forWidth:60
                        withFont:[UIFont systemFontOfSize:16.0]
                     minFontSize:10.0
                  actualFontSize:NULL
                   lineBreakMode:UILineBreakModeTailTruncation
              baselineAdjustment:UIBaselineAdjustmentAlignBaselines];
    
    //画image
    NSString *path = [[NSBundle mainBundle] pathForResource:theProduct.countryOfOrigin ofType:@".png"];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    [image drawInRect:CGRectMake(0.0, 0.0, 40.0, 40.0)];
    
    path = [[NSBundle mainBundle] pathForResource:theProduct.image ofType:@".png"];
    image = [UIImage imageWithContentsOfFile:path];
    [image drawInRect:CGRectMake(260.0, 10.0, 20.0, 20.0 )];
}




@end
