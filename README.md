[![pytest](https://github.com/Shigeki-Nagaya/cicd_test01/actions/workflows/pytest_to_codecov.yaml/badge.svg?branch=develop)](https://github.com/Shigeki-Nagaya/cicd_test01/actions/workflows/pytest_to_codecov.yaml)

# cicd_test01

## Finished ToDo
- [x] pytest
- [x] add badge for actions
- [x] skicka setup for gdrive access
- [x] copy from gdrive
- [x] copy to gdrive
- [x] make build script

- [x] Debug settings: Debug flag ACTIONS_RUNNER_DEBUG
- [x] Debug settings: Debug flag ACTIONS_STEP_DEBUG
- [x] Debug settings: Debug tool - act
- [x] Debug settings: Add trigger workflow_dispatch


## WIP Todo
- [ ] make publish script (Publish for STB directly)
- [ ] make publish script (Publish for Crew Gmail)

---

# Create Workflow dispatch event

### Setting Private Token
```
# TOKEN

export GIT_TOKEN=19e9a0d4834884************
```

### Publish Event
```
# Command
curl \                                                                  
  -H "Accept: application/vnd.github.v3+json" \
  -H "Authorization: token $GIT_TOKEN" \
  https://api.github.com/repos/Shigeki-Nagaya/cicd_test01/actions/workflows/7198850/dispatches \
  -d '{"ref":"develop"}'
```


