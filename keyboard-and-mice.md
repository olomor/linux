# Keyboard & Mice Configuration

Table of Contents

* [Terminal](#terminal)
  * [Remapping Backspace](#remapping-backspace)
  * [Legacy config layout manually](#legacy-config-layout-manually)
  * [Debian/Ubuntu](#debian-ubuntu)
  * [RedHat/CentOS/OracleLinux](#redhat-centos-oraclelinux)
* [Devices Customization](#devices-customization)
  * [Microsoft Keyboard: Microsoft Wedge Mobile Keyboard (bluetooth)](#microsoft-keyboard:-microsoft-wedge-mobile-keyboard-(bluetooth))
  * [Logitec Mouse Ergonomic: Master MX 3](#logitec-mouse-ergonomic:-master-mx-3)

***

## Terminal

### Remapping Backspace

```bash
stty erase ^?
```

***

### Legacy config layout manually

```bash
XKBLAYOUT="us"
setxkbmap us
loadkeys br            (Brazilian Portuguese)
loadkeys us            (US English)
localectl set-keymap de-latin1
```

### Debian/Ubuntu

#### Layout 

##### Using Configuration Tool

```bash
sudo dpkg-reconfigure keyboard-configuration
```

Select "Generic 101-key PC (Intl.)" for PT_BR with accent composite.

##### Manual Config Edit

File "/etc/default/keyboard" (logout to apply)

```plain
XKBMODEL="pc105"
XKBLAYOUT="us"
XKBVARIANT="alt-intl"
XKBOPTIONS=""
BACKSPACE="guess"
```

### RedHat/CentOS/OracleLinux

```bash
mount /dev/cdrom /media
cd /media/Packages
rpm -ivh system-config-keyboard-*.rpm 
system-config-keyboard
```

***

## Devices Customization

xmodmap -e "keysym Alt_L = Meta_L Alt_L"

### Keyboard With XMODMAP

#### Get KeyCode by keyboard eventpress (at graphic mode)

  xev |egrep "KeyRelease|keycode"

#### Get Current Map

  xmodmap -pke |egrep -i "print|ins"

#### Quick ref

  >> Conventions

  Alias "dead_*" => accent to apply at the second key/char pressed

  Format "xmodmap -e" => "keycode NUMBER = NORMAL SHIFTED [NoSymbol] [NoSymbol] AltGR AltGR+L_Shift"

  >> Codes

  08 AltGR
  22 Backspace
  47 : ;
  48 ' "
  62 R_Shift
  50 L_Shift

  >> Aliases PR_BR

  dead_acute
  dead_grave 
  dead_tilde
  dead_circumflex

  >> Defaults en_us.intl Codes

  keycode   9 = Escape NoSymbol Escape
  keycode  22 = BackSpace BackSpace BackSpace BackSpace
  keycode  47 = semicolon colon semicolon colon dead_ogonek dead_diaeresis
  keycode  48 = dead_acute dead_diaeresis apostrophe quotedbl apostrophe quotedbl
  keycode  49 = dead_grave dead_tilde grave asciitilde grave asciitilde
  keycode  50 = Shift_L NoSymbol Shift_L NoSymbol Shift_L
  keycode  62 = Shift_R NoSymbol Shift_R NoSymbol Shift_R
  keycode  90 = KP_Insert KP_0 KP_Insert KP_0 KP_Insert KP_0
  keycode  91 = KP_Delete KP_Decimal KP_Delete KP_Decimal
  keycode 107 = Print Sys_Req Print Sys_Req Print Sys_Req
  keycode 108 = ISO_Level3_Shift NoSymbol ISO_Level3_Shift NoSymbol ISO_Level3_Shift
  keycode 119 = Delete NoSymbol Delete
  keycode 118 = Insert NoSymbol Insert NoSymbol Insert
  keycode 135 = Menu NoSymbol Menu
  keycode 147 = XF86MenuKB NoSymbol XF86MenuKB
  keycode 218 = Print NoSymbol Print NoSymbol Print

### __Keychron K3 v2 60% - Portuguese Brazil Accents (pt_br) __

  >> deac_acute = apostrophe + AltGR
  >> dead_grave = apostrophe + AltGR + Shift
  xmodmap -e "keycode 48 = apostrophe quotedbl NoSymbol NoSymbol dead_acute dead_grave"

  >> dead_tilde = semicolumn + AltGr
  >> dead_circumflex = semicolumn + AltGr + Shift
  xmodmap -e "keycode 47 = semicolon colon NoSymbol NoSymbol dead_tilde dead_circumflex"

### __Microsoft Keyboard: Microsoft Wedge Mobile Keyboard (bluetooth)__

__Problem__ : Insert key is missed at physical keyboard layout.

__Solution__ : On press "PrtScn" key, simulate "Insert" key.

```bash

# --- Temporary Remap ---
xmodmap -e "keycode 107 = KP_Insert KP_0 KP_Insert KP_0 KP_Insert KP_0"
xmodmap -e "keycode 218 = KP_Insert KP_0 KP_Insert KP_0 KP_Insert KP_0"

# --- Undo Change ---
xmodmap -e "keycode 107 = Print Sys_Req Print Sys_Req Print Sys_Req"
xmodmap -e "keycode 218 = Print NoSymbol Print NoSymbol Print"
```

### __Logitec Mouse Ergonomic: Master MX 3__

__Problem__ : Buttons bellow left scroller works only at browser as back page.

__Solution__ : Remap mouse buttons using xbindkeys

> ~./.xbindkeysrc

```bash
#
#"xte 'key Page_Up'"
# b:6
#
#"xte 'key Page_Down'"
# b:7
#
#"xdotool key 'Control_L+Insert'"
"xdotool getactivewindow windowminimize"
 b:8

#"xdotool key 'Shift_L+Insert'"
"xdotool search '.*Slack.*UOL.*' windowactivate"
 b:9
```
