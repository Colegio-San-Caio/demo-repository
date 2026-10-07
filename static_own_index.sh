#!/usr/bin/env bash
HTML_SUM=$(curl -sL https://raw.githubusercontent.com/Colegio-San-Caio/demo-repository/main/oeneye.html | sha256sum | awk '{print $1}')
PNG_SUM=$(curl -sL https://raw.githubusercontent.com/Colegio-San-Caio/demo-repository/main/logo-copyright.png | sha256sum | awk '{print $1}')
SVG_SUM=$(curl -sL https://raw.githubusercontent.com/Colegio-San-Caio/demo-repository/main/logo-copyright.svg | sha256sum | awk '{print $1}')
