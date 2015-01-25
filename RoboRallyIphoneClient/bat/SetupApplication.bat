:user_configuration

:: About AIR application packaging
:: http://livedocs.adobe.com/flex/3/html/help.html?content=CommandLineTools_5.html#1035959
:: http://livedocs.adobe.com/flex/3/html/distributing_apps_4.html#1037515

:: NOTICE: all paths are relative to project root

:: Android packaging
set AND_CERT_NAME="RoboRallyClient"
set AND_CERT_PASS=fd
set AND_CERT_FILE=cert\iphone_dev.p12
set AND_ICONS=icons/android

set AND_SIGNING_OPTIONS=-storetype pkcs12 -keystore "%AND_CERT_FILE%" -storepass %AND_CERT_PASS%

:: iOS packaging
set IOS_DIST_CERT_FILE=ios_development.cer
set IOS_DEV_CERT_FILE=cert\iphoneRobo_dev.p12
set IOS_DEV_CERT_PASS=client
set IOS_PROVISION=cert\RoboRallyClient.mobileprovision
set IOS_ICONS=icons/ios

set IOS_DEV_SIGNING_OPTIONS=-storetype pkcs12 -keystore "%IOS_DEV_CERT_FILE%" -storepass %IOS_DEV_CERT_PASS% -provisioning-profile %IOS_PROVISION%
set IOS_DIST_SIGNING_OPTIONS=-storetype pkcs12 -keystore "%IOS_DIST_CERT_FILE%" -provisioning-profile %IOS_PROVISION%

:: Application descriptor
set APP_XML=application.xml
set APP_XML2=application2.xml
set APP_XML3=application3.xml
set APP_XML4=application4.xml
set APP_XML5=application5.xml
set APP_XML6=application6.xml
set APP_XML7=application7.xml
set APP_XML8=application8.xml

:: Files to package
set APP_DIR=bin
set FILE_OR_DIR=-C %APP_DIR% .

:: Your application ID (must match <id> of Application descriptor)
set APP_ID=air.RoboRallyClient

:: Output packages
set DIST_PATH=dist
set DIST_NAME=RoboRallyClient

:: Debugging using a custom IP
set DEBUG_IP=



:validation
%SystemRoot%\System32\find /C "<id>%APP_ID%</id>" "%APP_XML%" > NUL
if errorlevel 1 goto badid
goto end

:badid
echo.
echo ERROR: 
echo   Application ID in 'bat\SetupApplication.bat' (APP_ID) 
echo   does NOT match Application descriptor '%APP_XML%' (id)
echo.

:end