# Mobile App Review Reference

Use for iOS, macOS, Android, React Native, Flutter, Kotlin, Swift, or cross-platform mobile/desktop apps.

## Platform Risks

- Lifecycle: background/foreground, cancellation, app termination, scene/window changes.
- Permissions: camera, location, notifications, storage, contacts, Bluetooth.
- Offline behavior: retries, cached state, conflict handling.
- Secure storage: tokens and secrets should use platform keychain/keystore equivalents.
- Accessibility: dynamic type, screen readers, contrast, focus order.

## iOS/macOS

- Check MainActor/UI-thread correctness.
- Avoid retain cycles in closures, delegates, Combine, timers, and observers.
- Confirm entitlements, Info.plist usage descriptions, sandbox permissions, and signing assumptions.
- For SwiftUI, look for large views with mixed responsibilities and unstable identity in lists.

## Android

- Check lifecycle-aware collection, cancellation, and configuration changes.
- Avoid leaking Activity/Context.
- Confirm manifest permissions and exported components.
- Check navigation back-stack and saved-state behavior.

## Verification

- Prefer platform build/test tools where available.
- For UI changes, verify at least one small and one large viewport/device class when feasible.

