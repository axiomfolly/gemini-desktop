#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ARCH="${1:-arm64}"
APP_NAME="Gemini"
OUT_DIR="$SCRIPT_DIR/$APP_NAME-darwin-$ARCH"
APP="$OUT_DIR/$APP_NAME.app"
ENTITLEMENTS="$SCRIPT_DIR/entitlements.plist"

echo "Building $APP_NAME for $ARCH..."
npx electron-packager . "$APP_NAME" \
    --platform=darwin \
    --arch="$ARCH" \
    --icon=icon.icns \
    --overwrite \
    --prune=true

echo "Signing with entitlements (required for macOS Tahoe+)..."
find "$APP/Contents/Frameworks" -name "*.app" \
    -exec codesign --force --sign - --entitlements "$ENTITLEMENTS" {} \;
find "$APP/Contents/Frameworks" -name "*.framework" \
    -exec codesign --force --sign - --entitlements "$ENTITLEMENTS" {} \;
codesign --force --sign - --entitlements "$ENTITLEMENTS" "$APP"

echo ""
echo "Build complete: $APP"
codesign -vvv "$APP" 2>&1 | tail -2
echo ""
echo "To run:     open \"$APP\""
echo "To install: cp -R \"$APP\" /Applications/"
