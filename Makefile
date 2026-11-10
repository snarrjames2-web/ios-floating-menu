TARGET := iphone:clang:latest:14.0
ARCHS := arm64

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = FloatingInputMenu
FloatingInputMenu_FILES = Tweak.x
FloatingInputMenu_FRAMEWORKS = UIKit QuartzCore

include $(THEOS)/makefiles/tweak.mk
