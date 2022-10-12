# Gun club
[![Clean code](https://github.com/floodoo/gun_club/actions/workflows/clean-code.yml/badge.svg)](https://github.com/floodoo/gun_club/actions/workflows/clean-code.yml)

## Setup and run project
**Required** flutter version: `^3.3.4`
### With make file
1. git clone project
2. make clean
3. make run-web
4. [http://localhost:3000](http://localhost:3000) aufrufen

### Without make file
1. git clone
2. flutter clean
3. flutter pub get
4. flutter pub run build_runner build --delete-conflicting-outputs
5. flutter run -d web-server --web-hostname localhost --web-port 3000
6. [http://localhost:3000](http://localhost:3000) aufrufen
