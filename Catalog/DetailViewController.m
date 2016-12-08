//
//  DetailViewController.m
//  Catalog
//
//  Created by 申倩倩 on 16/11/27.
//  Copyright © 2016年 申倩倩. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Details", @"Details");
    }
    return self;
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        Product *theProduct = (Product*) self.detailItem;
        [self.nameLable setText:theProduct.name];
        [self.manufacturerLable setText:theProduct.manufacturer];
        [self.detailsLable setText:theProduct.details];
        [self.priceLable setText:[NSString stringWithFormat:@"%.2f", theProduct.price]];
        [self.quantityLable setText:[NSString stringWithFormat:@"%d", theProduct.quantity]];
        [self.countryLable setText:theProduct.countryOfOrigin];
       // NSLog(@"%@", theProduct);
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}


@end
