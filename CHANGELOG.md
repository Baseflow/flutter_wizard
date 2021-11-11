## 1.0.0
* Initial release

## 1.0.1
* Added responsive wizard example GIF

## 1.0.2
* The disableGoBack method now automatically animates back if needed

## 2.0.0
* The `WizardController` now contains a `eventStream` property
* The `WizardEventListener` is added
  
**BREAKING CHANGES:**
* Some `WizardController` functions names have changed:
  * The `next` is renamed to `goNext`
  * The `previous` is renamed to `goBack`
  * The `animateTo` is renamed to `goTo`
  * The `getIsAnimateToEnabledStream` is renamed to `getIsGoToEnabledStream`
  * The `getIsAnimateToEnabled` is renamed to `getIsGoToEnabled`

## 2.0.1
* Downgraded the `rxdart` package to `^0.26.0`

## 2.0.2
* Added the author to the readme