THEOS_PACKAGE_DIR_NAME = debs
TARGET =: clang
ARCHS = armv7 arm64

BUNDLE_NAME = FlipSSH
FlipSSH_FILES = Switch.xm FSSHSpringBoard.xm
FlipSSH_FRAMEWORKS = UIKit Foundation
FlipSSH_LIBRARIES = flipswitch
FlipSSH_INSTALL_PATH = /Library/Switches

include theos/makefiles/common.mk
include $(THEOS_MAKE_PATH)/bundle.mk
include $(THEOS_MAKE_PATH)/library.mk

internal-after-install::
	install.exec "killall -9 backboardd"