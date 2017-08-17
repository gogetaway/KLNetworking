//
//  JVersionInfoModel.h
//  J1000
//
//  Created by luming on 2017/2/8.
//  Copyright © 2017年 user. All rights reserved.
//

#import "BaseModel.h"

@interface JVersionInfoModel : BaseModel

/**
 - downloadUrl	string	最新包的 下载地址
 - versionName	string	最新包的 显示版本号名称
 - versionCode	int	最新包的 比较版本号，APP根据数字大小做版本比较
 - enumCode	int	数据字典的 最新版本号，APP根据数字大小跟本地json做比较
 - description	string	最新包的 版本更新说明，格式：\n分隔不同行
 - appSize	float	最新包的 大小，单位MB
 **/
@property (nonatomic,copy) NSString *downloadUrl;
@property (nonatomic,copy) NSString *versionName;
@property (nonatomic,assign) NSInteger versionCode;
@property (nonatomic,assign )NSInteger enumCode;
@property (nonatomic,copy) NSString *desc;

@property (nonatomic,assign) BOOL isOpen;


@end
