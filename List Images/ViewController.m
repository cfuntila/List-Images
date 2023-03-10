//
//  ViewController.m
//  List Images
//
//  Created by Charity Funtila on 2/14/23.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 99;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"imageCell"];
    
    NSString *rowString=[NSString stringWithFormat:@"%ld",indexPath.row + 1];
    int randomNumber = arc4random_uniform(4) + 1;
    NSLog(@"%u", randomNumber);
    NSString* imageNumber = [@(randomNumber) stringValue];

//    Choose between small (20kb) and large (>=10MB) images:
    
//        NSString *imageName = [NSString stringWithFormat:@"%@%@", @"small", imageNumber];
    NSString *imageName = [NSString stringWithFormat:@"%@%@", @"large", imageNumber];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^
                {
        NSURL *imageUrl = [[NSBundle mainBundle] URLForResource:imageName withExtension:@"jpg"];
        NSData *data = [NSData dataWithContentsOfURL:imageUrl];
        UIImage *image = [UIImage imageWithData:data];
        
        [image prepareForDisplayWithCompletionHandler:^(UIImage * _Nullable theImage) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if ( [[tableView indexPathsForVisibleRows] containsObject:indexPath]) {
                    UITableViewCell *currentCell = [tableView cellForRowAtIndexPath:indexPath];
                    currentCell.imageView.image = image;
                    [currentCell setNeedsLayout];
                }
            });
        }];
    });

    return cell;
}

@end
