//
//  Person.h
//  ObjectOrientedPeople
//
//  Created by Gan Chau on 5/20/15.
//  Copyright (c) 2015 al-tyus.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (strong, nonatomic) NSNumber *height;
@property (strong, nonatomic) NSNumber *age;
@property (strong, nonatomic) NSString *name;
@property (nonatomic) BOOL isFemale;
@property (strong, nonatomic) NSMutableArray *friends;

//designated initializer
- (instancetype)initWithName:(NSString *)name;

- (NSNumber *)grow;
- (void)addFriends:(NSArray *)friends;
- (NSString *)generatePartyList;
- (BOOL)removeFriend:(Person *)friend;
- (NSArray *)removeFriends:(NSArray *)friends;

@end
