#include <RemoteLog.h>


@interface ICNoteEditorViewController : UIViewController
- (void)updateDateLabel;
@end

%hook ICNoteEditorViewController

- (void)viewDidLayoutSubviews {
	%orig;
	[self updateDateLabel];
}

- (void)viewDidAppear:(BOOL)animated {
	%orig;
	[self updateDateLabel];
}

%new
- (void)updateDateLabel {
	id note = [self valueForKey:@"note"];

	//NSDateFormatter *dateFormatter = (NSDateFormatter *)[self valueForKey:@"dateFormatter"];

	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setLocale:[NSLocale currentLocale]];
	//[dateFormatter setDateStyle:NSDateFormatterLongStyle];
	//[dateFormatter setTimeStyle:NSDateFormatterShortStyle];
	[dateFormatter setDateFormat:@"MMMM d, yyyy - h:mm a"];
	//NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
	NSDate *creationDate;
	NSDate *modificationDate;
	UILabel * dateLabel;
	id textView;
	@try {
		creationDate 	 = (NSDate *)[note valueForKey:@"creationDate"];
		modificationDate = (NSDate *)[note valueForKey:@"modificationDate"];
		textView = [self valueForKey:@"textView"];
		dateLabel = [(UIView *)[textView valueForKey:@"dateView"] valueForKey:@"label"];
	}
@catch (NSException  * e) {
	 RLog(@"catching %@ reason %@", [e name], [e reason]);
}
	NSString *creationDateString 	 = [dateFormatter stringFromDate:creationDate];
	NSString *modificationDateString = [dateFormatter stringFromDate:modificationDate];

	NSString *lineOne  = [NSString stringWithFormat:@"Created: %@", creationDateString];
	NSString *lineTwo  = [NSString stringWithFormat:@"Modified: %@", modificationDateString];
	NSString *fullText = [NSString stringWithFormat:@"%@\n%@", lineOne, lineTwo];



	[dateLabel setNumberOfLines:0];
	[dateLabel setText:fullText];
}

%end

%hook ICTextView

- (double)dateLabelOverscroll {
	double r = %orig;
	return r * 2;
}

%end
