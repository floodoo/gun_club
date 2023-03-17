# Gun Club
[![Clean code](https://github.com/floodoo/gun_club/actions/workflows/clean-code.yml/badge.svg)](https://github.com/floodoo/gun_club/actions/workflows/clean-code.yml)

## Setup And Run Project
**Required** flutter version: `^3.7.7`

### With Makefile
1. git clone project
2. make clean
3. make run-web
4. [http://localhost:3000](http://localhost:3000) aufrufen

### Without Makefile
1. git clone
2. flutter clean
3. flutter pub get
4. flutter pub run build_runner build --delete-conflicting-outputs
5. flutter run -d web-server --web-hostname localhost --web-port 3000
6. [http://localhost:3000](http://localhost:3000) aufrufen

## Used Dependencies

### Dependencies
- [flutter_riverpod: ^2.0.2](https://pub.dev/packages/flutter_riverpod) # State Management
- [go_router: ^5.0.5](https://pub.dev/packages/go_router) # Navigation
- [supabase_flutter: ^1.0.0-dev.9](https://pub.dev/packages/supabase_flutter) # PostgreSQL as backend
- [device_info_plus: ^6.0.0](https://pub.dev/packages/device_info_plus) # Device information
- [package_info_plus: ^2.0.0](https://pub.dev/packages/package_info_plus) # App version and build number

### Dev Dependencies
- [build_runner: ^2.3.0](https://pub.dev/packages/build_runner) # Generate code
- [freezed: ^2.1.1](https://pub.dev/packages/freezed)
- [freezed_annotation: ^2.1.0](https://pub.dev/packages/freezed_annotation)
- [json_annotation: ^4.7.0](https://pub.dev/packages/json_annotation)
- [json_serializable: ^6.5.1](https://pub.dev/packages/json_serializable)
- [flutter_launcher_icons: ^0.10.0](https://pub.dev/packages/flutter_launcher_icons) # generate icons for android and ios with config file