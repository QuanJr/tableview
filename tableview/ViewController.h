//
//  ViewController.h
//  tableview
//
//  Created by QuanKul on 5/11/16.
//  Copyright © 2016 QuanKul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, strong)NSArray * fruits;

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property NSDictionary *alphabetizedFruits;

@end

