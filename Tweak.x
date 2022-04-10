
@interface PlaylistViewController : NSObject
- (void)downloadWithURL:(id)arg1 filename:(id)arg2;
@end

@interface Config : NSObject
+ (_Bool)isDevMode;
@end

%hook NSURL
- (_Bool)canDownload {
	if ([self.scheme hasPrefix:@"web+"]) {
		return YES;
	}
	return %orig;
}
%end

%hook WebBrowserViewControllerV2

- (void)showMenuWithURL:(id)arg1 canDownload:(_Bool)arg2 suggestedFilename:(id)arg3 {
	return %orig(arg1, YES, arg3);
}

- (void)showMenuWithURL:(id)arg1 canDownload:(_Bool)arg2 {
	return %orig(arg1, YES);
}

%end

%ctor {
    %init;
}