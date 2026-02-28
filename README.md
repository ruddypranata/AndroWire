# AndroWire 📱⚡

**AndroWire** is a universal, lightweight Bash-based GUI wrapper for `adb` and `scrcpy`. It streamlines the process of wirelessly mirroring and controlling your Android device via Wireless Debugging, eliminating the need to memorize or type complex terminal commands.

## ✨ Key Features
- **Auto-Detect**: Instantly launches mirroring if a device is already active on port 5555.
- **Guided Setup**: User-friendly GUI for pairing new devices and connecting to existing ones using `yad`.
- **Streaming Optimization**: Pre-configured with efficient parameters (1024px, 2M bitrate) to ensure stable wireless performance and low latency.
- **Smart Validation**: Prevents execution errors by validating IP addresses and checking system dependencies.
- **Privacy Focused**: Automatically uses the `--turn-screen-off` flag to save battery and maintain privacy on the physical device while mirroring.

## 🛠️ Prerequisites
To run this script, you need to have the following tools installed:

1. **ADB (Android Platform Tools)**: **Minimum version 30.0.0** is required for the `pair` command.
2. **scrcpy**: The core screen mirroring engine.
3. **yad**: For the graphical user interface dialogs.
4. **libnotify**: For system desktop notifications.

### Installation on Linux (Ubuntu/Debian)
```bash
sudo apt update
sudo apt install adb scrcpy yad libnotify-bin

```

> **Note**: If your distribution's default `adb` is outdated, please download the latest [Platform Tools from Google](https://developer.android.com/studio/releases/platform-tools) and add it to your PATH.

## 🚀 Quick Installation

Simply run the install script, and it will handle the permissions and create a desktop shortcut for you:

1. **Clone and Enter Folder**:
   ```bash
   git clone https://github.com/ruddypranata/AndroWire.git
   cd AndroWire
	```

2. **Run Installer**:
	```bash
	chmod +x install.sh
	./install.sh
	```

3. **Open from Menu**:
	
	You can now search for "AndroWire" in your Application Launcher/Start Menu.	

## 📖 Step-by-Step Instructions

1. Enable **Developer Options** and **Wireless Debugging** on your Android device.
2. Connect your PC and Android to the **same Wi-Fi network**.
3. **If connecting for the first time**:
	* Select **New Pairing**.
	* Enter the **Pairing Code** and **Pairing Port** shown on your phone's Wireless Debugging screen.

4. **To start mirroring**:
	* Select **Connect**.
	* Enter the **Connection Port** (usually different from the pairing port).
	* The script will automatically handle the connection and launch `scrcpy`.

## 📸 Screenshots

| Phone IP| AndroWire Menu | Menu Mode |
| :---: | :---: | :---: |
| ![Enter Phone IP](https://i.imgur.com/bfEJ6vF.png) | ![AndroWire Menu](https://i.imgur.com/yUje20X.png) | ![AndroWire Pairing](https://i.imgur.com/8s6BIr1.png) |
| Pairing Success | Port ADB Connect | Mirroring Success |
| ![Pairing Success](https://i.imgur.com/X3pl0yo.png) | ![Port ADB Connect](https://i.imgur.com/tKLYePW.png) | ![Mirroring Success](https://i.imgur.com/ukWbq4D.png) |

## 🤝 Support and Contributions

If you find this project useful, feel free to star the repo. Your support helps maintain and develop new features!

[![GitHub Sponsors](https://img.shields.io/badge/Sponsor-GitHub-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/sponsors/ruddypranata)&nbsp;&nbsp;&nbsp;[![Support Me on Ko-fi](https://img.shields.io/badge/Support%20Me-Ko--fi-29ABAE?style=for-the-badge&logo=kofi&logoColor=white&logoSize=auto)](https://ko-fi.com/L4L01O3OW1)&nbsp;&nbsp;&nbsp;[![Dukung via Saweria](https://img.shields.io/badge/Donasi%20Rupiah-Saweria-E05D44?style=for-the-badge&logo=cashapp&logoColor=white&logoSize=auto)](https://saweria.co/ruddypranata)

Jika Anda berada di Indonesia dan ingin mendukung melalui QRIS / GoPay / OVO / DANA / Link Aja, silakan gunakan opsi Saweria di atas.

## 📜 License

This project is licensed under the [MIT License](https://www.google.com/search?q=LICENSE) - feel free to modify and share!
