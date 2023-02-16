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

//    Choose between small (20kb) and large (>=10MB) images
//        NSString *imageName = [NSString stringWithFormat:@"%@%@", @"small", imageNumber];
    NSString *imageName = [NSString stringWithFormat:@"%@%@", @"large", imageNumber];

//    create custom thread vs use one of gcd's existing background threads 
    //    dispatch_queue_t loadQueue = dispatch_queue_create("image loader", NULL);
    
//    dispatch_async(loadQueue, ^{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
                {
        NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:imageName withExtension:@"jpg"];
        
        NSData *data = [NSData dataWithContentsOfURL:fileUrl];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [UIImage imageWithData:data];
            cell.imageView.image = image;
        });
    });

    return cell;
    
}

@end
