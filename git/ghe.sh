#!/bin/bash


owner=adsgray
repo=scripts
pull_number=42

token=abcdefg0123456789
url=https://github.com/api/v3/repos/$owner/$repo/pulls/$pull_number/reviews

echo $url

curl -v -v -H "Authorization: token $token" $url
