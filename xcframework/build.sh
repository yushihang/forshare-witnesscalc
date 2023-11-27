lipo -create /Users/yushihang/Documents/HSBC/polygonID/witnesscalc/build_witnesscalc_ios_simulator_x86_64/build/witnesscalc_credentialAtomicQuerySigV2Static.build/Release-iphonesimulator/Objects-normal/arm64/Binary/libwitnesscalc_credentialAtomicQuerySigV2.a /Users/yushihang/Documents/HSBC/polygonID/witnesscalc/build_witnesscalc_ios_simulator_x86_64/build/witnesscalc_credentialAtomicQuerySigV2Static.build/Release-iphonesimulator/Objects-normal/x86_64/Binary/libwitnesscalc_credentialAtomicQuerySigV2.a -output /Users/yushihang/Documents/HSBC/polygonID/witnesscalc/build_witnesscalc_ios_simulator_x86_64/src/Release-iphonesimulator/libwitnesscalc_credentialAtomicQuerySigV2OnChain.a


xcodebuild -create-xcframework -library ios-arm64/libfr.a  -library ios-arm64/libgmp.a -headers ./headers -output witnesscalc.xcframework


xcodebuild -create-xcframework -library ios-arm64/libfr.a  -library ios-simulator-x86_64_arm64/libfr.a -headers ./headers -output fr.xcframework


xcodebuild -create-xcframework -library ios-arm64/libgmp.a  -headers headers/gmp  -library ios-simulator-x86_64_arm64/libgmp.a -headers headers/gmp -output gmp.xcframework

xcodebuild -create-xcframework -library ios-arm64/libwitnesscalc_authV2.a  -headers headers/witnesscalc_authV2  -library ios-simulator-x86_64_arm64/libwitnesscalc_authV2.a -headers headers/witnesscalc_authV2  -output witnesscalc_authV2.xcframework

xcodebuild -create-xcframework -library ios-arm64/libwitnesscalc_credentialAtomicQueryMTPV2.a  -headers headers/witnesscalc_credentialAtomicQueryMTPV2  -library ios-simulator-x86_64_arm64/libwitnesscalc_credentialAtomicQueryMTPV2.a -headers headers/witnesscalc_credentialAtomicQueryMTPV2  -output witnesscalc_credentialAtomicQueryMTPV2.xcframework


xcodebuild -create-xcframework -library ios-arm64/libwitnesscalc_credentialAtomicQueryMTPV2OnChain.a  -headers headers/witnesscalc_credentialAtomicQueryMTPV2OnChain  -library ios-simulator-x86_64_arm64/libwitnesscalc_credentialAtomicQueryMTPV2OnChain.a -headers headers/witnesscalc_credentialAtomicQueryMTPV2OnChain  -output witnesscalc_credentialAtomicQueryMTPV2OnChain.xcframework

xcodebuild -create-xcframework -library ios-arm64/libwitnesscalc_credentialAtomicQuerySigV2.a  -headers headers/witnesscalc_credentialAtomicQuerySigV2  -library ios-simulator-x86_64_arm64/libwitnesscalc_credentialAtomicQuerySigV2.a -headers headers/witnesscalc_credentialAtomicQuerySigV2  -output witnesscalc_credentialAtomicQuerySigV2.xcframework


xcodebuild -create-xcframework -library ios-arm64/libwitnesscalc_credentialAtomicQuerySigV2OnChain.a  -headers headers/witnesscalc_credentialAtomicQuerySigV2OnChain  -library ios-simulator-x86_64_arm64/libwitnesscalc_credentialAtomicQuerySigV2OnChain.a -headers headers/witnesscalc_credentialAtomicQuerySigV2OnChain  -output witnesscalc_credentialAtomicQuerySigV2OnChain.xcframework