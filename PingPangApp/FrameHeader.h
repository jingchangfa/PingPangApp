//
//  FrameHeader.h
//  PingPangApp
//
//  Created by jing on 17/5/24.
//  Copyright © 2017年 jing. All rights reserved.
//

#ifndef FrameHeader_h
#define FrameHeader_h

#define PCH_SCREEN_HEIGHT  ([UIScreen mainScreen].bounds.size.height)
#define PCH_SCREEN_WIDTH   ([UIScreen mainScreen].bounds.size.width)

#define PCH_SIZE_SCREEN_HEIGHT    (PCH_SCREEN_HEIGHT/667)
#define PCH_SIZE_SCREEN_WIDTH     (PCH_SCREEN_WIDTH/375)

//像素为单位的 不需要自己除以2
#define PCH_BitMap_BY_SIZE(height) (((height)/2)*PCH_SIZE_SCREEN_WIDTH)

#endif /* FrameHeader_h */
