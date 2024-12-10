import 'package:flutter/material.dart';
import 'package:flutter_manager_product/app/Services/client_http_service.dart';
import 'package:flutter_manager_product/app/repositories/user_repository.dart';
import 'package:flutter_manager_product/app/store/auth_store.dart';
import '../../utils/decoration_field_auth.dart';
import '../../utils/my_colors.dart';
import '../home/home_page.dart';
import 'auth_controller.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  late final AuthController _authController;

  @override
  void initState() {
    super.initState();
    _authController = AuthController(
        AuthStore(
          UserRepository(
            ClientHttpService(),
          ),
        ),
    );
  }

  @override
  void dispose() {
    _authController.dispose();
    super.dispose();
  }

  void _handleLogin(context) async {
    if (_authController.formKey.currentState?.validate() ?? false) {
      final username = _authController.usernameController.text;
      final password = _authController.passwordController.text;

      try {
        await _authController.login(username, password);

        if (_authController.token != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Bem-vindo, $username!')),
          );
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$username não autenticado!')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  void _handleRegister(context) async {
    if (_authController.formKey.currentState?.validate() ?? false) {
      final username = _authController.usernameController.text;
      final password = _authController.passwordController.text;
      final confirmPassword = _authController.confirmPasswordController.text;
      final type = _authController.typeController.text;

      try {
        await _authController.register(username, password, confirmPassword, type);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Cadastro feito, $username!')),
        );
        _authController.changeIsNotSigned();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _authController.isNotSigned,
      builder:(context, isNotSigned, child) => Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _authController.formKey,
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          "Products App",
                          style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: MyColors.redFla),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        TextFormField(
                          decoration: getAuthInputDecoration("Username"),
                          controller: _authController.usernameController,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "Empty Field";
                            }
                            if (value.length < 3) {
                              return "This username is very short";
                            }

                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        TextFormField(
                          decoration: getAuthInputDecoration("Password"),
                          obscureText: true,
                          controller: _authController.passwordController,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "Empty Field";
                            }
                            if (value.length < 5) {
                              return "This password is very short";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Visibility(
                            visible: _authController.isNotSigned.value,
                            child: Column(
                              children: [
                                TextFormField(
                                  decoration:
                                      getAuthInputDecoration("Confirm password"),
                                  controller: _authController.confirmPasswordController,
                                  obscureText: true,
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return "Empty Field";
                                    }
                                    if (value.length < 5) {
                                      return "The password is very short";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                TextFormField(
                                  decoration: getAuthInputDecoration("type"),
                                  controller: _authController.typeController,
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return "Empty Field";
                                    }
                                    if (value != 'admin' && value != 'standard') {
                                      return "The type must be 'admin' or 'standard'";
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            )),
                        const SizedBox(
                          height: 16,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            (!_authController.isNotSigned.value) ? _handleLogin(context) : _handleRegister(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MyColors.redFla,
                          ),
                          child: Text(
                            (!_authController.isNotSigned.value) ? "Sign-in" : "Sign-up",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextButton(
                            onPressed: () {
                              _authController.changeIsNotSigned();
                            },
                            child: const Text(
                              "Don't have an account? Sign-up",
                              style: TextStyle(color: MyColors.redFla),
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
