@ECHO OFF
CLS
ECHO ============
ECHO 1.generate translations
ECHO 2.run build runner with delete conflicting
ECHO 3.flutter pub get
ECHO 4.flutter clean
ECHO 5.enable web
ECHO 6.no-enable web
ECHO.

CHOICE /C 123456 /M "Enter your choice:  " 

IF ERRORLEVEL 6 GOTO fvm_flutter_no_enable_web
IF ERRORLEVEL 5 GOTO fvm_flutter_enable_web
IF ERRORLEVEL 4 GOTO fvm_flutter_clean
IF ERRORLEVEL 3 GOTO fvm_flutter_pub_get
IF ERRORLEVEL 2 GOTO run_build_runner_with_delete_conflicting
IF ERRORLEVEL 1 GOTO generate

:generate
ECHO ============
get generate locales assets/locales
GOTO End

:run_build_runner_with_delete_conflicting
ECHO ============
flutter pub run build_runner build --delete-conflicting-outputs
GOTO End

:fvm_flutter_pub_get
ECHO ============
flutter pub get
GOTO End

:fvm_flutter_clean
ECHO ============
 flutter clean
GOTO End

:fvm_flutter_enable_web
ECHO ============
 flutter config --enable-web
GOTO End

:fvm_flutter_no_enable_web
ECHO ============
 flutter config --no-enable-web
GOTO End

:End