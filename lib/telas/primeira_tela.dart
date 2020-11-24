import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:guiacidade/widgets/DialogCustomisado.dart';


class primeiraTela extends StatelessWidget {
  final primarayColor = const Color(0xFF75a2ea);
  @override
  Widget build(BuildContext context) {
    final _width =MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
          width: _width,
          height: _height,
          color: primarayColor,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                      height: _height * 0.10
                  ),
                  Text("Bem Vindo", style: TextStyle(fontSize: 44, color: Colors.white),),
                  SizedBox(
                      height: _height * 0.10
                  ),
                  AutoSizeText(
                    "O que você procura",
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 40, color: Colors.white
                    ),
                  ),
                  SizedBox(
                      height: _height * 0.15
                  ),
                  RaisedButton(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 30, right: 30),
                      child: Text("Iniciar", style: TextStyle(color: primarayColor, fontSize: 28, fontWeight: FontWeight.w300),),
                    ),
                    onPressed: (){
                      showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              DialogCustomisado(
                                title: "Deseja criar uma conta gratuita",
                                description: "com uma conta, seus dados serão salvos em segurança, permitindo que você os acesse a partir de vários dispositivos",
                                primaryButtonText: "Criar uma Conta",
                                primaryButtonRoute: "/criarconta",
                                secondaryButtonText: "Talvez mais tarde",
                                secondaryButtonRoute: "/home",
                              )
                      );
                    },
                  ),
                  SizedBox(height: _height * 0.05),
                  FlatButton(
                    child: Text("Logar-se", style: TextStyle(color: Colors.white,fontSize: 25),
                    ),
                    onPressed: (){
                      Navigator.of(context).pushReplacementNamed('/login');
                    },
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}
