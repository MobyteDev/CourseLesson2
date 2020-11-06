import 'package:auth_test/xylophone.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audio_cache.dart';

extension on BuildContext {
  dropFocus() {
    FocusScope.of(this).requestFocus(FocusNode());
  }
}

class InfoPage extends StatelessWidget {
  final String name;
  InfoPage({this.name});

  final TextEditingController email = TextEditingController();
  final TextEditingController caption = TextEditingController();
  final TextEditingController birthDate = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();

  final FocusNode emailNode = FocusNode();
  final FocusNode captionNode = FocusNode();
  final FocusNode birthDayNode = FocusNode();
  final FocusNode phoneNode = FocusNode();

  bool emailError = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: true,
        appBar: AppBar(
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Xylophone()));
              },
              child: Icon(
                Icons.music_note,
              ),
            ),
          ],
        ),
        body: GestureDetector(
          onTap: () {
            context.dropFocus();
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
                Container(
                  width: 250,
                  height: 70,
                  child: Text(
                    "Привет " + name + ", расскажи о себе",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                TextForm(
                  changeNode: () => captionNode.requestFocus(),
                  node: emailNode,
                  controller: email,
                  function: (String value) {
                    if (!value.contains(RegExp(r"\w+@\w+")))
                      return 'Неправильный формат ввода';
                    return null;
                  },
                  hint: "email",
                  textInputType: TextInputType.emailAddress,
                ),
                TextForm(
                  changeNode: () => birthDayNode.requestFocus(),
                  node: captionNode,
                  controller: caption,
                  function: (String value) {
                    if (value.isEmpty) return 'Неправильный формат ввода';
                    return null;
                  },
                  hint: "Описание",
                  textInputType: TextInputType.text,
                ),
                TextForm(
                  changeNode: () => phoneNode.requestFocus(),
                  node: birthDayNode,
                  controller: birthDate,
                  function: (String value) {
                    if (value.isEmpty) return 'Неправильный формат ввода';
                    return null;
                  },
                  hint: "Дата рождения",
                  textInputType: TextInputType.datetime,
                ),
                TextForm(
                  changeNode: () => Focus.of(context).requestFocus(FocusNode()),
                  node: phoneNode,
                  controller: phoneNumber,
                  function: (String value) {
                    if (value.isEmpty) return 'Неправильный формат ввода';
                    return null;
                  },
                  hint: "Номер телефона",
                  textInputType: TextInputType.phone,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TextForm extends StatelessWidget {
  final TextEditingController controller;
  final Function function;
  final String hint;
  final FocusNode node;
  final TextInputType textInputType;
  final _formKey = GlobalKey<FormState>();
  final void Function() changeNode;

  TextForm({
    @required this.controller,
    @required this.function,
    @required this.hint,
    @required this.textInputType,
    @required this.node,
    @required this.changeNode,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Form(
        key: _formKey,
        child: TextFormField(
          focusNode: node,
          keyboardType: textInputType,
          controller: controller,
          validator: function,
          onFieldSubmitted: (String value) {
            if (_formKey.currentState.validate()) {
              changeNode();
            }
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            filled: true,
            fillColor: Color(0xAA98D2F5),
            hintText: hint,
          ),
        ),
      ),
    );
  }
}
