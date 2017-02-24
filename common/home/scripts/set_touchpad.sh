#!/bin/sh

synclient HorizTwoFingerScroll=1 \
          PalmDetect=1 PalmMinWidth=40 \
          FingerHigh=8 \
          TapButton1=0 TapButton2=0 TapButton3=0 \
          RBCornerButton=3 RTCornerButton=2 \
          VertScrollDelta=160 HorizScrollDelta=135 \
          MinSpeed=1.8 MaxSpeed=2 \
          RightButtonAreaLeft=0 RightButtonAreaTop=0 \
          RTCornerButton=0 RBCornerButton=0 && \

syndaemon -t -k -i 1 -d
