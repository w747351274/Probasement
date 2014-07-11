//
//  M3Service.h
//  Pro10788
//
//  Created by WangJiangLei on 20/2/14.
//  Copyright (c) 2014 江磊. All rights reserved.
//


@protocol m3Protocal <BaseProtocal>

-(void)haveFun;
-(void)dataReceived:(NSDictionary *)dict;
@end

@interface M3Service : BaseService
@property(nonatomic,assign)id<m3Protocal> delegate;
-(void)makeHappy;
-(void)loadData;
-(void)loadDataWithProgress:(id)progressDelegate;
@end
