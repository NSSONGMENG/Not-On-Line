//
//  Define.h
//  PotatoWarning
//
//  Created by songmeng on 15/3/31.
//  Copyright (c) 2015年 songmeng. All rights reserved.
//

#ifndef PotatoWarning_Define_h
#define PotatoWarning_Define_h




#pragma  mark  -----------------基本信息接口URL--------------------
#define kBasicInfoURL           @"http://218.70.37.104:7000/mobile/mobile.aspx?type=97&province=china"

#define kCurrentInfoURL         @"http://218.70.37.104:7000/mobile/mobile.aspx?type=113&datatime=null&user=null&pass=null&province=null&id="

#define kBightInfoURL          @"http://218.70.37.104:7000/mobile/mobile.aspx?type=141&datatime=null&user=null&pass=null&province=null&id="

#define kHistoryInfoURL         @"http://218.70.37.104:7000/mobile/mobile.aspx?type=129&user=null&pass=null&province=null&datatime="

#define kOtherInfoURL           @"http://218.70.37.104:7000/mobile/mobile.aspx?type=97&user=admin&pass=admin&province="

#pragma  mark  -------------------屏幕宽高------------------------
#define kWidth          self.view.frame.size.width
#define kHeight         self.view.frame.size.height
#define kScreenHeight   [UIScreen mainScreen ].applicationFrame.size.height
#define kScreenWidth    [UIScreen mainScreen ].applicationFrame.size.width

#pragma  mark  -------------------cell重用标识--------------------
#define kAddressListCell        @"addresslistcell"
#define kBasicInfoCell          @"basicinfocell"
#define kCurrentInfoCell        @"currentinfocell"
#define kHistoryInfoCell        @"historyinfocell"

#pragma  mark  -------------------虚线间隔--------------------
#define kDateWidth      25
#endif
