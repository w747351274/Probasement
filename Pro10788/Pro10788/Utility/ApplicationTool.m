//
//  ApplicationTool.m
//  Pro10788
//
//  Created by WangJiangLei on 19/5/14.
//  Copyright (c) 2014 江磊. All rights reserved.
//

#import "ApplicationTool.h"

@implementation ApplicationTool
+(void)pushLocalNotification:(NSString*)alertBody user:(NSDictionary*)userInfo{
    
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    
    // Get the current date
    NSDate *pickerDate = [NSDate new];
    
    // Break the date up into components
    NSDateComponents *dateComponents = [calendar components:( NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit )
                                                   fromDate:pickerDate];
    NSDateComponents *timeComponents = [calendar components:( NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit )
                                                   fromDate:pickerDate];
    
    // Set up the fire time
    NSDateComponents *dateComps = [[NSDateComponents alloc] init];
    [dateComps setDay:[dateComponents day]];
    [dateComps setMonth:[dateComponents month]];
    [dateComps setYear:[dateComponents year]];
    [dateComps setHour:[timeComponents hour]];
    // Notification will fire in one minute
    [dateComps setMinute:[timeComponents minute]];
    [dateComps setSecond:[timeComponents second]];
    NSDate *itemDate = [calendar dateFromComponents:dateComps];
    
    
    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
    if (localNotif == nil)
        return;
    localNotif.fireDate = itemDate;
    localNotif.timeZone = [NSTimeZone defaultTimeZone];
    
    
    localNotif.alertBody =alertBody;// [txtfield_MyPills text];//[eventText text];
    // Set the action button
    localNotif.alertAction =NSLocalizedString(@"完成",nil);

    localNotif.soundName = UILocalNotificationDefaultSoundName;
//    localNotif.applicationIconBadgeNumber = 1;
    
    // Specify custom data for the notification
    
    
    NSDictionary *infoDict = userInfo;
    localNotif.userInfo = infoDict;
    
    // Schedule the notification
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
}
@end
