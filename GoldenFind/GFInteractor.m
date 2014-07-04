//
//  GFInteractor.m
//  GoldenFind
//
//  Created by Mohamed Mokhles Waly on 7/2/14.
//  Copyright (c) 2014 Mokhles. All rights reserved.
//

#import "GFInteractor.h"
#import "GFPlace.h"



@implementation GFInteractor

+ (NSArray*)loadPlacesOffline
{
    NSMutableArray* mutArray=[@[]mutableCopy];
   
    
    /**
    Retrieval OF Offline Data from file
     
    */
     
     
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"MockedData" ofType:@"json"];


    
    NSError* error;
    
    // JSON Array
     
     
    NSArray* jsonArray = (NSArray*)[NSJSONSerialization
                          JSONObjectWithData:[NSData dataWithContentsOfFile:filePath]
                          
                          options:kNilOptions
                          error:&error];
    
    // Parse the JSON array to app models
    
    for (NSDictionary* dict in jsonArray) {
        GFPlace *place=[[GFPlace alloc]initWithDictionary:dict];
        [mutArray addObject:place];
     
    }


    return @[mutArray];
}

@end
