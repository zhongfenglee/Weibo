//
//  HomeCellFrame.m
//  新浪微博
//
//  Created by 李中峰 on 16/4/16.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "HomeCellFrame.h"
#import "ZFConst.h"

@implementation HomeCellFrame

#pragma mark - 重写status的setter方法
// HomeVC中调用homeCellFrame.status = status;就会调用这个方法，将status传进来，设置cell上各控件的位置和尺寸
-(void)setStatus:(Status *)status
{
    // 调用父类(BaseStatusCellFrame)中的-setStatus:方法
//    super.status = status;
    [super setStatus:status];
    
    // objective-c成员变量有4个作用域：@public、@private、@protected、@package
    // @public：任何地方、任何类都可以直接访问某个类的成员变量；
    // @private：仅仅在当前类的@implementation中可直接访问。（子类不可以直接访问父类中的成员变量，但继承了父类中所有的成员变量和方法（但不允许子类和父类拥有相同名称的成员变量），若子类若想访问父类中@private定义的成员变量，只能使用self.xxx去访问；默认的是这个？
    // @protected：仅仅在当前类和其子类的@implementation中直接访问（当成员变量被写成｛
    // 成员变量;
    // ｝），子类才可以通过_xxx的方式去访问父类中该成员变量
    self.cellHeight += kOptionBarHeight;
}

@end
