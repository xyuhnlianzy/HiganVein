#!/bin/bash
# Tunggu sebentar sampai KWin/Wayland & Polkit agent siap
sleep 3
# Jalankan calamares (user higan sudoers nopasswd atau langsung root jika via sddm autologin root)
sudo /usr/bin/calamares || /usr/bin/calamares
