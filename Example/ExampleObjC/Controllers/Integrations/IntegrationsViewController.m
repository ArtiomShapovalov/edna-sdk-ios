//
//  IntegrationsViewController.m
//  ThreadsDemoObjc
//
//  Created by Vitaliy Kuzmenko on 25/07/2019.
//  Copyright © 2019 Threads. All rights reserved.
//

#import "IntegrationsViewController.h"
#import <Threads/Threads.h>
#import "MainViewController.h"
#import "AttributesHelper.h"
#import "ChatInTabNavigationController.h"

@interface IntegrationsViewController () <IntegrationsProtocol>

@property (nonatomic, strong) UISegmentedControl *segmentedControl;

@property (nonatomic, assign) Design design;

@end

@implementation IntegrationsViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.design = DesignDefault;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.segmentedControl.selectedSegmentIndex = self.design;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    MainViewController* tb = (MainViewController *)self.tabBarController;
    [tb updateUnreadMessagesCountBadgeValue];
}

- (THRAttributes *)getAttributes {
    switch (self.design) {
        case DesignDefault:
            return [AttributesHelper getDefaultAttributes];
        case DesignAlternative:
            return [AttributesHelper getAltAttributes];
    }
}

- (UIViewController *)getChatViewController {
    THRAttributes *attributes = [self getAttributes];
    UIViewController *chatViewController = [[Threads threads] chatViewControllerWithAttributes:attributes];
    return chatViewController;
}


#pragma mark - Push Integrations

/**
 In this method you can se how to implement simple Chat push to current navigation controller
 */
- (void)pushChatInCurrentNavigationController {
    UIViewController *chatViewController = [self getChatViewController];
    [self.navigationController pushViewController:chatViewController animated:YES];
}

/**
 In this method you can se how to implement simple Chat push to current navigation controller with hiding tabBar.
 Like set Storyboard Parameter: (Hide Bottom Bar on Push) = YES
 */
- (void)pushChatInCurrentNavigationControllerWithHidingTabBar {
    UIViewController *chatViewController = [self getChatViewController];
    chatViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:chatViewController animated:YES];
}

#pragma mark - Present Integrations


/**
 In this method you can see how to implement presenting Chat in UINavigationController as rootViewController
 */
- (void)presentChatInUINavigationController {
    UIViewController *chatViewController = [self getChatViewController];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:chatViewController];
    nc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:nc animated:YES completion:nil];
}

/**
 In this method you can see how to implement presenting Chat as tab in UITabBarController from code
 */
- (void)presentChatUINavigationControllerAsTabInTabBarControllerInitializatedFromCode {
    UIViewController *chatViewController = [self getChatViewController];
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:chatViewController];
    nc.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"Chat", "") image:[UIImage imageNamed:@"tabBarItemChat"] tag:0];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[nc];
    tabBarController.modalPresentationStyle = UIModalPresentationFullScreen;
    
    [self presentViewController:tabBarController animated:YES completion:nil];
}

/**
 In this method you can see how to implement presenting Chat as tab in UITabBarController from storyboard
 See:
 - ChatInTabNavigationController
 - Main.storyboard ("Shared" Group)
 */
- (void)presentChatUINavigationControllerAsTabInTabBarControllerInitializatedFromStoryboard {
    [self performSegueWithIdentifier:@"ChatTabBarControllerSegueIdentifier" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier  isEqual: @"ChatTabBarControllerSegueIdentifier"]) {
        UITabBarController *tabController = (UITabBarController*) segue.destinationViewController;
        ChatInTabNavigationController *chatInTabVC = (ChatInTabNavigationController*) tabController.viewControllers[0];
        chatInTabVC.design = self.design;
    }
}

- (void)presentFromPushWithDesign:(NSInteger)desgin {
    if (self.navigationController.viewControllers.count > 1 || self.navigationController.presentedViewController != nil) { return; }
    self.design = desgin;
    UIViewController *chatViewController = [self getChatViewController];
    self.navigationController.viewControllers = @[self.navigationController.viewControllers[0], chatViewController];
}

- (IBAction)designDidChange {
    self.design = self.segmentedControl.selectedSegmentIndex;
}

@end
