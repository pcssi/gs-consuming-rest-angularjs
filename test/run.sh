#!/usr/bin/env bash
cd ./complete
spring run app.groovy &
sleep 10
curl -s http://localhost:8080 > actual.html
killall "java"

echo "Let's look at the actual results: `cat actual.html`"
echo "And compare it to: `cat ../test/expected.html`"

if diff -u -w --strip-trailing-cr ../test/expected.html actual.html; then
  echo SUCCESS || RET=0
else
  echo FAIL || RET=255
fi
rm -rf actual.html
exit $RET
