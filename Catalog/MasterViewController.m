//
//  MasterViewController.m
//  Catalog
//
//  Created by 申倩倩 on 16/11/27.
//  Copyright © 2016年 申倩倩. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"


#define NAMELABEL_TAG 1
#define MANUFACTURERLABEL_TAG 2
#define PRICELABEL_TAG 3
#define PRODUCTIMAGE_TAG 4
#define FLAGIMAGE_TAG 5

@interface MasterViewController ()

@end

@implementation MasterViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Catalog", @"Catalog");
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.products = [NSMutableArray arrayWithCapacity:1];
    
    NSMutableArray *productsTemp;
    
    
    DBAcess *dbAccess = [[DBAcess alloc] init];
    //self.products = [dbAccess getAllProducts];
    //从数据库中获取products数组
    productsTemp = [dbAccess getAllProducts];
    
    //NSLog(@"一共%lu个商品", (unsigned long)[self.products count]);
    
    [dbAccess closeDatabase];
    
    UILocalizedIndexedCollation *indexcollation = [UILocalizedIndexedCollation currentCollation];
    
    for (Product *product in productsTemp) {
        NSInteger section = [indexcollation sectionForObject:product
                                     collationStringSelector:@selector(name)];
        product.section = section;
    }
    
    
    NSInteger sectionCount = [[indexcollation sectionTitles] count];
    NSLog(@"%ld", (long)sectionCount);
    
    NSMutableArray *sectionsArray = [NSMutableArray arrayWithCapacity:sectionCount];
    for (int i = 0; i < sectionCount; i++) {
        NSMutableArray *singleSectionArray = [NSMutableArray arrayWithCapacity:1];
        [sectionsArray addObject:singleSectionArray];
    }
    for (Product *product in productsTemp) {
        [(NSMutableArray*)[sectionsArray objectAtIndex:product.section] addObject:product];
    }
    
    for (NSMutableArray *singleSectionArray in sectionsArray) {
        NSArray *sortedArray = [indexcollation sortedArrayFromArray:singleSectionArray
                                            collationStringSelector:@selector(name)];
        [self.products addObject:sortedArray];
    }
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 44.0f)];
    self.tableView.tableHeaderView = self.searchBar;

    self.searchController = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar
                                                              contentsController:self];
    self.searchController.searchResultsDataSource = self;
    self.searchController.searchResultsDelegate = self;
    //self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}



//在导航控制器顶部设置Catalog文本


- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Segues

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.tableView) {
        return [self.products count];
    }
    return 1;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
        return [[self.products objectAtIndex:section] count];
    }
    //将Products扁平化为单一数组然后用NSPredicate来过滤
    NSMutableArray *flattenedArray = [[NSMutableArray alloc] initWithCapacity:1];
    for (NSMutableArray *theArray in self.products) {
        for (int i = 0; i < [theArray count]; i++) {
            [flattenedArray addObject:[theArray objectAtIndex:i]];
        }
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name beginswith[c] %@", self.searchBar.text];
    self.filteredProducts = [flattenedArray filteredArrayUsingPredicate:predicate];
    
    return self.filteredProducts.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    CatalogTableViewCell *cell = (CatalogTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[CatalogTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (tableView == self.tableView) {
        Product *product = [[self.products objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row]];
        [cell setProduct:product];
        return cell;
    }
    Product *product = [self.filteredProducts objectAtIndex:[indexPath row]];
    [cell setProduct:product];
    return cell;
    /*
    //添加子视图
    UILabel *nameLabel, *manufacturerLabel, *priceLabel;
    UIImageView *productImage, *flagImage;
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(45.0, 0.0, 120.0, 25.0)];
        nameLabel.tag = NAMELABEL_TAG;
        [cell.contentView addSubview:nameLabel];
        
        manufacturerLabel = [[UILabel alloc] initWithFrame:CGRectMake(45.0, 25.0, 120.0, 25.0)];
        manufacturerLabel.tag = MANUFACTURERLABEL_TAG;
        manufacturerLabel.font = [UIFont systemFontOfSize:12.0];
        manufacturerLabel.textColor = [UIColor darkGrayColor];
        [cell.contentView addSubview:manufacturerLabel];
        
        priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(200.0, 10.0, 60.0, 25.0)];
        priceLabel.tag = PRICELABEL_TAG;
        [cell.contentView addSubview:priceLabel];
        
        productImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40.0, 40.0)];
        productImage.tag = PRODUCTIMAGE_TAG;
        [cell.contentView addSubview:productImage];
        
        flagImage = [[UIImageView alloc] initWithFrame:CGRectMake(260.0, 10.0, 20.0, 20.0)];
        flagImage.tag = FLAGIMAGE_TAG;
        [cell.contentView addSubview:flagImage];
    } else {
        nameLabel = (UILabel*)[cell.contentView viewWithTag:NAMELABEL_TAG];
        manufacturerLabel = (UILabel*)[cell.contentView viewWithTag:MANUFACTURERLABEL_TAG];
        priceLabel = (UILabel*)[cell.contentView viewWithTag:PRICELABEL_TAG];
        productImage = (UIImageView*)[cell.contentView viewWithTag:PRODUCTIMAGE_TAG];
        flagImage = (UIImageView*)[cell.contentView viewWithTag:FLAGIMAGE_TAG];
    }
    Product *product = [self.products objectAtIndex:[indexPath row]];
    
    nameLabel.text = product.name;
    manufacturerLabel.text = product.manufacturer;
    priceLabel.text = [[NSNumber numberWithFloat:product.price] stringValue];
    
    //从应用包中查找图像
    NSString *path = [[NSBundle mainBundle] pathForResource:product.image ofType:@".png"];
    UIImage *image = [UIImage imageWithContentsOfFile:path];//类方法，从文件获取图像
    productImage.image = image;
    
    path = [[NSBundle mainBundle] pathForResource:product.countryOfOrigin ofType:@".png"];
    image = [UIImage imageWithContentsOfFile:path];
    flagImage.image = image;
   // cell.imageView.image = image;
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//配件

    */
    
    //cell.textLabel.text = product.name;
    //cell.detailTextLabel.text = product.manufacturer;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if ([[self.products objectAtIndex:section] count] > 0) {
        return [[[UILocalizedIndexedCollation currentCollation] sectionTitles] objectAtIndex:section];
    }
    return nil;
}

- (NSInteger) tableView:(UITableView*)tableView sectionForSectionIndexTitle:(nonnull NSString *)title atIndex:(NSInteger)index
{
    return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index];
}

-(NSArray *)sectionIndexTitlesForTableView: (UITableView *)tableView
{
    //为普通表返回索引，为过滤表返回nil
    if (tableView == self.tableView) {
        return [[UILocalizedIndexedCollation currentCollation] sectionTitles];
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Product *product;
    if (tableView == self.tableView) {
        product = [[self.products objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row]];
    } else {
        product = [self.filteredProducts objectAtIndex:[indexPath row]];
    }
    if(!self.detailViewController) {
        self.detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    }
    self.detailViewController.detailItem = product;
    [self.navigationController pushViewController:self.detailViewController animated:YES];
}


@end
