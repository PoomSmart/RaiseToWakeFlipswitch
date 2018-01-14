PACKAGE_VERSION = 0.0.1
TARGET = iphone:clang:latest:10.0

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = RaiseToWake
RaiseToWake_FILES = Switch.xm
RaiseToWake_LIBRARIES = flipswitch
RaiseToWake_FRAMEWORKS = UIKit
RaiseToWake_INSTALL_PATH = /Library/Switches

include $(THEOS_MAKE_PATH)/bundle.mk
