//
//  MHStudentManager.h
//  STChoice
//
//  Created by AloesLu on 16/5/3.
//  Copyright © 2016年 AloesLu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MHStudent,MHWish;
@interface MHStudentManager : NSObject
+ (instancetype)sharedManager;

- (void)setStudentData:(MHStudent *)student;
- (MHStudent *)getStudentData;

- (void)addStudentWish:(MHWish *)wish;
- (void)setkUserDefaults_student_wish_arry:(NSMutableArray *)student_wish_arry;
- (NSMutableArray *)getkUserDefaults_student_wish_arry;

- (void)setkUserDefaults_isSubmitWish:(NSNumber *)isSubmitWish;
- (NSNumber *)getkUserDefaults_isSubmitWish;

- (void)setkUserDefaults_addhasSelectTeacher:(NSString *)teaId;
- (BOOL)getkUserDefaultsAndjudgeSelectTeaId:(NSString *)teaId;
@end
