//
//  MainController.m
//  Runner
//
//  Created by Miaokii on 2021/5/26.
//

#import "MainController.h"
#import "GeneratedPluginRegistrant.h"
#import "TestViewController.h"

#define flutterMethodChannel @"flutter_native_iOS"
#define pushFlutterMethod @"flutter_push_to_iOS"
#define presentFlutterMethod @"flutter_present_to_iOS"

@interface MainController ()

@property (nonatomic, strong) FlutterMethodChannel * methodChannel;

@end

@implementation MainController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self methodChannelFunction];
}

- (void)methodChannelFunction {
    self.methodChannel = [FlutterMethodChannel methodChannelWithName:flutterMethodChannel binaryMessenger:self];
    
    __weak typeof(self) weakSelf = self;
    [self.methodChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        __strong typeof(weakSelf) self = weakSelf;
        NSString * method = call.method;
        id param = call.arguments;
        if ([method isEqualToString:pushFlutterMethod]) {
            TestViewController * vc = [[TestViewController alloc] init];
            vc.dic = param;
            [self.navigationController pushViewController:vc animated:true];
            
            result(@"push返回到flutter");
        } else if ([method isEqualToString:presentFlutterMethod]) {
            TestViewController * vc = [[TestViewController alloc] init];
            vc.dic = param;
            [self presentViewController:vc animated:YES completion:nil];
            result(@"present返回到flutter");
        }
    }];
    [GeneratedPluginRegistrant registerWithRegistry:self];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

@end
