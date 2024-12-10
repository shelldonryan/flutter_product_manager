import 'package:flutter/material.dart';
import 'package:flutter_manager_product/app/store/auth_store.dart';

class AuthController {
  final AuthStore _authStore;

  AuthController(this._authStore);

  final _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> _isNotSigned = ValueNotifier<bool>(false);
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _confirmPasswordController =
  TextEditingController();

  String? get token => _authStore.token;
  GlobalKey<FormState> get formKey => _formKey;
  ValueNotifier<bool> get isNotSigned => _isNotSigned;
  TextEditingController get usernameController => _usernameController;
  TextEditingController get typeController => _typeController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get confirmPasswordController =>
      _confirmPasswordController;

  changeIsNotSigned() {
    _isNotSigned.value = !_isNotSigned.value;
  }

  Future<void> login(String username, String password) async {
    await _authStore.login(username, password);
  }

  Future<void> register(String username, String password, String confirmPassword, String type) async {
      _authStore.register(username, password, confirmPassword, type);
  }

  dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _typeController.dispose();
    _typeController.dispose();
  }
}