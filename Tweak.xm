#include <Foundation/Foundation.h>
#include <UIKit/UIKit.h>

@interface SBSApplicationShortcutItem : NSObject <NSCopying>
@property (nonatomic,copy) NSString * type;
@end

%hook SBIconView
-(void)setApplicationShortcutItems:(NSArray <SBSApplicationShortcutItem *>*)items{
    NSIndexSet *indices = [items indexesOfObjectsWithOptions:NSEnumerationConcurrent passingTest:^(SBSApplicationShortcutItem *item, NSUInteger idx, BOOL *stop) {
        return !([item.type isEqualToString:@"com.apple.springboardhome.application-shortcut-item.rearrange-icons"] || [item.type isEqualToString:@"com.apple.springboardhome.application-shortcut-item.share"] || [item.type isEqualToString:@"com.apple.springboardhome.application-shortcut-item.delete-app"] || [item.type isEqualToString:@"com.apple.springboardhome.application-shortcut-item.remove-app"]);
    }];
    NSArray *sanitizedItems = [items objectsAtIndexes:indices];
    %orig(sanitizedItems);
}
%end
