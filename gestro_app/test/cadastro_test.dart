import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:gestro_app/pages/cadastro.page.dart';
import 'package:gestro_app/widgets/buttonGestro.widget.dart';
import 'package:gestro_app/widgets/inputGestro.widget.dart';

void main() {
  Widget buildTestableWidget(Widget widget) {
    return MediaQuery(data: MediaQueryData(), child: MaterialApp(home: widget));
  }

  testWidgets('Teste da Tela de Cadastro', (WidgetTester tester) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await tester.pumpWidget(buildTestableWidget(CadastroScreen()));

    // texto "Cadastro"
    var textCadastro = find.byKey(ValueKey("CadastroTextKey"));
    expect(textCadastro, findsOneWidget);

    // container gestro
    var containerGestro = find.byType(InputGestro);
    expect(containerGestro, findsNWidgets(5));

    var textNome = find.text("Nome");
    expect(textNome, findsOneWidget);

    var textEmail = find.text("Email");
    expect(textEmail, findsOneWidget);

    var textSenha = find.text("Senha");
    expect(textSenha, findsOneWidget);

    var textSenhaConfirm = find.text("Confirme a senha");
    expect(textSenhaConfirm, findsOneWidget);

    // botão
    var buttonGestro = find.byType(ButtonGestro);
    expect(buttonGestro, findsOneWidget);

    // textos finais
    var textJaPossuiCadastro = find.text("Já possui cadastro?");
    expect(textJaPossuiCadastro, findsOneWidget);

    var textFacaLogin = find.text("Faça login.");
    expect(textFacaLogin, findsOneWidget);
  });
}
