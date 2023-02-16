//
//  ViewController.h
//  List Images
//
//  Created by Charity Funtila on 2/14/23.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate >

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

