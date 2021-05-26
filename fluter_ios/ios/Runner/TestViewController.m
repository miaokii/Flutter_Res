//
//  TestViewController.m
//  Runner
//
//  Created by Miaokii on 2021/5/26.
//

#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.redColor;
    
    UILabel *label = [[UILabel alloc] init];
    label.text = self.dic.description;
    label.textColor = UIColor.blackColor;
    label.numberOfLines = 0;
    label.frame = CGRectMake(0, 0, self.view.frame.size.width, 100)
    [self.view addSubview:label];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
