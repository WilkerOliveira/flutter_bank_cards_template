# Mobile Bank Template

|  <img src='http://wilkeroliveira.cloudapp.net/mwmobile/bank-cards-01.png' width="30%" /> |  <img src='http://wilkeroliveira.cloudapp.net/mwmobile/bank-cards-02.png' width="30%" /> |  <img src='http://wilkeroliveira.cloudapp.net/mwmobile/bank-cards-03.png' width="30%" /> |  <img src='http://wilkeroliveira.cloudapp.net/mwmobile/bank-cards-04.png' width="30%" /> |
| :------------: | :------------: | :------------: | :------------: |
| Login |  Register | Main  | Statement  |


This is a template of mobile bank under development and migrating from a private server to Cloud Firestore.

In this model, I am using Consumer, Selector and StreamProvider just to show how easy they are to use.

Some items that should be implemented soon:

    - Exceptions
    - Unit tests

### This app use other plugins like:

- [flutter_svg](https://pub.dev/packages/flutter_svg)
- [flutter_swiper](https://pub.dev/packages/flutter_swiper)
- [brasil_fields](https://pub.dev/packages/brasil_fields)
- [Flutter Provider v3 Architecture](https://medium.com/flutter-community/flutter-provider-v3-architecture-using-proxyprovider-for-injection-62cf5c58ea52)


#### Extra infos

* Run this command to update your JSON parser
```sh
flutter pub run build_runner watch --delete-conflicting-outputs
```
* Run this command to create or update the internationalization strings
```sh
flutter pub run gen_lang:generate
```

#### P.S.: I am not a designer :)
