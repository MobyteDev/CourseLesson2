import 'package:auth_test/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'info.dart';

class AuthPage extends StatelessWidget {
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _loginKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _passwordKey = GlobalKey<FormState>();
  AuthBloc bloc;
  bool validate() {
    return _loginKey.currentState.validate() &&
        _passwordKey.currentState.validate();
  }

  void signIn() {
    if (validate())
      bloc.add(SignInEvent(
          email: loginController.text, password: passwordController.text));
  }

  void signUp() {
    if (validate())
      bloc.add(SignUpEvent(
          email: loginController.text, password: passwordController.text));
  }

/*
 if(validate())
              {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => InfoPage(name: loginController.text),),);
              }
*/
  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<AuthBloc>(context);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          child: BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
            if (state is AuthInitial) {
              if (state.error) {
                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text(state.errorText)));
              }
              if (state.success) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => InfoPage(name: loginController.text),
                  ),
                );
              }
            }
          }, builder: (context, state) {
            if (state is AuthInitial) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: Text(
                    "Авторизация",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                    ),
                  )),
                  SizedBox(height: 40),
                  InputForm.login(loginController, _loginKey),
                  SizedBox(height: 15),
                  InputForm.password(passwordController, _passwordKey),
                  SizedBox(height: 20),
                  SignButton.enter(action: signIn),
                  SignButton.reg(action: signUp),
                ],
              );
            }
            if (state is LoadingState) {
              return Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    Text("Loading..."),
                  ],
                ),
              );
            }
          }),
        ),
      ),
    );
  }
}

class SignButton extends StatelessWidget {
  final VoidCallback action;
  final String textCaption;

  const SignButton.enter({
    Key key,
    @required this.action,
  })  : textCaption = "Войти",
        super(key: key);
  const SignButton.reg({
    Key key,
    @required this.action,
  })  : textCaption = "Зарегистрироваться",
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: RawMaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        fillColor: Color(0xAA98D2F5),
        splashColor: Color(0xFFFDD2FF),
        onPressed: action,
        child: Text(textCaption),
      ),
    );
  }
}

class InputForm extends StatefulWidget {
  final TextEditingController controller;
  final String Function(String) validator;
  final String _hint;
  final GlobalKey<FormState> _key;

  final bool _passwordField;

  final IconData _icon;

  InputForm.login(this.controller, this._key)
      : _hint = "Логин",
        _icon = Icons.person,
        validator = _loginValid,
        _passwordField = false;
  InputForm.password(this.controller, this._key)
      : _hint = "Пароль",
        _icon = Icons.vpn_key,
        validator = _passwordValid,
        _passwordField = true;

  static String _loginValid(String value) {
    if (value.length < 2) return "Логин слишком короткий!";
    return null;
  }

  static String _passwordValid(String value) {
    if (value.length < 2) return "Пароль слишком короткий!";
    if (!value.contains("42")) return "Неправильный пароль";
    if (!value.contains(RegExp(r'[a-zA-Zа-яА-Я]')))
      return "Пароль должен содержать как минимум 1 букву!";
    return null;
  }

  @override
  _InputFormState createState() => _InputFormState(_passwordField);
}

class _InputFormState extends State<InputForm> {
  bool _hide;
  _InputFormState(this._hide);
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget._key,
      child: TextFormField(
        validator: widget.validator,
        controller: widget.controller,
        obscureText: _hide,
        decoration: InputDecoration(
            filled: true,
            prefixIcon: Icon(widget._icon),
            suffixIcon: widget._passwordField
                ? GestureDetector(
                    excludeFromSemantics: true,
                    onTap: () {
                      setState(() {
                        _hide = !_hide;
                      });
                    },
                    child:
                        Icon(_hide ? Icons.visibility : Icons.visibility_off),
                  )
                : null,
            hintText: widget._hint,
            fillColor: Color(0xAA98D2F5),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
      ),
    );
  }
}
