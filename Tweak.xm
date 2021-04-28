#include <Foundation/Foundation.h>
#include <UIKit/UIKit.h>
#include <HBLog.h>


@interface SBSApplicationShortcutItem : NSObject <NSCopying>
@property (nonatomic,copy) NSString * type;
@property (nonatomic,copy) NSString * localizedTitle;
@property (nonatomic,copy) NSString * localizedSubtitle;
@property (nonatomic,copy) NSString * bundleIdentifierToLaunch;
@property (assign,nonatomic) unsigned long long activationMode;
@end

%hook SBIconView
-(void)setApplicationShortcutItems:(NSArray <SBSApplicationShortcutItem *>*)items{
    
    NSIndexSet *indices = [items indexesOfObjectsWithOptions:NSEnumerationConcurrent passingTest:^(SBSApplicationShortcutItem *item, NSUInteger idx, BOOL *stop) {
        HBLogDebug(@"TYPE: %@", item.type);
        return !([item.type isEqualToString:@"com.apple.springboardhome.application-shortcut-item.rearrange-icons"] || [item.type isEqualToString:@"com.apple.springboardhome.application-shortcut-item.share"] || [item.type isEqualToString:@"com.apple.springboardhome.application-shortcut-item.delete-app"] || [item.type isEqualToString:@"com.apple.springboardhome.application-shortcut-item.remove-app"]);
    }];
    NSArray *sanitizedItems = [items objectsAtIndexes:indices];
    %orig(sanitizedItems);
}

%end
