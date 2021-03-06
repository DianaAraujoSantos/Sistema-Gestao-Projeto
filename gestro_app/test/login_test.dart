import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:gestro_app/pages/login.page.dart';
import 'package:gestro_app/widgets/buttonGestro.widget.dart';
import 'package:gestro_app/widgets/inputGestro.widget.dart';

void main() {
  Widget buildTestableWidget(Widget widget) {
    return MediaQuery(data: MediaQueryData(), child: MaterialApp(home: widget));
  }

  testWidgets('Teste da Tela de Login', (WidgetTester tester) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await tester.pumpWidget(buildTestableWidget(LoginScreen()));

    // texto "Login"
    var textLogin = find.text("Login");
    expect(textLogin, findsNWidgets(2));

    // container gestro
    var containerGestro = find.byType(InputGestro);
    expect(containerGestro, findsNWidgets(2));

    var textEmail = find.text("Email");
    expect(textEmail, findsOneWidget);

    var textSenha = find.text("Senha");
    expect(textSenha, findsOneWidget);

    // botão
    var buttonGestro = find.byType(ButtonGestro);
    expect(buttonGestro, findsOneWidget);

    // textos finais
    var textNaoPossuiCadastro = find.text("Não possui cadastro?");
    expect(textNaoPossuiCadastro, findsOneWidget);

    var textCadastrarSe = find.text("Cadastrar-se.");
    expect(textCadastrarSe, findsOneWidget);
  });
}
