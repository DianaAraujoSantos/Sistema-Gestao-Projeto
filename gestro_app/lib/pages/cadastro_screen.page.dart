import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:gestro_app/pages/login_screen.page.dart';
import 'package:gestro_app/themes/globals.themes.dart';
import 'package:gestro_app/widgets/button2Gestro.widget%20copy.dart';
import 'package:gestro_app/widgets/buttonGestro.widget.dart';
import 'package:gestro_app/widgets/containerGestro.widget.dart';

import '../globals.dart';

class CadastroScreen extends StatefulWidget {
  final formKey = GlobalKey<FormState>();

  @override
  _CadastroScreenState createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    Map<String, dynamic> docData = new Map();

    Future<User> signUp(email, password) async {
      try {
        UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
        assert(userCredential.user != null);
        assert(await userCredential.user.getIdToken() != null);
        return userCredential.user;
      } catch (e) {
        return null;
      }
    }

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "assets/BkRegisterScreen.png",
              ),
              fit: BoxFit.cover),
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        //Form key
        child: Form(
          key: widget.formKey,
          child: ListView(
            // physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 35),
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 245),
                child: Center(
                  child: Text(
                    "Cadastro",
                    style: TextStyle(color: Colors.purple, fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              ContainerGestro(
                text: "Nome",
                icon: Icon(
                  Icons.person,
                  color: purpleSecudary,
                ),
                qtdeLengthCharacters: 50,
                valueForm: nome,
                onSaved: (input) => nome = input,
              ),
              ContainerGestro(
                text: "Email",
                icon: Icon(
                  Icons.mail,
                  color: purpleSecudary,
                ),
                qtdeLengthCharacters: 35,
                valueForm: email,
                onSaved: (input) => email = input,
              ),
              ContainerGestro(
                text: "Linkedin",
                icon: Icon(
                  FontAwesome.link,
                  color: purpleSecudary,
                ),
              ),
              ContainerGestro(
                text: "Senha",
                passVisible: true,
                icon: Icon(
                  Icons.lock,
                  color: purpleSecudary,
                ),
                qtdeLengthCharacters: 15,
                valueForm: senha,
                onSaved: (input) => senha = input,
              ),
              ContainerGestro(
                text: "Confirme a senha",
                passVisible: true,
                icon: Icon(
                  Icons.lock,
                  color: purpleSecudary,
                ),
                qtdeLengthCharacters: 15,
              ),
              GestureDetector(
                // padding: EdgeInsets.all(0),
                onTap: () {
                  if (widget.formKey.currentState.validate()) {
                    widget.formKey.currentState.save();

                    signUp(email, senha).then((value) {
                      docData['name'] = nome;
                      docData['email'] = email;
                      docData['password'] = senha;
                      docData['type'] = 'Aluno';
                      docData['created_at'] = Timestamp.now();
                      docData['updated_at'] = Timestamp.now();
                      FirebaseFirestore.instance.collection('Users').doc(value.uid).set(docData);
                      Navigator.pop(context);
                    });
                  }
                },
                child: ButtonGestro(
                  text: 'Cadastrar',
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 25),
                    child: Text(
                      "Já possui cadastro?",
                      style: TextStyle(fontSize: 16, color: Colors.purple),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 25, left: 5),
                    child: InkWell(
                      child: Text(
                        "Faça login.",
                        style: TextStyle(fontSize: 16, color: Colors.purple, fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        Future.delayed(
                          Duration(
                            milliseconds: 0,
                          ),
                        ).then(
                          (_) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
