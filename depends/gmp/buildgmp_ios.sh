#!/bin/bash

GMP_DIR="/Users/yushihang/Documents/HSBC/polygonID/witnesscalc/depends/gmp"

build_ios_xcframework()
{
    # Define architecture-specific variables
    ARCHITECTURES=("arm64") # "x86_64"
    PACKAGE_DIRS=()
    BUILD_DIRS=()

    # Loop through architectures
    for ARCH in "${ARCHITECTURES[@]}"; do
        PACKAGE_DIR="$GMP_DIR/package_ios_${ARCH}"
        BUILD_DIR="build_ios_${ARCH}"

        PACKAGE_DIRS+=("$PACKAGE_DIR")
        BUILD_DIRS+=("$BUILD_DIR")

        if [ -d "$PACKAGE_DIR" ]; then
            echo "iOS package for $ARCH is built already. See $PACKAGE_DIR"
            return 1
        fi

        export SDK="iphonesimulator"  # Use "iphoneos" for arm64
        export TARGET="${ARCH}-apple-darwin"
        export MIN_IOS_VERSION=8.0

        export ARCH_FLAGS="-arch $ARCH"
        export OPT_FLAGS="-O3 -g3 -fembed-bitcode"
        export HOST_FLAGS="${ARCH_FLAGS} -miphoneos-version-min=${MIN_IOS_VERSION} -isysroot $(xcrun --sdk ${SDK} --show-sdk-path)"

        export CC=$(xcrun --find --sdk "${SDK}" clang)
        export CXX=$(xcrun --find --sdk "${SDK}" clang++)
        export CPP=$(xcrun --find --sdk "${SDK}" cpp)
        export CFLAGS="${HOST_FLAGS} ${OPT_FLAGS}"
        export CXXFLAGS="${HOST_FLAGS} ${OPT_FLAGS}"
        export LDFLAGS="${HOST_FLAGS}"

        echo "Building for $ARCH..."

        rm -rf "$BUILD_DIR"
        mkdir "$BUILD_DIR"
        cd "$BUILD_DIR"

        echo "../configure --host $TARGET --prefix="$PACKAGE_DIR" --with-pic --disable-fft --disable-assembly"
        # Configure and build
        #../configure --host $TARGET --prefix="$PACKAGE_DIR" --with-pic --disable-fft --disable-assembly &&
        #make -j${NPROC} &&
        #make install

        cd ..
    done

    # Create xcframework
    XCFRAMEWORK_OUTPUT="$GMP_DIR/YourLibrary.xcframework"
    xcodebuild -create-xcframework $(for DIR in "${PACKAGE_DIRS[@]}"; do echo "-library $DIR/lib/libyourlibrary.a"; done) \
        -headers $(for DIR in "${PACKAGE_DIRS[@]}"; do echo "-headers $DIR/include"; done) \
        -output "$XCFRAMEWORK_OUTPUT"

    echo "XCFramework created at $XCFRAMEWORK_OUTPUT"
}

# Run the build function
build_ios_xcframework