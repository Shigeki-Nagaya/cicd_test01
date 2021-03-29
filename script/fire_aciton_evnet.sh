#!/bin/bash

curl \
  -H "Accept: application/vnd.github.v3+json" \
  -H "Authorization: token $GIT_TOKEN" \
  https://api.github.com/repos/Shigeki-Nagaya/cicd_test01/actions/workflows/7198850/dispatches \
  -d '{"ref":"develop"}'