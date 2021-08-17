# Keyboard & Mice Configuration

Table of Contents

* [Terminal](#terminal)
   * [Remapping Backspace](#remapping-backspace)
   * [Legacy config layout manually](#legacy-config-layout-manually)
   * [Debian/Ubuntu](#debianubuntu)
   * [RedHat/CentOS/OracleLinux](#redhatcentosoraclelinux)
* [Devices Customization](#devices-customization)
   * [Keychron K3 v2 60% - Portuguese Brazil Accents (pt_br)](#keychron-k3-v2-60---portuguese-brazil-accents-pt_br)
   * [Microsoft Keyboard: Microsoft Wedge Mobile Keyboard (bluetooth)](#microsoft-keyboard-microsoft-wedge-mobile-keyboard-bluetooth)
   * [Logitec Mouse Ergonomic: Master MX 3](#logitec-mouse-ergonomic-master-mx-3)

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

### XMODMAP Tool

#### Get KeyCode by keyboard eventpress (at graphic mode)

```shell
xev |egrep "KeyRelease|keycode"
```

#### Get Current Map

  xmodmap -pke |egrep -i "print|ins"

#### Quick ref

##### _Conventions_

Alias "dead_*" => accent to apply at the second key/char pressed

Format "xmodmap -e" => "keycode NUMBER = NORMAL SHIFTED [NoSymbol] [NoSymbol] AltGR AltGR+L_Shift"

##### _Key Codes_

```plain
08 AltGR
22 Backspace
47 : ;
48 ' "
62 R_Shift
50 L_Shift
```

##### _Aliases for pt_br Accents_

```plain
dead_acute
dead_grave 
dead_tilde
dead_circumflex
```

##### _Defaults en_us.intl Codes_

```plain
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
```

### __Keychron K12 60% - Portuguese Brazil Accents (pt_br)__

__Problem__ : For trained use of a 75% (or more) keyboard with Fn line and a separated key for deadkey of grave/tilde, was very dificult to create habit and so may times mistake pressed the ESC key, it a @!#s by close the current window/app.

__Solution__ : Change default action of ESC key, inverse first action from ESC to accents.

```bash
# ----------------------------------------------------------------------
# Keyboard MAP of pt_br to use at "Keycrhon K12"
# replace ESC(49) by dead_grave and dead_tilde
# replace Apostrophe(49/fn1+esc) by ESC
# add "AltGr + '" to apply apostrophe (not dead_acute)
xmodmap -e "keycode 9 = dead_grave dead_tilde NoSymbol NoSymbol Escape"
xmodmap -e "keycode 48 = dead_acute quotedbl NoSymbol NoSymbol apostrophe"
xmodmap -e "keycode 49 = Escape"
```

_Obs.: Validate with Ubuntu 20.04 (Ago2021)_

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

__Solution__ : Remap mouse buttons using xbindkeys.

__Requires__ : Packages "xdotool", "xautomation", "xbindkeys", "xbindkeys-config".

> ~./.xbindkeysrc

```bash
"xte 'Page_Up'"
 b:8

"xte 'Page_Down'"
 b:9
```
