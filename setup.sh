#!/bin/bash

echo "🚀 開始安裝基礎常用套件..."

# 偵測 Linux 發行版
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
else
    OS=$(uname -s | tr '[:upper:]' '[:lower:]')
fi

case "$OS" in
    ubuntu|debian)
        echo "📦 偵測到 Ubuntu/Debian 系統，開始安裝..."
        sudo apt update -y
        sudo apt install -y curl fd-find yazi
        
        # 自動幫 Ubuntu 設定 fd 的 alias
        if ! grep -q "alias fd='fdfind'" ~/.bashrc; then
            echo "alias fd='fdfind'" >> ~/.bashrc
            echo "💡 已自動為 fd 設定別名 (alias)"
        fi
        ;;
        
    fedora|centos|rhel|almalinux|rocky)
        echo "📦 偵測到 RedHat 體系系統，開始安裝..."
        sudo dnf install -y curl fd-find yazi
        ;;
        
    *)
        echo "❌ 抱歉，此腳本目前不支援您的系統種類: $OS"
        exit 1
        ;;
esac

echo "✅ 所有套件安裝完成！請執行 'source ~/.bashrc' 來啟用設定。"
