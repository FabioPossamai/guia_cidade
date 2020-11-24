import 'package:flutter/cupertino.dart';
import 'package:guiacidade/servicos/servico_autenticacao.dart';

class Provider extends InheritedWidget{
  final ServeicoAutenticacao auth;
  Provider({Key key, Widget child, this.auth}) : super(key: key, child: child);
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
  //se erro trocar por essa linha //static Provider of(BuildContext context) =>(context.inheritFromWidgetOfExactType(Provider) as Provider);
  static Provider of(BuildContext context) =>(context.dependOnInheritedWidgetOfExactType<Provider>());
}