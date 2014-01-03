#include <stdlib.h>
#import <objc/runtime.h>

@interface SpringBoard
-(void)turnSSHOn:(BOOL)arg1;
@end

%hook SpringBoard
%new -(void)turnSSHOn:(BOOL)arg1{
	if(arg1)
		system("chmod 777 /Library/LaunchDaemons/com.openssh.sshd.plist; launchctl load -w /Library/LaunchDaemons/com.openssh.sshd.plist");
	else
		system("chmod 777 /Library/LaunchDaemons/com.openssh.sshd.plist; launchctl unload -w /Library/LaunchDaemons/com.openssh.sshd.plist");

}
%end