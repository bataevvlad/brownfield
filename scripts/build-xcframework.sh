#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

trap 'echo "Build interrupted"; exit 1' INT

IOS_DIR="${IOS_DIR:-"$SCRIPT_DIR/../ios"}"
WORKSPACE=${WORKSPACE:-"BrownfieldCalculator"}
SCHEME=${SCHEME:-"ReactBrownfield"}
CONFIGURATION=${CONFIGURATION:-"Debug"}

for arg in "$@"; do
  case $arg in
    --release)
      CONFIGURATION="Release"
      shift
      ;;
  esac
done

cd "$IOS_DIR" || { echo "Failed to change directory to $IOS_DIR"; exit 1; }

echo -e "Cleaning the old output... \n"
rm -rf "./$SCHEME.xcframework"

mkdir -p ./frameworks/device ./frameworks/simulator

echo -e "Building $CONFIGURATION frameworks... \n"
xcodebuild \
  -workspace "$WORKSPACE.xcworkspace" \
  -scheme "$SCHEME" \
  -derivedDataPath build \
  -destination "generic/platform=iphoneos" \
  -destination "generic/platform=iphonesimulator" \
  -configuration "$CONFIGURATION" || { echo "Build failed"; exit 1; }

echo -e "Moving built frameworks... \n"
mv "./build/Build/Products/$CONFIGURATION-iphoneos/$SCHEME.framework" ./frameworks/device/ || { echo "Failed to move device framework"; exit 1; }
mv "./build/Build/Products/$CONFIGURATION-iphonesimulator/$SCHEME.framework" ./frameworks/simulator/ || { echo "Failed to move simulator framework"; exit 1; }

echo -e "Creating XCFramework..."
xcodebuild \
  -create-xcframework \
  -framework "./frameworks/device/$SCHEME.framework" \
  -framework "./frameworks/simulator/$SCHEME.framework" \
  -output "$SCHEME.xcframework" || { echo "Failed to create XCFramework"; exit 1; }

echo -e "Cleaning up temporary files... \n"
rm -rf "./frameworks"

echo "Build completed successfully!"
