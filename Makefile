run:
	flutter run

run-release:
	flutter run --release

run-web:
	flutter run -d web-server --web-hostname localhost --web-port 3000

run-web-release:
	flutter run --release -d web-server --web-hostname localhost --web-port 3000

format:
	dart format . --line-length 120 --set-exit-if-changed

format-fix:
	dart format . --line-length 120

lint:
	flutter analyze

test:
	flutter test
.PHONY: test

packages-outdated:
	flutter pub outdated

packages-upgrade:
	flutter pub upgrade

clean:
	flutter clean
	flutter pub get
	make build-runner

build-runner:
	flutter pub run build_runner build --delete-conflicting-outputs

build-runner-watch:
	flutter pub run build_runner watch --delete-conflicting-outputs

appicon-generate:
	flutter pub run flutter_launcher_icons:main -f flutter_launcher_icons.yaml

splashscreen-generate:
	flutter pub run flutter_native_splash:create

build-ios:
	@echo "Build iOS"
	make clean
	rm -rf ios/dist
	# flutter build ipa --tree-shake-icons --export-options-plist=ios/ios-export-options.plist --analyze-size --suppress-analytics
	flutter build ipa --obfuscate --split-debug-info=./dist/debug/ --tree-shake-icons --export-options-plist=ios/ios-export-options.plist --suppress-analytics
	cp build/ios/ipa/app.ipa dist/app.ipa

build-android-apk:
	@echo "Build APK's"
	make clean
	# flutter build apk --target-platform=android-arm64 --analyze-size
	flutter build apk --target-platform=android-arm,android-arm64 --obfuscate --split-debug-info=./dist/debug/
	cp build/app/outputs/apk/release/app-release.apk dist/
	mv dist/app-release.apk dist/app.apk

build-web:
	@echo "Build Web"
	make clean
	rm -rf dist/web
	flutter build web --release
	cp -r build/web dist/web

release-web:
	@echo "Release Web"
	make build-web
	vercel --prod

build-android-appbundle:
	@echo "Build Store App Bundle"
	make clean
	# flutter build appbundle --analyze-size
	flutter build appbundle --obfuscate --split-debug-info=./dist/debug/
	cp build/app/outputs/bundle/release/app-release.aab dist/
	mv dist/app-release.aab dist/app.aab