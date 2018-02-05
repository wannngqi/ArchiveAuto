#!/bin/sh

#自定义路径和TARGET名称
PROJ_PATH=~/Desktop/......; #工程路径


echo "WITCH TARGET WOULD BUILD:"

select TARGETNAME in "" "";do     #添加 target name，以便在同一个project下面打包不同target
	break;
done

DIR_NAME=$(date "+%m%d%H%M%S")
SCRIPT_PATH=$(pwd)

#xcodebuild clean -workspace "$PROJ_PATH" -scheme $TARGETNAME 

xcodebuild archive -workspace "$PROJ_PATH" -scheme $TARGETNAME  \
-archivePath $SCRIPT_PATH/$DIR_NAME/$TARGETNAME.xcarchive -configuration Release

echo $SCRIPT_PATH/$DIR_NAME/$TARGETNAME.xcarchive

xcodebuild -exportArchive -allowProvisioningUpdates YES \
-archivePath $SCRIPT_PATH/$DIR_NAME/$TARGETNAME.xcarchive \
-exportPath $SCRIPT_PATH/$DIR_NAME/IPA \
-exportOptionsPlist "$SCRIPT_PATH/Info.plist"

if test -f $SCRIPT_PATH/$DIR_NAME/IPA/$TARGETNAME.ipa; then
	curl -F "file=@$SCRIPT_PATH/$DIR_NAME/IPA/$TARGETNAME.ipa"  \
-F "uKey=" \
-F "_api_key=" \
https://www.pgyer.com/apiv1/app/upload
fi


#上面蒲公英的两个key

	
