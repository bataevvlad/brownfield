#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
CALCULATOR_DIR="$PROJECT_ROOT/test-apps/ios/Calculator"
FRAMEWORKS_DIR="$CALCULATOR_DIR/Frameworks"

echo "=== Building Calculator with ReactBrownfield XCFramework ==="
echo ""

# Step 1: Build ReactBrownfield.xcframework
echo "Step 1: Building ReactBrownfield.xcframework..."
"$SCRIPT_DIR/build-xcframework.sh"

# Step 2: Copy frameworks to Calculator project
echo ""
echo "Step 2: Copying frameworks to Calculator project..."
mkdir -p "$FRAMEWORKS_DIR"

# Copy ReactBrownfield.xcframework
rm -rf "$FRAMEWORKS_DIR/ReactBrownfield.xcframework"
cp -R "$PROJECT_ROOT/ios/ReactBrownfield.xcframework" "$FRAMEWORKS_DIR/"
echo "  - ReactBrownfield.xcframework copied"

# Copy hermes.framework (required dependency)
rm -rf "$FRAMEWORKS_DIR/hermes.xcframework"
mkdir -p "$FRAMEWORKS_DIR/hermes.xcframework/ios-arm64-simulator"
mkdir -p "$FRAMEWORKS_DIR/hermes.xcframework/ios-arm64"
cp -R "$PROJECT_ROOT/ios/build/Build/Products/Debug-iphonesimulator/XCFrameworkIntermediates/hermes-engine/Pre-built/hermes.framework" "$FRAMEWORKS_DIR/hermes.xcframework/ios-arm64-simulator/"
cp -R "$PROJECT_ROOT/ios/build/Build/Products/Debug-iphoneos/XCFrameworkIntermediates/hermes-engine/Pre-built/hermes.framework" "$FRAMEWORKS_DIR/hermes.xcframework/ios-arm64/"

# Create Info.plist for hermes.xcframework
cat > "$FRAMEWORKS_DIR/hermes.xcframework/Info.plist" << 'PLIST'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>AvailableLibraries</key>
    <array>
        <dict>
            <key>LibraryIdentifier</key>
            <string>ios-arm64-simulator</string>
            <key>LibraryPath</key>
            <string>hermes.framework</string>
            <key>SupportedArchitectures</key>
            <array>
                <string>arm64</string>
            </array>
            <key>SupportedPlatform</key>
            <string>ios</string>
            <key>SupportedPlatformVariant</key>
            <string>simulator</string>
        </dict>
        <dict>
            <key>LibraryIdentifier</key>
            <string>ios-arm64</string>
            <key>LibraryPath</key>
            <string>hermes.framework</string>
            <key>SupportedArchitectures</key>
            <array>
                <string>arm64</string>
            </array>
            <key>SupportedPlatform</key>
            <string>ios</string>
        </dict>
    </array>
    <key>CFBundlePackageType</key>
    <string>XFWK</string>
    <key>XCFrameworkFormatVersion</key>
    <string>1.0</string>
</dict>
</plist>
PLIST
echo "  - hermes.xcframework created"

echo "Frameworks copied to $FRAMEWORKS_DIR"

# Step 3: Build Calculator app
echo ""
echo "Step 3: Building Calculator app..."
cd "$CALCULATOR_DIR"

xcodebuild \
    -project Calculator.xcodeproj \
    -scheme Calculator \
    -configuration Debug \
    -destination 'platform=iOS Simulator,name=iPhone 16' \
    -derivedDataPath build \
    build

echo ""
echo "=== Calculator build completed successfully! ==="
echo "Run 'yarn calculator:run' to launch the app."
