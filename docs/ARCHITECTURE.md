---
title: Architecture Overview
description: Clean architecture implementation with BLoC pattern
order: 1
---

# PartnerPro Architecture

## Overview

PartnerPro is a Flutter real-estate platform connecting **Buyers** and **Agents**.
It follows a **clean architecture** pattern with BLoC state management.

## Stack

| Layer          | Technology                                  |
|----------------|---------------------------------------------|
| UI             | Flutter / Material 3                        |
| State          | flutter_bloc + Freezed                      |
| Navigation     | GoRouter                                    |
| DI             | GetIt + Injectable                          |
| Backend        | Firebase (Auth, Firestore, Storage, FCM)    |
| Payments       | RevenueCat (`purchases_flutter`)            |
| E-Signature    | DocuSeal API                                |
| PDF Generation | ApiFlow                                     |
| Maps           | Google Maps Flutter                         |
| Push           | OneSignal                                   |

## Folder Structure

```
lib/
  core/           # Config, DI, network, services, constants
  features/       # Feature modules (property, offer, agent, auth, documents)
    <feature>/
      data/       # Datasources, repositories impl, models
      domain/     # Entities, repository contracts, use cases
      presentation/ # BLoCs, pages, widgets
  backend/        # Legacy FlutterFlow-generated Firebase code
  pages/          # Legacy FlutterFlow page widgets
  custom_code/    # Legacy FlutterFlow custom actions/widgets
  flutter_flow/   # FlutterFlow runtime utilities
```

## Data Flow

```
UI Widget -> BLoC (event) -> UseCase -> Repository -> DataSource -> Firebase/API
         <- BLoC (state) <- Either<Failure, T> <--------------------------'
```

## UI & Subsystem Patterns

- **Dialogs & Overlays:** All destructive or global confirmation prompts in the migration should use the generic `AppConfirmDialog` to preserve standardized theming and avoid `showDialog(builder: (context) => AlertDialog(...))` directly.
- **Snackbars:** Should use the custom `context.showSnackBar(...)` extension rather than direct `ScaffoldMessenger` scaffolding injections.
- **Loading states:** Always prefer inline skeleton or specific spinners over global page blocks. Modals should handle their own BLoC emission loading states.

## Environment

All secrets are injected at build time via `--dart-define-from-file=.env`.
See `.env.example` for the full list of required variables.
