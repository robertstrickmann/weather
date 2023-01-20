import 'dart:convert';
import 'dart:io';

String fixTestPath(String path) {
  var dir = Directory.current.path;
  if (dir.endsWith('/test')) {
    dir = dir.replaceAll('/test', '');
  }
  return '$dir/test/$path';
}

dynamic getTestJson(String path) =>
    json.decode(File(fixTestPath(path)).readAsStringSync());
