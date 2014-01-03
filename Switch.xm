#import "FSSwitchDataSource.h"
#import "FSSwitchPanel.h"

static BOOL isDisabled;

@interface FlipSSHSwitch : NSObject <FSSwitchDataSource>
@end

@implementation FlipSSHSwitch

-(FSSwitchState)stateForSwitchIdentifier:(NSString *)switchIdentifier{
	return isDisabled?FSSwitchStateOff:FSSwitchStateOn;
}

-(void)applyState:(FSSwitchState)newState forSwitchIdentifier:(NSString *)switchIdentifier{
	if(newState == FSSwitchStateIndeterminate)
		return;

	else if(newState == FSSwitchStateOn){
		isDisabled = NO;

		//Won't work due to "Dubious permissions", need to find either a process
		//that already runs as su or create a LaunchDaemon and use IPC
		system("chmod 777 /Library/LaunchDaemons/com.openssh.sshd.plist; launchctl load -w /Library/LaunchDaemons/com.openssh.sshd.plist");
	}

	else if(newState == FSSwitchStateOff){
		isDisabled = YES;
		system("chmod 777 /Library/LaunchDaemons/com.openssh.sshd.plist; launchctl unload -w /Library/LaunchDaemons/com.openssh.sshd.plist");
	}
}

@end

/* As ProtoSphere once said:
	You will probably have to have a daemon running as root and do some ipc or hook an existing process that runs as root (not sure if this is a good idea?)
*/