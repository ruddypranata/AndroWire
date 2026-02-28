#!/bin/bash

# --- CONFIGURATION ---
SCRIPT_NAME="androwire.sh"
APP_NAME="AndroWire"
ICON="phone"
INSTALL_DIR=$(pwd)
DESKTOP_FILE="$HOME/.local/share/applications/androwire.desktop"

echo "🚀 Starting $APP_NAME installation..."

# 1. Make the main script executable
if [ -f "$SCRIPT_NAME" ]; then
    chmod +x "$SCRIPT_NAME"
    echo "✅ Made $SCRIPT_NAME executable."
else
    echo "❌ Error: $SCRIPT_NAME not found in this folder!"
    exit 1
fi

# 2. Create the .desktop file dynamically
echo "📝 Generating desktop shortcut..."

cat > "$DESKTOP_FILE" <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=$APP_NAME
Comment=Wireless Android Mirroring via ADB
Exec=$INSTALL_DIR/$SCRIPT_NAME
Icon=$ICON
Terminal=false
Categories=Utility;Development;
EOF

# 3. Set permissions for the desktop file
chmod +x "$DESKTOP_FILE"

echo "✅ Shortcut created at: $DESKTOP_FILE"
echo "🎉 Installation complete! You can now find '$APP_NAME' in your application menu."

# Optional: Prompt to run the app now
read -p "Do you want to launch $APP_NAME now? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    ./$SCRIPT_NAME
fi
