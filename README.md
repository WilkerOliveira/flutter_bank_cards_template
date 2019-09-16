# Bank Cards Template

This is a template of bank cards under development and migrating from a private server to Cloud Firestore.

Some items that should be implemented soon:

    - Exceptions
    - Log in
    - Unit tests

### This app use other plugins like:

- [flutter_svg](https://pub.dev/packages/flutter_svg)
- [flutter_swiper](https://pub.dev/packages/flutter_swiper)
- [brasil_fields](https://pub.dev/packages/brasil_fields)
- [curved_navigation_bar](https://pub.dev/packages/curved_navigation_bar)


#### Extra infos

* Run this command to update your JSON parser
```sh
flutter pub run build_runner watch --delete-conflicting-outputs
```
* Run this command to create or update the internationalization strings
```sh
flutter pub run gen_lang:generate
```