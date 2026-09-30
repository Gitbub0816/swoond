# Swoon'd iOS: common tasks. Requires macOS + Xcode for everything except `core-test`.
SCHEME      ?= Swoond
DESTINATION ?= platform=iOS Simulator,name=iPhone 16

.PHONY: help project open build test core-test clean

help:
	@echo "make project    generate Swoond.xcodeproj with XcodeGen (brew install xcodegen)"
	@echo "make open       generate and open in Xcode"
	@echo "make build      xcodebuild build for the simulator"
	@echo "make test       run SwoondTests on the simulator"
	@echo "make core-test  run SwoondCore tests (works on Linux and macOS)"

project:
	xcodegen generate

open: project
	open Swoond.xcodeproj

build: project
	xcodebuild -project Swoond.xcodeproj -scheme $(SCHEME) -destination '$(DESTINATION)' build

test: project
	xcodebuild -project Swoond.xcodeproj -scheme $(SCHEME) -destination '$(DESTINATION)' test

core-test:
	cd SwoondCore && swift test

clean:
	rm -rf Swoond.xcodeproj build DerivedData SwoondCore/.build
