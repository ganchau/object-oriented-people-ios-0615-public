//
//  ObjectOrientedPeopleTests.m
//  ObjectOrientedPeopleTests
//
//  Created by Al Tyus on 6/6/14.
//  Copyright (c) 2014 al-tyus.com. All rights reserved.
//

#import "Specta.h"
#define EXP_SHORTHAND
#import <Expecta.h>
#import "AppDelegate.h"
#import "Person.h"

SpecBegin(Person)

describe(@"Person", ^{
    
    __block Person *joe;
    __block Person *jessica;
  
    
    beforeAll(^{
        joe = [[Person alloc] init];
        jessica = [[Person alloc] init];
    });
    
    beforeEach(^{
        
    });
    
    describe(@"initializers", ^{
        it(@"should initalize height to @9 and name should be an empty string", ^{
            joe = [[Person alloc] init];
            expect(joe.height).to.equal(@9);
            expect(joe.name).to.equal(@"");
        });

        it(@"should have an initalizer called initWithName:", ^{
            expect(joe).to.respondTo(@selector(initWithName:));
        });

        it(@"should initialize with name passed in and height at @9", ^{
            Person *chris = [[Person alloc] initWithName:@("Chris")];
            expect(chris.name).to.equal(@"Chris");
            expect(chris.height).to.equal(@9);
        });
    });
    
    describe(@"grow", ^{
        
        beforeEach(^{
            
            joe.height = @60;
            joe.name = @"Joe";
            joe.isFemale = NO;
            
            jessica.height = @32;
            jessica.name = @"Jessica";
            jessica.isFemale = YES;
            
        });
        it(@"should grow a random amount between 0 and 1 inch if person is a girl less than 11 years old ", ^{
            jessica.age = @10;
            NSNumber *jessicaHeight =[jessica grow];
            
            CGFloat newHeight = [jessicaHeight floatValue];
            expect(jessica.height).toNot.beNil();
            //expect(newHeight >= 32 && newHeight <= 33).to.beTruthy();
            expect(newHeight).to.beInTheRangeOf(32, 33);
            
        });
        it(@"should grow a random amount between .5 and 2 inches if person is a girl 11 or older and 15 or younger ", ^{
            
            jessica.age = @11;
            NSNumber *jessicaHeight =[jessica grow];
            
            CGFloat newHeight = [jessicaHeight floatValue];
//            expect(newHeight >= 32.5 && newHeight <= 34);
            expect(newHeight).to.beInTheRangeOf(32.5, 34);
        
        });
        it(@"should grow 0 inches if person is a girl older than 15 ", ^{
            jessica.age = @16;
            NSNumber *jessicaHeight =[jessica grow];
            
            CGFloat newHeight = [jessicaHeight floatValue];
            expect(newHeight).to.equal(32);
        });
        
        it(@"should grow a random amount between 0 and 1 inch if person is a boy less than 12 years old", ^{
            joe.age = @11;
            NSNumber *joeHeight = [joe grow];
            
            CGFloat newHeight = [joeHeight floatValue];
            expect(newHeight).to.beInTheRangeOf(60, 61);
            
        });
        it(@"should grow a random amount between .5 and 3.5 inches if person is a boy 12 years or older and 16 years or younger", ^{
            joe.age = @12;
            NSNumber *joeHeight = [joe grow];
            
            CGFloat newHeight = [joeHeight floatValue];
            expect(newHeight).to.beInTheRangeOf(60.5, 63.5);
            
        });
        it(@"should grow 0 inches if person is a boy older than 16 ", ^{
            joe.age = @25;
            NSNumber *joeHeight = [joe grow];
            
            CGFloat newHeight = [joeHeight floatValue];
            expect(joe.height).toNot.beNil();
            expect(newHeight).to.equal(60);
        });
        
    });
    
    describe(@"addFriends", ^{
        __block Person *eric, *chris, *al, *avi, *adam; //shorthand way to declare mutliple vars inline
        __block NSArray *friends;
        
        beforeEach(^{
            eric = [[Person alloc] init];
            eric.friends = [[NSMutableArray alloc] init];
            
            chris = [[Person alloc] init];
            al = [[Person alloc] init];
            avi = [[Person alloc] init];
            adam = [[Person alloc] init];
            
             friends = @[chris, al, avi, adam];
        });
        
        it(@"should add an array of Person friends to a Person's friends array", ^{
            expect(eric.friends).toNot.beNil();
            expect([eric.friends count]).to.equal(0);
            
            [eric addFriends: friends];
            expect([eric.friends count]).to.equal(4);
        });
        
        it(@"should add Person objects to friends array", ^{
            [eric addFriends:friends];
            expect([eric.friends count]).to.equal(4);
            
            expect([eric.friends containsObject:chris]).to.beTruthy();
            expect([eric.friends containsObject:al]).to.beTruthy();
            expect([eric.friends containsObject:avi]).to.beTruthy();
            expect([eric.friends containsObject:adam]).to.beTruthy();

            for (Person *friend in joe.friends)
            {
                expect(friend).to.beKindOf([Person class]);
            }
        });
    });
    
    describe(@"generatePartyList", ^{
        __block Person *eric, *chris, *al, *avi, *adam; //shorthand way to declare mutliple vars inline
        __block NSArray *friends;
        __block NSString *partyList;
        
        beforeEach(^{
            eric = [[Person alloc] init];
            chris = [[Person alloc] init];
            al = [[Person alloc] init];
            avi = [[Person alloc] init];
            adam = [[Person alloc] init];
            
            eric.name = @"eric";
            chris.name = @"chris";
            al.name = @"al";
            avi.name = @"avi";
            adam.name = @"adam"; 
            
            friends = @[chris, al, avi, adam];
            eric.friends = [NSMutableArray arrayWithArray:friends];
            partyList = [eric generatePartyList];
        });
        
        it(@"should return a string", ^{
            expect(partyList).to.beKindOf([NSString class]);
            expect(partyList).toNot.beNil();
        });
        it(@"should print a list of friends seperated by commas", ^{
            expect(partyList).to.equal(@"chris, al, avi, adam");
        });
        
    });
    
    describe(@"removeFriend", ^{
        __block Person *eric, *chris, *al, *avi, *adam, *james; //shorthand way to declare mutliple vars inline
        __block NSArray *friends;

        beforeEach(^{
            eric = [[Person alloc] init];
            chris = [[Person alloc] init];
            al = [[Person alloc] init];
            avi = [[Person alloc] init];
            adam = [[Person alloc] init];
            james = [[Person alloc] init];
            
            friends = @[chris, al, avi, adam];
            eric.friends = [NSMutableArray arrayWithArray:friends];
        });
        
        it(@"Should return YES if the friend was found and removed", ^{
            expect([eric removeFriend:chris]).to.beTruthy();
            expect([eric removeFriend:al]).to.beTruthy();
            expect([eric removeFriend:avi]).to.beTruthy();
            expect([eric removeFriend:adam]).to.beTruthy();
        });
        it(@"Should return NO if the friend was not found and not removed", ^{
            expect([eric removeFriend:james]).to.beFalsy();
        });
        it(@"Should remove a found friend from the friends array", ^{
            [eric removeFriend:al];
            expect([eric.friends containsObject:al]).to.beFalsy();
        });
    });
    
    describe(@"removeFriends", ^{
        __block Person *eric, *chris, *al, *avi, *adam, *james; //shorthand way to declare mutliple vars inline
        __block NSArray *friends, *friendsToRemove;
        
        beforeEach(^{
            eric = [[Person alloc] init];
            chris = [[Person alloc] init];
            al = [[Person alloc] init];
            avi = [[Person alloc] init];
            adam = [[Person alloc] init];
            james = [[Person alloc] init];
            
            friends = @[chris, al, avi, adam];
            friendsToRemove = @[al, avi];
            
            eric.friends = [NSMutableArray arrayWithArray:friends];
        });
        
        it(@"should return an array of removed friends", ^{
            expect([eric removeFriends:friendsToRemove]).to.equal(friendsToRemove);
        });
        
        it(@"should remove found friends from friends array", ^{
            [eric removeFriends:friendsToRemove];
            expect([eric.friends count]).to.equal(2);
            expect([eric.friends containsObject:al]).to.beFalsy();
            expect([eric.friends containsObject:avi]).to.beFalsy();
            expect([eric.friends containsObject:chris]).to.beTruthy();
            expect([eric.friends containsObject:adam]).to.beTruthy(); 
        });
        
    });
    
    
    
});


SpecEnd
