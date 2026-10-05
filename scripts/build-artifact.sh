#!/bin/sh
# Builds dist/artifact.html: index.html without the standalone <html>/<head>/<body> wrapper,
# because the Claude artifact host wraps the page in its own skeleton.
set -e
cd "$(dirname "$0")/.."
mkdir -p dist
sed -e '1,/<!-- artifact:start/d' \
    -e '/^<\/head>$/d' \
    -e '/^<body>$/d' \
    -e '/<!-- artifact:end -->/,$d' \
    index.html > dist/artifact.html
head -c 200 dist/artifact.html | grep -q '^<title>' || { echo "build-artifact: <title> must be the first line" >&2; exit 1; }
echo "dist/artifact.html ($(wc -c < dist/artifact.html | tr -d ' ') bytes)"
