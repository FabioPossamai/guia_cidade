import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guiacidade/servicos/servico_autenticacao.dart';
import 'package:guiacidade/telas/bares/bares.dart';
import 'package:guiacidade/telas/criar_usuario.dart';
import 'package:guiacidade/telas/home_view.dart';
import 'package:guiacidade/widgets/provider.dart';
import 'package:guiacidade/telas/primeira_tela.dart';
import 'package:guiacidade/home_widget.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      auth: ServeicoAutenticacao(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Guia Da Cidade',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: HomeController(),
          routes: <String, WidgetBuilder>{
            '/criarconta': (BuildContext context) => CriarUsuario(authFormType: AuthFormType.criarconta,),
            '/login': (BuildContext context) => CriarUsuario(authFormType: AuthFormType.login,),
            '/home': (BuildContext context) => HomeController(),
          }
      ),
    );
  }
}

class HomeController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ServeicoAutenticacao auth = Provider.of(context).auth;
    return StreamBuilder<String>(
      stream: auth.onAuthStateChanged,
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final bool criarconta = snapshot.hasData;
          return criarconta ? Home() : primeiraTela();
        }
        return CircularProgressIndicator();
      },
    );
  }
}


