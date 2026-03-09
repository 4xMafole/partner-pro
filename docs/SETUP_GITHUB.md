---
title: Setup - GitHub Actions
description: CI/CD workflows for automated releases
order: 4
---

# GitHub Setup

## Repository

Repository: `4xMafole/partner-pro` (private)

## Branch Strategy

- `main`  production-ready code
- Feature branches: `feature/<name>`
- Bug fixes: `fix/<name>`

## GitHub Actions

Three workflows are configured in `.github/workflows/`:

| Workflow              | Trigger           | Purpose                |
|-----------------------|-------------------|------------------------|
| `ci.yml`              | Push / PR to main | Analyze + test         |
| `release-android.yml` | Tag `v*`           | Build APK + AAB        |
| `release-ios.yml`     | Tag `v*`           | Build IPA              |

## Required Secrets

Add these in GitHub -> Settings -> Secrets and variables -> Actions:

### App Secrets (from `.env.example`)

All variables listed in `.env.example` must be added as individual secrets.

### Android Signing

| Secret                        | Description                          |
|-------------------------------|--------------------------------------|
| `ANDROID_KEYSTORE_BASE64`     | Base64-encoded upload keystore       |
| `ANDROID_KEYSTORE_PASSWORD`   | Keystore password                    |
| `ANDROID_KEY_PASSWORD`        | Key password                         |
| `ANDROID_KEY_ALIAS`           | Key alias                            |
| `GOOGLE_SERVICES_JSON`        | Base64-encoded google-services.json  |

### iOS Signing

| Secret                          | Description                          |
|---------------------------------|--------------------------------------|
| `IOS_P12_BASE64`               | Base64-encoded signing certificate   |
| `IOS_P12_PASSWORD`             | Certificate password                 |
| `IOS_PROVISION_PROFILE_BASE64` | Base64-encoded provisioning profile  |
| `KEYCHAIN_PASSWORD`            | Temporary keychain password           |
| `GOOGLE_SERVICE_INFO_PLIST`    | Base64-encoded GoogleService-Info.plist |

## Creating a Release

```bash
git tag v2.0.1
git push origin v2.0.1
```

This triggers both Android and iOS release workflows.
