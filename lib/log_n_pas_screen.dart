import 'package:auth_test/xylophone.dart';
import 'package:flutter/material.dart';

class LogNPass extends StatelessWidget {
  final TextEditingController _login = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final GlobalKey<FormState> _loginKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _passwordKey = GlobalKey<FormState>();

  bool check() {
    bool loginCheck =  _loginKey.currentState.validate();
        bool passCheck = _passwordKey.currentState.validate();
        return loginCheck && passCheck;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                "Авторизация",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
              ),
            ),
            AuthField.login(_login, _loginKey),
            //SizedBox(height: 12),
            AuthField.password(_password, _passwordKey),
              RawMaterialButton(
              child: Text("GO"),
              fillColor: Colors.orange[50],
              splashColor: Colors.blue,
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Xylophone(),),);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AuthField extends StatelessWidget {
  final TextEditingController controller;
  final String _text;
  final IconData _icon;
  final GlobalKey<FormState> _key;
  final String Function(String) _validator;

  static String _loginValidator(String value) {
    if (value.isEmpty) {
      return "Логин не может быть пустым!";
    }
    if (value.length < 2) {
      return "Логин слишком короткий!";
    }
    return null;
  }

  static String _passwordValidator(String value) {
    if (value.isEmpty) {
      return "Пароль не может быть пустым!";
    }
    if (value.length < 5) {
      return "Пароль слишком короткий!";
    }
    if (!value.contains(RegExp(r'[a-zA-Z]'))) {
      return "В пароле должна быть хотя бы одна буква!";
    }
    return null;
  }

  AuthField.login(this.controller, this._key)
      : _text = "Логин",
        _icon = Icons.person,
        _validator = _loginValidator;
  AuthField.password(this.controller, this._key)
      : _text = "Пароль",
        _icon = Icons.vpn_key,
        _validator = _passwordValidator;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: TextFormField(
        validator: _validator,
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xAA98D2F5),
          hintText: _text,
          prefixIcon: Icon(_icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
