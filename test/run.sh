#!/usr/bin/env bash
cd ./complete
spring run app.groovy &
sleep 20
curl -s http://localhost:8080 > actual.html
killall "java"

echo "Let's look at the actual results: `cat actual.html`"
echo "And compare it to: `cat ../test/expected.html`"

if diff -w ../test/expected.html actual.html; then
  echo SUCCESS || exit 0
else
  echo FAIL || exit 255
fi
rm -rf actual.html

exit
