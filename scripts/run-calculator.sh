#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
CALCULATOR_DIR="$PROJECT_ROOT/test-apps/ios/Calculator"
APP_PATH="$CALCULATOR_DIR/build/Build/Products/Debug-iphonesimulator/Calculator.app"
BUNDLE_ID="com.brownfield.Calculator"
SIMULATOR="iPhone 16"

echo "=== Running Calculator on iOS Simulator ==="
echo ""

# Check if app exists
if [ ! -d "$APP_PATH" ]; then
    echo "Calculator app not found. Building first..."
    "$SCRIPT_DIR/build-calculator.sh"
fi

# Boot simulator (ignore error if already booted)
echo "Booting simulator..."
xcrun simctl boot "$SIMULATOR" 2>/dev/null || true

# Install app
echo "Installing Calculator app..."
xcrun simctl install "$SIMULATOR" "$APP_PATH"

# Launch app
echo "Launching Calculator..."
xcrun simctl launch "$SIMULATOR" "$BUNDLE_ID"

echo ""
echo "=== Calculator is running! ==="
echo "Make sure Metro is running with 'yarn start' for React Native integration."
