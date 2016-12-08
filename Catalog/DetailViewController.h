//
//  DetailViewController.h
//  Catalog
//
//  Created by 申倩倩 on 16/11/27.
//  Copyright © 2016年 申倩倩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel* nameLable;
@property (strong, nonatomic) IBOutlet UILabel* manufacturerLable;
@property (strong, nonatomic) IBOutlet UILabel* detailsLable;
@property (strong, nonatomic) IBOutlet UILabel* priceLable;
@property (strong, nonatomic) IBOutlet UILabel* quantityLable;
@property (strong, nonatomic) IBOutlet UILabel* countryLable;

//@property (strong, nonatomic) IBOutlet UILabel* detailDescriptionLable;
@property (strong, nonatomic) id detailItem;

@end

