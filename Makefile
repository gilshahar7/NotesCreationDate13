SHARED_CFLAGS = -fobjc-arc
ARCHS = arm64 arm64e

# Uncomment before release to remove build number
PACKAGE_VERSION = $(THEOS_PACKAGE_BASE_VERSION)

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = NotesCreationDate13
NotesCreationDate13_FILES = Tweak.xm
NotesCreationDate13_FRAMEWORKS = UIKit, CoreGraphics

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 MobileNotes"
