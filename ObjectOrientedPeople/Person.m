//
//  Person.m
//  ObjectOrientedPeople
//
//  Created by Gan Chau on 5/20/15.
//  Copyright (c) 2015 al-tyus.com. All rights reserved.
//

#import "Person.h"

@implementation Person

- (instancetype)init
{
    return [self initWithName:@""];
}

//designated initializer
- (instancetype)initWithName:(NSString *)name
{
    self = [super init];
    
    if (self) {
        _name = name;
        _height = @9;
    }
    
    return self;
}

#define ARC4RANDOM_MAX 0x100000000
- (CGFloat)randomFloatBetweenNumber:(CGFloat)minRange
                          andNumber:(CGFloat)maxRange
{
    return ((float)arc4random() / ARC4RANDOM_MAX) * (maxRange - minRange) + minRange;
}

- (NSNumber *)grow
{
    CGFloat currentHeight = [self.height floatValue];
    CGFloat inchesToGrow = 0.0;
    
    if (self.isFemale) {
        if ([self.age integerValue] < 11) {
            inchesToGrow = [self randomFloatBetweenNumber:0.0 andNumber:1.0];
        } else if ([self.age integerValue] >= 11 && [self.age integerValue] <= 15) {
            inchesToGrow = [self randomFloatBetweenNumber:0.5 andNumber:2.0];
        }
    } else {
        if ([self.age integerValue] < 12) {
            inchesToGrow = [self randomFloatBetweenNumber:0.0 andNumber:1.0];
        } else if ([self.age integerValue] >= 12 && [self.age integerValue] <= 16) {
            inchesToGrow = [self randomFloatBetweenNumber:0.5 andNumber:3.5];
        }
    }
    return @(currentHeight + inchesToGrow);
}

- (void)addFriends:(NSArray *)friends
{
    self.friends = [friends mutableCopy];
}

- (NSString *)generatePartyList
{
    NSString *list;   //store list in a string
    for (Person *friend in self.friends) {  //iterate through array of friends
        if (!list) {                        //if list is empty
            list = friend.name;             //put first friend's name on the list
        } else {                            //else if list is not empty
            list = [list stringByAppendingFormat:@", %@", friend.name];   //append friend's name to existing list
        }
    }
    return list;   //return complete list
}

- (BOOL)removeFriend:(Person *)friend
{
    NSMutableArray *friends = self.friends;   //store array of friends
    for (Person *person in friends) {         //iterate through the array of friend
        if ([person isEqual:friend]) {        //if current friend matches friend to be removed
            [self.friends removeObject:person];    //remove friend from array of friends
            return YES;                            //return YES
        }
    }    
    return NO;    //if no friend found to be removed, return NO
}

- (NSArray *)removeFriends:(NSArray *)friends
{
    NSMutableArray *friendsToRemove = [@[] mutableCopy];  //store array of friends to be removed
    for (Person *friend in friends) {                     //iterate through the array of friends
        if ([self.friends containsObject:friend]) {       //if friend exists in current array of friends
            [friendsToRemove addObject:friend];           //add friend to array to be removed
            [self.friends removeObject:friend];           //remove friend from current array of friends
        }
    }
    return [friendsToRemove copy];   //return array of friends to be removed
}

@end
