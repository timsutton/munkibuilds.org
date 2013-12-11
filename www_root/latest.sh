#!/bin/sh
#
# Download and install the latest Munki tools from munkibuilds.org

DMG_NAME="munkitools-latest.dmg"
DMG_URL="https://munkibuilds.org/$DMG_NAME"
LOCAL_DMG_PATH="`pwd`/$DMG_NAME"

TMPMOUNT=`/usr/bin/mktemp -d /tmp/munkibuilds.XXXX`
HDIUTIL=/usr/bin/hdiutil
CURL=/usr/bin/curl

cat <<EOF


**************************
** Munki auto-installer **
**************************

EOF
if [ $(id -u) -ne 0 ]; then
	echo "(Please enter your sudo password when prompted)"
	echo ""
fi

echo "Grabbing the latest version..."
$CURL -s --connect-timeout 30 -o "$LOCAL_DMG_PATH" "$DMG_URL"

echo "Mounting at $TMPMOUNT..."
$HDIUTIL attach "$LOCAL_DMG_PATH" -mountpoint "$TMPMOUNT"
MUNKI_MPKG_PATH="$TMPMOUNT/`/bin/ls $TMPMOUNT | grep munkitools`"

echo "Installing Munki from $MUNKI_MPKG_PATH..."
sudo /usr/sbin/installer -pkg "$MUNKI_MPKG_PATH" -target /

echo "Unmounting installer dmg..."
$HDIUTIL detach "$TMPMOUNT"

echo "Cleaning up..."
/bin/rm -f "$DMG_NAME"
/bin/rm -rf "$TMPMOUNT"

echo "Done."
