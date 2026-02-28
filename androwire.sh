#!/bin/bash

# --- CONFIGURATION ---
TITLE="AndroWire"
ICON_PHONE="phone"
ICON_CONN="network-transmit-receive"

# --- FUNCTION: DEPENDENCY CHECK ---
check_dependencies() {
    local tools=("adb" "scrcpy" "yad" "notify-send")
    for tool in "${tools[@]}"; do
        if ! command -v "$tool" &> /dev/null; then
            yad --error --title="Missing Tool" \
                --text="Error: '$tool' not found.\nPlease install it to continue." --width=300
            exit 1
        fi
    done
}

# --- FUNCTION: LAUNCH SCRCPY ---
launch_scrcpy() {
    local target=$1
    notify-send -a "$TITLE" -i "$ICON_CONN" "$TITLE" "Successfully connected to $target. Launching mirror..."

    # Optimized for wireless performance:
    # 2M bitrate and 1024 max-size ensure low latency over Wi-Fi
    scrcpy -s "$target" \
        --video-encoder='OMX.sprd.h264.encoder' \
        --video-bit-rate 2M \
        --max-fps 30 \
        --max-size 1024 \
        --turn-screen-off > /dev/null 2>&1 &
    exit 0
}

# Initialize Dependency Check
check_dependencies

# --- STEP 1: AUTO-DETECT ACTIVE CONNECTION ---
ALREADY_CONNECTED=$(adb devices | grep ":5555" | grep "device$" | awk '{print $1}' | head -n 1)

if [ -n "$ALREADY_CONNECTED" ]; then
    launch_scrcpy "$ALREADY_CONNECTED"
fi

# --- STEP 2: INITIAL IP INPUT ---
DEVICE_IP=$(yad --entry --title="$TITLE - Setup" --window-icon="$ICON_PHONE" --image="$ICON_PHONE" \
    --text="No active connection found. Enter Phone IP:" --entry-text="192.168.1." --button="Next:0" --button="Cancel:1")

# Exit if Cancelled
[ $? -ne 0 ] && exit

# --- STEP 3: MAIN MENU LOOP ---
while true; do
    ACTION=$(yad --list --title="$TITLE Menu" --window-icon="$ICON_PHONE" --text="Target IP: $DEVICE_IP" \
        --column="ID":HD --column="Action" \
        "1" "Connect (Already Paired)" \
        "2" "New Pairing" \
        "3" "Change IP Address" \
        "4" "Exit" --width=350 --height=280)

    # Check for exit or window close
    [ $? -ne 0 ] && exit
    [[ "$ACTION" == *"4"* ]] && exit

    # --- IP VALIDATION ---
    if [[ "$ACTION" == *"1"* ]] || [[ "$ACTION" == *"2"* ]]; then
        if [ -z "$DEVICE_IP" ] || [ "$DEVICE_IP" == "192.168.1." ]; then
            yad --error --title="Validation Error" --text="Please enter a valid IP address first!" --timeout=3
            continue
        fi
    fi

    # --- ACTION LOGIC ---
    if [[ "$ACTION" == *"1"* ]]; then
        CONN_PORT=$(yad --entry --title="$TITLE - Connect" --text="Enter Connection Port from phone screen:" --entry-text="5555")

        if [ -n "$CONN_PORT" ]; then
            notify-send -a "$TITLE" -i "network-transmit" "$TITLE" "Attempting to connect to $DEVICE_IP:$CONN_PORT..."

            # Clean up old connection attempts
            adb disconnect "$DEVICE_IP:5555" > /dev/null 2>&1

            adb connect "$DEVICE_IP:$CONN_PORT"
            sleep 2
            adb -s "$DEVICE_IP:$CONN_PORT" tcpip 5555
            sleep 2
            adb connect "$DEVICE_IP:5555"

            # Verify Connection Success
            if adb devices | grep -q "$DEVICE_IP:5555"; then
                launch_scrcpy "$DEVICE_IP:5555"
            else
                yad --error --title="Connection Failed" --text="Failed to connect. Please verify the port and your network." --timeout=4
            fi
        fi

    elif [[ "$ACTION" == *"2"* ]]; then
        PAIR_DATA=$(yad --form --title="$TITLE - Pairing" --window-icon="$ICON_PHONE" \
            --field="Pairing Port" --field="Pairing Code" --button="Pair:0" --button="Cancel:1")

        if [ $? -eq 0 ]; then
            PAIR_PORT=$(echo $PAIR_DATA | cut -d'|' -f1)
            PASSCODE=$(echo $PAIR_DATA | cut -d'|' -f2)

            notify-send -a "$TITLE" -i "network-wireless" "$TITLE" "Pairing in progress..."
            PAIR_RESULT=$(adb pair "$DEVICE_IP:$PAIR_PORT" "$PASSCODE" 2>&1)

            yad --info --title="Pairing Result" --text="$PAIR_RESULT" --width=400
        fi

    elif [[ "$ACTION" == *"3"* ]]; then
        NEW_IP=$(yad --entry --title="Change IP" --entry-text="$DEVICE_IP")
        [ -n "$NEW_IP" ] && DEVICE_IP=$NEW_IP

    fi
done
