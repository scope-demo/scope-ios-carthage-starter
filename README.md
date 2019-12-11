# Scope: Getting Started
A starter iOS/carthage project instrumented with [Scope](https://scope.undefinedlabs.com). It uses standard [GitHub Actions](https://github.com/features/actions) fur building and testing.

This starter project is based on:
- [Xcode](https://developer.apple.com/xcode/)
- [Carthage](https://github.com/Carthage/Carthage)

## Install Scope on Xcode projects with GitHub Actions

The project needs to add a new `ScopeAgent` dependency to the Cartfile, and run the tests

Finally, the build and test action has been configured in the GitHub Workflow `main.yml` file setting the user API key as a environment variable:

```yaml
name: Scope Testing

on: [push]

jobs:
  scope:
    runs-on: macOS-latest
    
    steps:
      - name: Check if SCOPE_APIKEY is set
        run: if [ "${{secrets.SCOPE_APIKEY}}" = "" ]; then exit 1; fi
      - name: Checkout
        uses: actions/checkout@v1
      - name: Switch XCode Version
        run: sudo xcode-select -s /Applications/Xcode_11.app
      - name: Build and test
        run: |
          carthage update --platform iOS
          xcodebuild test -scheme scope-ios-carthage-starter -destination 'platform=iOS Simulator,name=iPhone 11,OS=13.0' 
        env:
          SCOPE_APIKEY: ${{secrets.SCOPE_APIKEY}}
```

For further information about how to install Scope, go to [Scope iOS Agent Installation](https://docs.scope.dev/docs/ios-installation)

## Running Scope on GitHub Actions

1. Click on `Use this template` button and create the repository in your namespace.
2. Access to [app.scope.dev](https://app.scope.dev). 
3. Add/Modify your namespace to include your new repository.
4. Get the API Key for your new repository.
5. Go to your repository on [GitHub](https://github.com)
6. Go to `Settings` -> `Secrets`.
7. Add your API Key secret.
    - Name: `SCOPE_APIKEY`
    - Value: `<<your APIKEY>>`
8. Click on `Actions` button and access to the workflow.
9. Click on `Re-run checks`.

Once GitHub Workflow has finished, you can check the test executions report on [app.scope.dev](https://app.scope.dev)

