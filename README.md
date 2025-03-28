`flutter pub add hive_ce hive_ce_flutter dev:hive_ce_generator dev:build_runner`
`flutter pub add http`
Do  'DebugProfile.entitlements' w macos/Runner/' dodaj:
`<key>com.apple.security.network.client</key>
<true/>`

1. W pliku 'hive_boxes.dart' utwórz `const productBox = 'product_box';`
2. W main.dart zainicjuj Hive dla fluttera i otwórz box
3. W pliku, w którym potrzebujesz danych z boxa pobierz do zmiennej te dane
4. Generowanie adapterów: stwórz katalog 'hive', a w nim plik 'hive_adapters.dart'.
5. Klasę, której obiekty będą w boxie rozszerz z 'HiveObject'.
6. Wygeneruj adaptery: `dart run build_runner build --delete-conflicting-outputs`.
7. Zarejestruj adaptery w main.dart.
8. Teraz użyj 'ValueListenableBuilder' by uzyskać dostęp do boxa.
9. Użyj metody `box.add(item)` by dodawać do boxa, `final matchingProduct = box.values.where((Product existingProduct) {
   return existingProduct.id == product.id;
   }).firstOrNull;` by filtrować itemy.
10. Użyj `productBox.put(product.key, product);` by aktualizować element
11. Użyj `Hive.box<Product>(productBox).clear` by czyścić box
12. Użyj `box.delete(product.key)` by usuwać obiekty