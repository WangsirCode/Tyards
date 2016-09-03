//
//  FeedBackController.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/8.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "FeedBackController.h"
#import "MDABizManager.h"
#import "FeedBackViewModel.h"
@interface FeedBackController ()<UITextViewDelegate>
@property (strong,nonatomic)FeedBackViewModel* viewModel;
@property (nonatomic,strong)UIBarButtonItem* backItem;
@property (nonatomic,strong)UITextView* textField;
@property (nonatomic,strong)UILabel* label;
@property (nonatomic,strong)UIBarButtonItem* submiteItem;
@end
@implementation FeedBackController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.viewModel = [[FeedBackViewModel alloc] initWithDictionary: @{}];
    }
    return self;
}
#pragma mark- lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpView];
    [self bindModel];
    // Do any additional setup after loading the view.
}
#pragma mark- setupView

- (void)setUpView
{
    self.view.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        [self.textField resignFirstResponder];
    }];
    [self.view addGestureRecognizer:tap];
    [self addSubViews];
    [self makeConstraits];
}
- (void)addSubViews
{
    self.navigationItem.leftBarButtonItem = self.backItem;
    self.navigationItem.rightBarButtonItem = self.submiteItem;
    [self.view addSubview:self.textField];
    [self.view addSubview:self.label];
}
- (void)makeConstraits
{
    self.textField.sd_layout
    .topSpaceToView(self.view,10)
    .leftSpaceToView(self.view,10)
    .rightSpaceToView(self.view,10)
    .heightIs(218*self.view.scale);
    self.label.sd_layout
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .bottomSpaceToView(self.view,10)
    .heightIs(30);
}

- (void)bindModel
{
    self.navigationItem.title = @"设置";
    [[self.textField rac_textSignal] subscribeNext:^(id x) {
        self.viewModel.feedBack = self.textField.text;
    }];
    [[self.viewModel.submitCommand executionSignals] subscribeNext:^(id x) {
        [XHToast showCenterWithText:@"提交成功"];
    }];
}

#pragma mark- textViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"您的反馈将帮助我们更快成长"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text.length<1) {
        textView.text = @"您的反馈将帮助我们更快成长";
        textView.textColor = [UIColor colorWithHexString:@"#CACACA"];
    }
}
#pragma mark -viewModelSet

- (void)setRouterParameters:(NSDictionary *)routerParameters
{
    self.viewModel = [[FeedBackViewModel alloc] initWithDictionary: routerParameters];
}
#pragma  mark -Getter
-(UIBarButtonItem *)backItem
{
    if (!_backItem) {
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"返回icon"] forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 0, 25, 20);
        _backItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
    }
    return _backItem;
}
-(UITextView *)textField
{
    if (!_textField) {
        _textField = [[UITextView alloc] init];
        _textField.text = @"您的反馈将帮助我们更快成长";
        _textField.textColor = [UIColor colorWithHexString:@"#CACACA"];
        _textField.tintColor = [UIColor MyColor];
        _textField.layer.borderWidth = 1;
        _textField.delegate = self;
        _textField.font = [UIFont systemFontOfSize:16];
        _textField.layer.borderColor = [UIColor colorWithHexString:@"#CACACA"].CGColor;
    }
    return _textField;
}
-(UIBarButtonItem *)submiteItem
{
    if (!_submiteItem) {
        _submiteItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:nil action:nil];
        _submiteItem.rac_command = self.viewModel.submitCommand;
    }
    return _submiteItem;
}
- (UILabel *)label
{
    if (!_label) {
        _label = [UILabel new];
        _label.text = @"欢迎加入十二码用户QQ群 : 104790917";
        _label.textColor = [UIColor colorWithHexString:@"#CACACA"];
        _label.font = [UIFont systemFontOfSize:14];
        _label.textAlignment = NSTextAlignmentCenter;
    }
    return _label;
}
@end
