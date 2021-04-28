export ARCHS = arm64 arm64e
export DEBUG = 0
export FINALPACKAGE = 1

export PREFIX = $(THEOS)/toolchain/Xcode11.xctoolchain/usr/bin/

TARGET := iphone:clang:latest:7.0
INSTALL_TARGET_PROCESSES = SpringBoard


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = NoJunkQuickActions

NoJunkQuickActions_FILES = Tweak.xm
NoJunkQuickActions_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
