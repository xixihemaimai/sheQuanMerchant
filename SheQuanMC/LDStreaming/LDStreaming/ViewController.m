//
//  ViewController.m
//  LDStreaming
//
//  Created by 千亦 on 2021/7/13.
//

#import "ViewController.h"

#import <LDStreaming/LDStreaming.h>

#import <LDMessage/UserFriendInfoReq.pbobjc.h>

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableview;
@property (nonatomic,strong)NSArray *dataArry;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initView];
}


- (void)initData {
    self.dataArry = @[
        @{@"title": @"Ping", @"action": @"testPing"},
        @{@"title": @"UserFriendReq", @"action": @"testUserFriendReq"},
    ];
}

- (void)initView {
    _tableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableview.dataSource = self;
    _tableview.delegate = self;
    [self.view addSubview:_tableview];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArry.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellID"];
    }
    cell.textLabel.text = self.dataArry[indexPath.row][@"title"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSString *action = self.dataArry[indexPath.row][@"action"];
    SEL sel = NSSelectorFromString(action);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self performSelector:sel];
#pragma clang diagnostic pop
}

#pragma mark - events

- (void)testPing {
    
}

- (void)testUserFriendReq {
    UserFriendReq *req = [UserFriendReq new];
    req.friendUserId = 12;
    
    [LDClient sendMessageWithEvent:30 msgType:@"UserFriendReq" body:req.data response:^(BOOL isSuccess, NSData *data, NSError *error) {
        
    }];
}
@end
