//
//  CYPModelDocument.m
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 14/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import "CYPModelDocument.h"

@implementation CYPModelDocument

+ (CYPModelDocument *)createModelDocument {
    CYPModelDocument *modelDocument;
    
    NSURL *modelUrl = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CYPModel.model"];
    modelDocument = [[CYPModelDocument alloc] initWithFileURL:modelUrl];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:[modelUrl path]]) {
        [modelDocument openWithCompletionHandler:^(BOOL success) {
            if (!success) {
                //ERROR
            }
        }];
    } else {
        [modelDocument saveToURL:modelUrl forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
            if (!success) {
                //ERROR
            }
        }];
    }
    
    return modelDocument;
}

+ (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
