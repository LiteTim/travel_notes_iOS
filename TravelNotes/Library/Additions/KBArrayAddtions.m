//
//  KBArrayAddtions.h
//
//  Created by Tmoson on 2017/12/20.
//  Copyright © 2017年 xunmei. All rights reserved.
//

#import "KBArrayAddtions.h"

@implementation NSArray (KBArrayAddtions)

- (id)objectAtIndexSafe:(NSUInteger)index {
    if (index < self.count) {
        return self[index];
    }
    return nil;
}

@end
