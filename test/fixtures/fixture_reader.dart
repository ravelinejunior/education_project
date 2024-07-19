import 'dart:io';

String fixture(String fileName) =>
    File('test/fixtures/json/models/$fileName').readAsStringSync();
