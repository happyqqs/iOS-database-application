//
//  MasterViewController.h
//  Catalog
//
//  Created by 申倩倩 on 16/11/27.
//  Copyright © 2016年 申倩倩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"
#import "DBAcess.h"
#import "CatalogTableViewCell.h"


@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;
@property (strong, nonatomic) NSMutableArray *products;
@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) UISearchDisplayController *searchController;
@property (retain, nonatomic) NSArray *filteredProducts;

@end

