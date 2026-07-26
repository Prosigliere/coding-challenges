# Maestro Mobile UI Testing - POC

This directory contains a proof of concept (POC) for automating iOS and Android mobile app testing using [Maestro](https://maestro.mobile.dev/), an open-source mobile UI testing framework.

## Overview

Maestro is a powerful, declarative testing framework that allows you to write mobile UI tests in simple YAML files. It supports both iOS and Android platforms and provides built-in tolerance for flakiness and delays, making it ideal for mobile app testing.

## Directory Structure

```
maestro/
├── README.md              # This file
├── config/
│   └── config.yaml        # Global configuration and test organization
├── flows/                 # Main test flows
│   ├── launch_app.yaml           # Basic app launch test
│   ├── ios_launch_app.yaml       # iOS-specific launch test
│   ├── view_all_characters.yaml  # View all characters list
│   ├── view_students.yaml        # Filter and view students
│   ├── view_staff.yaml           # Filter and view staff
│   ├── character_detail.yaml     # Navigate to character details
│   ├── favorites.yaml            # Favorite characters functionality
│   ├── house_selection.yaml      # Hogwarts house preference
│   ├── profile_photo.yaml        # Camera/profile photo feature
│   ├── spells.yaml               # Spells view (optional feature)
│   └── full_user_journey.yaml    # End-to-end user journey test
└── subflows/              # Reusable test components
    ├── common_navigation.yaml
    └── navigate_to_settings.yaml
```

## Prerequisites

### Install Maestro

**macOS:**
```bash
curl -Ls "https://get.maestro.mobile.dev" | bash
```

**Linux:**
```bash
curl -Ls "https://get.maestro.mobile.dev" | bash
```

**Windows:**
Maestro requires WSL2 on Windows. Install WSL2 first, then run the Linux installation command.

### Verify Installation
```bash
maestro --version
```

### Platform Requirements

**For Android:**
- Android SDK installed
- Android emulator running OR physical device connected via ADB
- App installed on the device/emulator

**For iOS:**
- macOS with Xcode installed
- iOS Simulator running OR physical device connected
- App installed on the simulator/device

## Configuration

Before running tests, update the app identifiers in `config/config.yaml`:

```yaml
env:
  ANDROID_APP_ID: "com.your.app.id"  # Your Android app package name
  IOS_APP_ID: "com.your.app.id"      # Your iOS app bundle identifier
```

## Running Tests

### Run a Single Flow
```bash
# Run a specific test flow
maestro test flows/launch_app.yaml

# Run with environment variables
maestro test -e ANDROID_APP_ID=com.your.app flows/launch_app.yaml
```

### Run All Flows
```bash
# Run all flows in the flows directory
maestro test flows/
```

### Run Tests by Tag
```bash
# Run smoke tests only
maestro test --include-tags=smoke flows/

# Run regression tests
maestro test --include-tags=regression flows/

# Exclude certain tags
maestro test --exclude-tags=optional flows/
```

### Run on Specific Device
```bash
# List available devices
maestro test --list-devices

# Run on a specific device
maestro test --device=emulator-5554 flows/launch_app.yaml
```

### Continuous Mode (Development)
```bash
# Automatically re-run tests when files change
maestro test --continuous flows/launch_app.yaml
```

## Test Flows Description

| Flow | Description | Tags |
|------|-------------|------|
| `launch_app.yaml` | Verifies the app launches successfully | smoke, launch |
| `ios_launch_app.yaml` | iOS-specific app launch test | smoke, launch, ios |
| `view_all_characters.yaml` | Tests the main characters list view | smoke, characters |
| `view_students.yaml` | Tests filtering to show only students | characters, filter |
| `view_staff.yaml` | Tests filtering to show only staff | characters, filter |
| `character_detail.yaml` | Tests navigation to character detail view | characters, navigation, detail |
| `favorites.yaml` | Tests favoriting characters and viewing favorites | favorites, user-interaction |
| `house_selection.yaml` | Tests Hogwarts house preference selection | settings, house, ui-styling |
| `profile_photo.yaml` | Tests camera functionality for profile photo | settings, camera, profile |
| `spells.yaml` | Tests spells view (optional feature) | spells, optional |
| `full_user_journey.yaml` | End-to-end test covering complete user experience | e2e, regression, user-journey |

## Maestro Studio

Maestro Studio provides a visual interface for creating and debugging tests:

```bash
# Launch Maestro Studio
maestro studio
```

This opens a browser-based interface where you can:
- See the device screen in real-time
- Inspect UI elements and their properties
- Generate test commands by clicking on elements
- Debug failing tests

## CI/CD Integration

### GitHub Actions Example

```yaml
name: Mobile UI Tests

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  maestro-tests:
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Install Maestro
        run: curl -Ls "https://get.maestro.mobile.dev" | bash
        
      - name: Start iOS Simulator
        run: |
          xcrun simctl boot "iPhone 15"
          
      - name: Install App
        run: |
          xcrun simctl install booted path/to/your/app.app
          
      - name: Run Maestro Tests
        run: |
          export PATH="$PATH:$HOME/.maestro/bin"
          maestro test --format junit --output results.xml maestro/flows/
          
      - name: Upload Test Results
        uses: actions/upload-artifact@v4
        if: always()
        with:
          name: test-results
          path: results.xml
```

### Maestro Cloud

For running tests in the cloud without managing infrastructure:

```bash
# Upload and run tests on Maestro Cloud
maestro cloud --apiKey YOUR_API_KEY flows/
```

## Writing Custom Tests

### Basic Flow Structure

```yaml
# flow_name.yaml
appId: com.your.app.id
name: "Test Name"
tags:
  - smoke
  - custom

---

# Commands go here
- launchApp
- tapOn: "Button Text"
- assertVisible: "Expected Text"
```

### Common Commands

| Command | Description | Example |
|---------|-------------|---------|
| `launchApp` | Launch the app | `- launchApp` |
| `tapOn` | Tap on an element | `- tapOn: "Button"` |
| `inputText` | Enter text | `- inputText: "Hello"` |
| `assertVisible` | Verify element is visible | `- assertVisible: "Text"` |
| `scroll` | Scroll the screen | `- scroll: direction: DOWN` |
| `back` | Press back button | `- back` |
| `takeScreenshot` | Capture screenshot | `- takeScreenshot: "name"` |

### Using Selectors

```yaml
# By text
- tapOn: "Login"

# By ID
- tapOn:
    id: "login_button"

# By index
- tapOn:
    index: 0

# With regex
- assertVisible:
    text: ".*Potter.*"
    regex: true
```

## Troubleshooting

### Common Issues

1. **App not found**: Ensure the app is installed and the `appId` matches the package name/bundle identifier.

2. **Element not found**: Use Maestro Studio to inspect the UI hierarchy and find the correct selector.

3. **Timeout errors**: Increase the timeout in `extendedWaitUntil` commands.

4. **Flaky tests**: Add `optional: true` to commands that may not always succeed, or use `retry` blocks.

### Debug Mode

```bash
# Run with debug output
maestro test --debug flows/launch_app.yaml
```

### View Hierarchy

```bash
# Print the current UI hierarchy
maestro hierarchy
```

## Resources

- [Maestro Documentation](https://maestro.mobile.dev/)
- [Maestro GitHub Repository](https://github.com/mobile-dev-inc/maestro)
- [Maestro Cloud](https://maestro.dev/cloud)
- [API Reference](https://maestro.mobile.dev/api-reference/commands)
