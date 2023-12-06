#!/bin/bash

current_directory="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "current_directory:$current_directory"
# enter project directory
parent_directory="$(dirname "$current_directory")"
#echo "$parent_directory"
project_directory="$parent_directory/build_witnesscalc_ios_simulator_x86_64"

project_path="$project_directory/witnesscalc.xcodeproj"

output_path="$project_directory/output"

framework_path="$parent_directory/xcframework/Frameworks"

# check project existance
if [ -e "$project_path" ]; then
    echo "$project_path exists."
else
    echo "Error: $project_path NOT found!"
    exit 1
fi

rm -rf "$output_path"
mkdir "$output_path"

rm -rf "$project_directory/build"
rm -rf "$project_directory/src"

mkdir "$output_path/iPhoneSimulator" > /dev/null 2>&1
mkdir "$output_path/iPhoneOS" > /dev/null 2>&1 

output_path_iphone_simulator_x86_64="$output_path/iPhoneSimulator/x86_64"
mkdir "$output_path_iphone_simulator_x86_64" > /dev/null 2>&1

output_path_iphone_simulator_arm64="$output_path/iPhoneSimulator/arm64"
mkdir "$output_path_iphone_simulator_arm64" > /dev/null 2>&1

output_path_iphone_simulator_universal="$output_path/iPhoneSimulator/universal"
mkdir "$output_path_iphone_simulator_universal" > /dev/null 2>&1

output_path_iphoneos_arm64="$output_path/iPhoneOS/arm64"
mkdir "$output_path_iphoneos_arm64" > /dev/null 2>&1


available_sdks=$(xcodebuild -showsdks)
ios_simulator_sdk=$(echo "$available_sdks" | grep -o "iphonesimulator[0-9.]*")
echo "Available iOS Simulator SDKs: $ios_simulator_sdk"

#available_sdks=$(xcodebuild -showsdks)
ios_device_sdk=$(echo "$available_sdks" | grep -o "iphoneos[0-9.]*")
echo "Available iOS Device SDKs: $ios_device_sdk"

derivedDataPath="$project_directory/DerivedData"
build_configuration="Release"


# 设置要构建的 schemes 数组
libs=("witnesscalc_credentialAtomicQuerySigV2OnChain" "witnesscalc_credentialAtomicQueryMTPV2OnChain" "witnesscalc_authV2" "witnesscalc_credentialAtomicQuerySigV2" "witnesscalc_credentialAtomicQueryMTPV2")

rm -rf "$derivedDataPath"
for lib in "${libs[@]}"; do


    libName="lib$lib.a"
    echo "libName: $libName"
    
    scheme="${lib}Static"
    echo "scheme: $scheme"

    staticlib="$project_directory/src/Release-iphonesimulator/$libName"
    #xcodebuild -showsdks
    sdk="x86_64"
    xcodebuild -project "$project_path" -configuration "$build_configuration" -scheme "$scheme" -derivedDataPath "$derivedDataPath" -sdk "$ios_simulator_sdk" -arch "$sdk"
    cp "$staticlib" "$output_path_iphone_simulator_x86_64"


    staticlib="$project_directory/src/Release-iphonesimulator/$libName"
    sdk="arm64"
    xcodebuild -project "$project_path" -configuration "$build_configuration" -scheme "$scheme" -derivedDataPath "$derivedDataPath" -sdk "$ios_simulator_sdk" -arch "$sdk"
    cp "$staticlib" "$output_path_iphone_simulator_arm64"

    lipo -create "$output_path_iphone_simulator_x86_64/$libName" "$output_path_iphone_simulator_arm64/$libName" -output "$output_path_iphone_simulator_universal/$libName"

    staticlib="$project_directory/src/Release-iphoneos/$libName"
    sdk="arm64"
    xcodebuild -project "$project_path" -configuration "$build_configuration" -scheme "$scheme" -derivedDataPath "$derivedDataPath" -sdk "$ios_device_sdk" -arch "$sdk"
    cp "$staticlib" "$output_path_iphoneos_arm64"


    cp "$output_path_iphone_simulator_universal/$libName" "$framework_path/$lib.xcframework/ios-arm64_x86_64-simulator/$libName"

    cp "$output_path_iphoneos_arm64/$libName" "$framework_path/$lib.xcframework/ios-arm64/$libName"

done


