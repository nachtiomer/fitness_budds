import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:fitnessbudds/utils/storeTypes.dart';

class ApplicationStorage {
  static final ApplicationStorage _applicationStorage =
      ApplicationStorage._internal();
  ApplicationStorage._internal();

  factory ApplicationStorage() {
    return _applicationStorage;
  }

  static SharedPreferences _storage;
  static Map<String, Map<StoreTypes, Function>> _handlers =
      Map<String, Map<StoreTypes, Function>>();

  Future<bool> initStorage() async {
    try {
      _storage = await SharedPreferences.getInstance();
      _initHandlers();
    } catch (e) {
      print(e);
      return false;
    }
    return true;
  }

  void _initHandlers() {
    _handlers['get'] = Map<StoreTypes, Function>();
    _handlers['set'] = Map<StoreTypes, Function>();

    _handlers['set'][StoreTypes.INT] = _storage.setInt;
    _handlers['get'][StoreTypes.INT] = _storage.getInt;

    _handlers['set'][StoreTypes.STRING] = _storage.setString;
    _handlers['get'][StoreTypes.STRING] = _storage.getString;

    _handlers['set'][StoreTypes.BOOL] = _storage.setBool;
    _handlers['get'][StoreTypes.BOOL] = _storage.getBool;
  }

  Future<dynamic> getValue(String key, StoreTypes type) async {
    Function getter = type != null && _handlers['get'][type] != null
        ? _handlers['get'][type]
        : _handlers['get'][StoreTypes.STRING];
    dynamic result = await getter(key);
    return result;
  }

  void setValue(String key, dynamic value, [StoreTypes type]) async {
    Function setter = type != null && _handlers['set'][type] != null
        ? _handlers['set'][type]
        : _handlers['set'][StoreTypes.STRING];
    setter(key, value);
  }
}
