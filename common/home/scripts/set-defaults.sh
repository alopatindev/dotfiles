#!/bin/sh

unset BROWSER
xdg-settings set default-web-browser chromium-browser-chromium.desktop
xdg-mime default chromium.desktop text/html
xdg-mime default libreoffice-writer.desktop application/rtf
update-mime-database ~/.local/share/mime
