#!/bin/sh

killall syndaemon

if lsusb -d 046d: ; then
    logger 'using logitech touchpad'
    synclient HorizTwoFingerScroll=1 \
              PalmDetect=1 PalmMinWidth=40 \
              FingerHigh=8 \
              TapButton1=0 TapButton2=0 TapButton3=0 \
              RBCornerButton=3 RTCornerButton=2 \
              VertScrollDelta=160 HorizScrollDelta=135 \
              MinSpeed=1.8 MaxSpeed=2 \
              RightButtonAreaLeft=0 RightButtonAreaTop=0 \
              RTCornerButton=0 RBCornerButton=0
else
    logger 'using lenovo ideapad y700 touchpad'
    synclient HorizTwoFingerScroll=1 \
              PalmDetect=1 PalmMinWidth=40 \
              FingerHigh=8 \
              TapButton1=0 TapButton2=0 TapButton3=0 \
              RBCornerButton=3 RTCornerButton=2 \
              VertScrollDelta=160 HorizScrollDelta=135 \
              MinSpeed=1.8 MaxSpeed=2 \
              RightButtonAreaLeft=0 RightButtonAreaTop=0 \
              RTCornerButton=0 RBCornerButton=0
fi && syndaemon -t -k -i 1 -d
