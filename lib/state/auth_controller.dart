import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart'; //localstorage

class AuthController extends ValueNotifier<bool> {
  AuthController._() : super(false);

  static final AuthController instance = AuthController._();

  static const _prefsKey = 'flower_is_logged_in';

  //di panggil sekali saat aplikasi baru di buka akan memunculkan splasscreen
  //untuk membaca status login yg tersimpan dari sesi SEBELUMNYA
  Future<void> loadPeristedSession() async {
    final prefs = await SharedPreferences.getInstance();
    value = prefs.getBool(_prefsKey) ?? false;
  }

  Future<void> login() async {
    value = true;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefsKey, true);
  }

  Future<void> logout() async {
    value = false;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefsKey, false);
  }
}