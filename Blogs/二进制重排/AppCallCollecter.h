//
//  AppCallCollecter.h
//  FCPublicOpinionSystem
//
//  Created by wang wanli on 2020/9/11.
//  Copyright © 2020 ChangtanSun. All rights reserved.
//

#import <Foundation/Foundation.h>

//! Project version number for AppCallCollecter.
FOUNDATION_EXPORT double AppCallCollecterVersionNumber;

//! Project version string for AppCallCollecter.
FOUNDATION_EXPORT const unsigned char AppCallCollecterVersionString[];


/// 与CLRAppOrderFile只能二者用其一
extern NSArray <NSString *> *getAppCalls(void);


/// 与getAppCalls只能二者用其一
extern void appOrderFile(void(^completion)(NSString* orderFilePath));

// In this header, you should import all the public headers of your framework using statements like #import <AppCallCollecter/PublicHeader.h>

