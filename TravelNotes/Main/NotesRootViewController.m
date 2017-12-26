 //
//  NotesRootViewController.m
//  TravelNotes
//
//  Created by Tmoson on 2017/12/20.
//  Copyright © 2017年 xunmei. All rights reserved.
//

#import "NotesRootViewController.h"
#import "TNMineViewController.h"

@interface NotesRootViewController ()

@end

@implementation NotesRootViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    UIViewController *mainVC = [[UIViewController alloc] init];
    mainVC.view.backgroundColor = KBRandomColor;
    [self addOneChildVc:mainVC title:NSLocalizedString(@"String_NotesRoot_Main", nil) imageName:@"" selectedImageName:@""];

    UIViewController *notesVC = [[UIViewController alloc] init];
    notesVC.view.backgroundColor = KBRandomColor;
    [self addOneChildVc:notesVC title:NSLocalizedString(@"String_NotesRoot_Notes", nil) imageName:@"" selectedImageName:@""];

    TNMineViewController *mineVC = [[TNMineViewController alloc] init];
    mineVC.view.backgroundColor = RGBColor(233, 233, 233);
    [self addOneChildVc:mineVC title:NSLocalizedString(@"String_NotesRoot_Mine", nil) imageName:@"" selectedImageName:@""];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:HEXCOLOR(0x797979)}
                                             forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:CommonColor_SkyBlue}
                                             forState:UIControlStateSelected];
}

/**
 *  添加一个控制器
 *
 *  @param childVc           子控制器，viewVc类型，能支持自定义控制器
 *  @param title             title
 *  @param imageName         图标icon
 *  @param selectedImageName 选中状态图标icon
 */
- (void)addOneChildVc:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    if (IOS_8_UP) {
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    childVc.tabBarItem.selectedImage = selectedImage;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
}

@end
