//
//  GSDetailViewController.h
//  demoCoreDataController
//
//  Created by Glebus on 01.04.13.
//  Copyright (c) 2013 Domus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GSDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
