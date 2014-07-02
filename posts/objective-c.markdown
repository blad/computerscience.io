---
title: Scratching the Surface of Objective-C
subtitle: Starting Out with Objective-C
date: 2014-07-02
icon: apple
---
## Part \#1: Basic Syntax

Logging:
````Objective-C
NSLog(@"Hello World");
NSLog(@"Echo:@a", @"the Value")   // Logs: "Echo the Value"
NSLog(@"%@ %@ %@ %@", @"One", @"Two", @"Three", @"Four")   // Logs: "One Two Three Four"
````

Variables:

````Objective-C
NSString * str = @"My String Literal";
NSNumber * num = @3;

NSArray * arr = @[@"String", @"String2", @"String3"];
NSLog(@"->%@<-", arr[0]); // Logs: "->String<-"

NSDictionary * dic = @{@"Key1": @1, @"Key2": @2};
NSLog(@"->%@<-", arr[@"Key1"]); // Logs: "1"
````

`NSArray` and `NSDictionary` are immutable types, so values can not be assigned via subscript syntax.


## Part \#2: Message Passing
Objective-C uses the concept of "sending messages", and this is described by the
`[object messageName]` syntax. The first item in the square brackets is the
object reference, and the parameters after are the message names.

Built in types in Objective-C like, NSString, NSNumber, and NSArray have many
messages that they can receive by default. `description` is a build in message
that these objects recognize, so we can send this message and get a `NSString`
representation of the object. This is synonymous to `toString` in Java.

````Objective-C
NSArray * arr = @[@"Value 1", @"Value 2"];
NSLog(@"%@", [arr description]);
````
Displays:
````shell
arr: (
  Value 1
  Value 2
)
````


Doing some Basic Math:
````
NSNumber * num1 = @3; //Objective-C Object
NSNumber * num2 = @3; //Objective-C Object
// Invalid: num1 * num2, we must extract values.

NSUInteger numA = [num1 unsignedIntegerValue];
NSUInteger numB = [num2 unsignedIntegerValue];
NSUInteger val = numA * numB;
NSLog(@"%lu", val); // Note the %lu, not the %@
````

String Concatenation:
````Objective-C
NSString * str1 = @"My Name";
NSString * str2 = @" is Blad.";
NSString * all = [str1 stringByAppendingString:str2];
// The method below constructs a new string.
NSString * all2 = [NSString stringWithFormat:@"%@%@", str1, str2]

````

**Nested Messages & Multiple Messages**

Messages can be nested.
````Objective-C
NSString * str1 = @"My Name";
NSString * str2 = @" is Blad.";
NSString * all = [[[str1 stringByAppendingString:str2]
                        stringByAppendingString:str1]
                        stringByAppendingString:str2];
// all -> "My Name is Blad. My name is Blad."
````

````Objective-C
NSString * str1 = @"My Name";
NSString * str2 = @" is Blad.";
NSString * all = [str1 stringByReplacingOccurrencesOfString:@"My"
                       withString:@"Your"]
````

## Creating Objects
all classes in Objective-C can recieve the `alloc` message, which
is used to allocate memory for the object. `init` is then passed
in order to initialize the object.

`init` is equivalent to an empty constructor and generally generates
and empty object, but there are generally equivalent `init` methods that
help to set up objects with passed in parameters.
````
NSString * emptyString = [[NSString alloc] init];
NSArray * emptyArray = [[NSArray alloc] init];
NSDictionary * emptyDic = [[NSDictionary alloc] init];
````

# Part \#3: Control Flow

`if`-`else if`-`else`, and `switch` statements are same as Java, and C language.
## Enumerations
````
BOOL => {YES, NO}
typedef NS_ENUM(NSInteger, DayOfWeek) {
    DayOfWeekMonday = 1,
    DayOfWeekTuesday = 2,
    DayOfWeekWednesday = 3,
    DayOfWeekThursday = 4,
    DayOfWeekFriday = 5,
    DayOfWeekSaturday = 6,
    DayOfWeekSunday = 7
};
````

## Fast Enumeration
````
NSArray *funnyWords = @[@"Schadenfreude", @"Portmanteau", @"Penultimate"];

for (NSString *word in funnyWords) {
  NSLog(@"%@ is a funny word", word);
}

NSDictionary *funnyWords = @{
  @"Schadenfreude": @"pleasure derived by someone from another person's misfortune.",
  @"Portmanteau": @"consisting of or combining two or more separable aspects or qualities",
  @"Penultimate": @"second to the last"
};

for (NSString *word in funnyWords){
  NSString *definition = funnyWords[word];
  NSLog(@"%@ is defined as %@", word, definition);
}
````

## Code Blocks
````
^{ // Create a block.
  NSLog(@"Hello from inside the block");
};

void (^logMessage)(void) =  ^{ // assign to a variable
  NSLog(@"Hello from inside the block");
};

// Invoked:
logMessage()

// Blocks that accept arguments:
void (^sumNumbers)(NSUInteger, NSUInteger) = ^(NSUInteger num1, NSUInteger num2){
  NSLog(@"The sum of the numbers is %lu", num1 + num2);
};
````


# Part \#4: Classes

````
// MyCustomClass.h
@interface MyCustomClass : NSObject <NSCopying> {
  NSNumber * _instVar1;
}
// Properties can be used via object notatoin like java
// Properties have message name auto created.
@property NSString * prop1;
@property NSString * prop2;

-(void) method1;
@end
````

````
// MyCustomClass.m
@implementation MyCustomClass

- (id) copyWithZone:(NSZone *) zone;
{
	id cp = [[MyCustomClass allocWithZone:zone] init];
  [cp setProp1:@"Value"]; // dot-notation not allowed with `id` types.
  return cp;
}
@end
````
