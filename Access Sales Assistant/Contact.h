#import "_Contact.h"

@interface Contact : _Contact {}
// Custom logic goes here.
- (PhoneListItem *)mobilePhoneInManagedObjectContext:(NSManagedObjectContext *)context;

@end
