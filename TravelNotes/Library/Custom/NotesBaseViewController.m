//
//  NotesBaseViewController.m
//  TravelNotes
//
//  Created by Tmoson on 2017/12/20.
//  Copyright © 2017年 xunmei. All rights reserved.
//

#import "NotesBaseViewController.h"


@interface NotesBaseViewController ()

@end

@implementation NotesBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.view.backgroundColor = CommonColor_Navi_Bg;

    _showCustomLeftBarButton = YES;
    self.titleColor = [UIColor whiteColor];
    self.barTintColor = CommonColor_Navi_Bg;

    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        NSArray *list=self.navigationController.navigationBar.subviews;
        for (id obj in list) {
            if ([obj isKindOfClass:[UIImageView class]]) {
                UIImageView *imageView=(UIImageView *)obj;
                NSArray *list2=imageView.subviews;
                for (id obj2 in list2) {
                    if ([obj2 isKindOfClass:[UIImageView class]]) {
                        UIImageView *imageView2=(UIImageView *)obj2;
                        imageView2.hidden=YES;
                    }
                }
            }
        }
    }

    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];

    self.automaticallyAdjustsScrollViewInsets = NO;
    self.parentViewController.automaticallyAdjustsScrollViewInsets = NO;

    self.originY = self.navigationController.navigationBar.bottom;
}
- (void)setShowCustomLeftBarButton:(BOOL)showCustomLeftBarButton
{
    _showCustomLeftBarButton = showCustomLeftBarButton;
    [self.navigationItem setLeftBarButtonItems:nil animated:NO];
    if (!_showCustomLeftBarButton) return;
    if (!_leftBarButtons) {
        UIView *leftView =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, 64, 44)];
        leftView.backgroundColor = [UIColor clearColor];

        UIImage *image = [UIImage  imageNamed:@"navigationbar_back"];
        UIImageView *imageView =  [[UIImageView alloc] initWithFrame:CGRectMake(0,(leftView.height-image.size.height)/2,image.size.width,image.size.height)];
        imageView.image = image;
        [leftView addSubview:imageView];

        //        UILabel *label =  [[UILabel alloc] initWithFrame:CGRectMake(image.right, 0, leftView.width-image.right, leftView.height)];
        //        label.backgroundColor = [UIColor clearColor];
        //        label.font = [UIFont boldSystemFontOfSize:14.f];
        //        label.textColor = HEXCOLOR(0xffffff);
        //        label.text = @"返回";
        //        [leftView addSubview:label];

        __weak typeof(self) weakSelf = self;
        [leftView kbHandleClick:^(UIView *view) {
            [weakSelf leftBarButtonAction];
        }];

        UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithCustomView:leftView];
        //fix
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.width = -10;

        _leftBarButtons = @[negativeSpacer,leftBtn];
    }
    [self.navigationItem setLeftBarButtonItems:_leftBarButtons animated:NO];
}

- (void)leftBarButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.showCustomLeftBarButton = self.showCustomLeftBarButton;
    //    [[UIApplication sharedApplication] setStatusBarStyle:self.statusBarStyle];
    if (!_isBarTintClearColor) {
        [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];

        self.navigationController.navigationBar.barTintColor = self.barTintColor;

    }else {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background"] forBarMetrics:UIBarMetricsDefault];

    }
    if (self.titleColor) {
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: self.titleColor,
                                                                          NSFontAttributeName :CommonFontAutoFix_(22.f)}];
    }

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}


- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
