#!/bin/bash -e
# frameworks=("GRDB")

rm -rf derived_data/
rm -rf archives/

framework_name="FLEX"
scheme="FLEX"
project="FLEX.xcodeproj"

rm -rf $framework_name.xcframework
echo "Archiving $framework_name to XCFramework"

xcodebuild archive \
    -project  $project\
    -scheme $scheme \
    -derivedDataPath derived_data/$framework_name-iOS \
    -destination "generic/platform=iOS" \
    -sdk iphoneos \
    -archivePath archives/$framework_name-iOS \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
    ENABLE_TESTING_SEARCH_PATHS=YES \
    ENABLE_TESTABILITY=YES \
    SKIP_INSTALL=NO 

xcodebuild archive \
    -project $project \
    -scheme $scheme \
    -derivedDataPath derived_data/$framework_name-iOS-Simulator \
    -destination "generic/platform=iOS Simulator" \
    -sdk iphonesimulator \
    -archivePath archives/$framework_name-iOS-Simulator \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
    ENABLE_TESTING_SEARCH_PATHS=YES \
    ENABLE_TESTABILITY=YES \
    SKIP_INSTALL=NO 

xcodebuild -create-xcframework \
    -framework "archives/$framework_name-iOS.xcarchive/Products/Library/Frameworks/$framework_name.framework" \
    -framework "archives/$framework_name-iOS-Simulator.xcarchive/Products/Library/Frameworks/$framework_name.framework" \
    -output "$framework_name.xcframework"

echo "Archiving $framework_name to XCFramework Succeeded"

# for framework_name in ${frameworks[@]}; do

# done

# echo "All XCFramework Targets Archive Succeeded"