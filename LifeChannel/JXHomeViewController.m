//
//  JXHomeViewController.m
//  LifeChannel
//
//  Created by 白金星 on 15/12/2.
//  Copyright © 2015年 cn.bjx680. All rights reserved.
//

#import "JXHomeViewController.h"
#import "JXMainView.h"
@interface JXHomeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation JXHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"打印...");
     NSLog(@"打印...");

    self.tableview.backgroundColor = [UIColor brownColor];
//            [self localNotiication];
 
}
      //以下是本地通知
- (void)localNotiication{

    //注册通知类型   获取用户权限IOS6之后
//    UIMutableUserNotificationAction  *action  =[[UIMutableUserNotificationAction alloc]init];
//    action.identifier = @"Note";
//    action.title =@"外面很冷";
//
//    action.activationMode = UIUserNotificationActivationModeBackground;
//    action.destructive = NO;

    UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:nil];
    [[UIApplication sharedApplication]registerUserNotificationSettings:setting];


}

#pragma mark -本地通知事件

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //1.本地定制
    UILocalNotification *local = [[UILocalNotification alloc]init];
    //5秒之后
    local.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];

    local.alertBody = @"女神: 202";
    //是否显示锁屏的按钮
    local.hasAction = YES;
    local.alertAction = @"聊天111";

    local.soundName = UILocalNotificationDefaultSoundName;

    local.applicationIconBadgeNumber = 11;

    local.userInfo = @{@"name" : @"mingyuexin" , @"age" : @18 , @"height" : @1.8};

    //定制未来某个时刻 发出本地推送
    [[UIApplication sharedApplication]scheduleLocalNotification:local];
    //02.自动在特定的时间展示


    //携带参数 (传递数据)
    //分类 nil
    //解析数据   ,   接收通知的时候需要解析  , 接收通知 (点击横幅, 前台什么都不管 时间到了

}
#pragma mark -UITableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    return 3;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 400;

    }else {

        return 300;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return KUIScreenHeight - 130;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KUIScreenWidth, 300)];
    if (section == 0 ) {
        //collectionView
        NSString *filePath = [[NSBundle mainBundle]pathForResource:@"ImageList.plist" ofType:nil];
        NSArray *imgData = [NSArray arrayWithContentsOfFile:filePath];
        NSArray *imageNames = @[@"btnTop8_1",@"btnTop8_2",@"btnTop8_3",@"btnTop8_4",@"btnTop8_5",@"btnTop8_6",@"btnTop8_7",@"btnTop8_8"];
         NSArray *titles = @[@"景点门票",@"出境游",@"国内游",@"天天特价",@"西安周边游",@"度假酒店",@"景加酒",@"自驾游"];
        JXMainView  *mainView = [[JXMainView alloc]initWithFrame:CGRectMake(0, 350, KUIScreenWidth, 150) titles:titles imageData:imgData imageNames:imageNames];
        mainView.backgroundColor = [UIColor whiteColor];
        [view addSubview:mainView];


    }
 return view;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
