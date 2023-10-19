#!/bin/bash
sudo cp index.html __build
cd __build
python3 -m http.server 8000
chromium 0.0.0.0:8000
