//
//  ColorHeader.h
//  PingPangApp
//
//  Created by jing on 17/5/24.
//  Copyright © 2017年 jing. All rights reserved.
//

#ifndef ColorHeader_h
#define ColorHeader_h

#define PCH_CUSTUM_COLOR(y) [UIColor colorWithRed:((float)((y  & 0xFF0000) >> 16))/255.0 green:((float)((y  & 0xFF00) >> 8))/255.0 blue:((float)(y  & 0xFF))/255.0 alpha:1.0]  //custumcolor输入对应的色值

#define PCH_CUSTOM_BLUE_COLOR PCH_CUSTUM_COLOR(0x15B0C9)
#endif /* ColorHeader_h */
