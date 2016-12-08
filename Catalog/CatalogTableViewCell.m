//
//  CatalogTableViewCell.m
//  Catalog
//
//  Created by 申倩倩 on 16/11/30.
//  Copyright © 2016年 申倩倩. All rights reserved.
//

#import "CatalogTableViewCell.h"

@implementation CatalogTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGRect viewFrame = CGRectMake(0.0, 0.0, self.contentView.bounds.size.width, self.contentView.bounds.size.height);
        self.catalogProductView = [[CatalogProductView alloc] initWithFrame:viewFrame];
        
        [self.contentView addSubview:self.catalogProductView];
    }
    return self;
}

- (void) setProduct:(Product *)theProduct
{
    [self.catalogProductView setProduct:theProduct];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
