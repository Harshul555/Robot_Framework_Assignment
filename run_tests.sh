#!/bin/bash

source venv/bin/activate

HEADLESS=${HEADLESS:-False}

robot --outputdir results \
      --loglevel DEBUG:INFO \
      --listener resources/ScreenshotListener.py \
      --variable HEADLESS:${HEADLESS} \
      --output original.xml \
      tests/login.robot

if [ -f results/original.xml ]; then
    robot --outputdir results \
          --loglevel DEBUG:INFO \
          --listener resources/ScreenshotListener.py \
          --variable HEADLESS:${HEADLESS} \
          --rerunfailed results/original.xml \
          --output rerun.xml \
          tests/login.robot 2>/dev/null || true
    
    if [ -f results/rerun.xml ]; then
        rebot --outputdir results \
              --merge \
              results/original.xml results/rerun.xml
    else
        mv results/original.xml results/output.xml
    fi
fi

open results/report.html
