//
//  MHUserManager.h
//  vomoho
//
//  Created by AloesLu on 15/11/21.
//  Copyright © 2015年 AloesLu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MHUser;

@interface MHUserManager : NSObject

+ (instancetype)sharedManager;

- (void)setUserData:(MHUser *)user;
- (MHUser *)getUserData;
- (BOOL)isMHUserLogin;
- (void)clearUserData;
/**
 *  获取userID set和get方法
 */
- (void)setkUserDefaults_userId:(NSString *)userId;
-(NSString *)getkUserDefaults_userId;
/**
 *  获取openAccountId set和get方法
 */
- (void)setkUserDefaults_openAccountId:(NSString *)openAccountId;
- (NSString *)getkUserDefaults_openAccountId;
/**
 *  获取picList set和get方法
 */
- (void)setkUserDefaults_picList:(NSMutableArray *)picList;
- (NSMutableArray *)getkUserDefaults_picList;
/**
 *  获取avatar set和get方法
 */
- (void)setkUserDefaults_Avatar:(NSString *)avatar;
- (NSString *)getkUserDefaults_Avatar;
/**
 *  获取nick set和get方法
 */
- (void)setkUserDefaults_Nick:(NSString *)nick;
- (NSString *)getkUserDefaults_Nick;
/**
 *  获取username set和get方法
 */
- (void)setkUserDefaults_Username:(NSString *)username;
- (NSString *)getkUserDefaults_Username;
/**
 *  获取gender set和get方法
 */
- (void)setkUserDefaults_Gender:(NSNumber *)gender;
- (NSNumber *)getkUserDefaults_Gender;
/**
 *  获取motto set和get方法
 */
- (void)setkUserDefaults_Motto:(NSString *)motto;
- (NSString *)getkUserDefaults_Motto;
/**
 *  获取marriageStat set和get方法
 */
- (void)setkUserDefaults_marriageStat:(NSNumber *)marriageStat;
- (NSNumber *)getkUserDefaults_marriageStat;
/**
 *  获取tagMap set和get方法
 */
- (void)setkUserDefaults_tagMap:(NSMutableArray *)tagMap;
- (NSMutableArray *)getkUserDefaults_tagMap;
/**
 *  获取position set和get方法
 */
- (void)setkUserDefaults_position:(NSString *)position;
- (NSString *)getkUserDefaults_position;
/**
 *  获取positionNo set和get方法
 */
- (void)setkUserDefaults_positionNo:(NSString *)positionNo;
- (NSString *)getkUserDefaults_positionNo;
/**
 *  获取age set和get方法
 */
- (void)setkUserDefaults_age:(NSNumber *)age;
- (NSNumber *)getkUserDefaults_age;
/**
 *  获取constellation set和get方法
 */
- (void)setkUserDefaults_constellation:(NSString *)constellation;
- (NSString *)getkUserDefaults_constellation;
/**
 *  获取relation set和get方法
 */
- (void)setkUserDefaults_relation:(NSString *)relation;
- (NSString *)getkUserDefaults_relation;
/**
 *  获取relationStat set和get方法
 */
- (void)setkUserDefaults_relationStat:(NSNumber *)relationStat;
- (NSNumber *)getkUserDefaults_relationStat;
/**
 *  获取registerTime set和get方法
 */
- (void)setkUserDefaults_RegTime:(NSString *)registerTime;
- (NSString *)getkUserDefaults_RegTime;
/**
 *  获取registerTime set和get方法
 */
- (void)setkUserDefaults_Phone:(NSString *)phone;
- (NSString *)getkUserDefaults_Phone;
/**
 *  获取backgroundPicture set和get方法
 */
- (void)setkUserDefaults_backgroundPicture:(NSString *)backgroundPicture;
- (NSString *)getkUserDefaults_backgroundPicture;
/**
 *  获取birthday set和get方法
 */
- (void)setkUserDefaults_birthday:(NSString *)birthday;
- (NSString *)getkUserDefaults_birthday;
/**
 *  获取dynamicPictures set和get方法
 */
- (void)setkUserDefaults_dynamicPictures:(NSMutableArray *)dynamicPictures;
- (NSMutableArray *)getkUserDefaults_dynamicPictures;
/**
 *  获取userToken set和get方法
 */
- (void)setkUserDefaults_userToken:(NSString *)userToken;
- (NSString *)getkUserDefaults_userToken;
/**
 *  获取myRecommendFriend set和get方法
 */
- (void)setkUserDefaults_myRecommendFriend:(NSMutableArray *)myRecommendFriend;
- (NSMutableArray *)getkUserDefaults_myRecommendFriend;

/**
 *  获取isBundingContacts set和get方法
 */
- (void)setkUserDefaults_isBundingContacts:(NSString *)isBundingContacts;
- (NSString *)getkUserDefaults_isBundingContacts;
/**
 *  获取tabbarSelectIndex set和get方法
 */
- (void)setkUserDefaults_tabbarSelectIndex:(NSNumber *)tabbarSelectIndex;
- (NSString *)getkUserDefaults_tabbarSelectIndex;
/**
 *  获取imagesCaheSize set和get方法
 */
- (void)setkUserDefaults_imagesCaheSize:(NSString *)imagesCaheSize;
- (NSString *)getkUserDefaults_imagesCaheSize;
/**
 *  获取isRegisterNow set和get方法
 */
- (void)setkUserDefaults_lastLoginTime:(NSString *)lastLoginTime;
- (NSString *)getkUserDefaults_lastLoginTime;

/**
 *  获取userHistoryCity set和get方法
 */
- (void)setkUserDefaults_userHistoryCity:(NSMutableArray *)userHistoryCity;
- (NSMutableArray *)getkUserDefaults_userHistoryCity;
- (void)add_userHistoryCity:(NSDictionary *)dict;
/*
 *  获取IsAlterLocationSelect set和get方法
 */
- (void)setkIsAlterLocationSelect:(NSString *)IsAlterLocationSelect;
- (NSString *)getkIsAlterLocationSelect;
/*
 *  获取userMessagePraise set和get方法
 */
- (void)setkUserDefaults_userMessagePraise:(NSNumber *)userMessagePraise;
- (NSNumber *)getkUserDefaults_userMessagePraise;
/*
 *  获取userMessageReply set和get方法
 */
- (void)setkUserDefaults_userMessageReply:(NSNumber *)userMessageReply;
- (NSNumber *)getkUserDefaults_userMessageReply;
@end
