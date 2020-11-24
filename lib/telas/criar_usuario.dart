import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:guiacidade/widgets/provider.dart';
import 'package:guiacidade/main.dart';
import 'package:guiacidade/servicos/servico_autenticacao.dart';

final primaryColor = const Color(0xFF75a2ea);
enum AuthFormType{criarconta, login, reset_senha}
class CriarUsuario extends StatefulWidget {
  final AuthFormType authFormType;

  CriarUsuario({Key key, @required this.authFormType}): super(key: key);
  @override
  _CriarUsuarioState createState() => _CriarUsuarioState(authFormType: this.authFormType);
}

class _CriarUsuarioState extends State<CriarUsuario> {
  AuthFormType authFormType;
  _CriarUsuarioState({this.authFormType});
  //variavel global
  final formkey = GlobalKey<FormState>();
  //variavel para cadastrar no firabase
  String _email, _password, _nome, _warning;

  //verificar o estado da aplicação
  void switchFormState(String state){
    formkey.currentState.reset();
    if(state == "criarconta"){
      setState(() {
        authFormType = AuthFormType.criarconta;
      });
    }else{
      setState(() {
        authFormType = AuthFormType.login;
      });
    }
  }

  bool validate(){
    final form = formkey.currentState;
    form.save();
    if(form.validate()){
      form.save();
      return true;
    }
    else{
      return false;
    }
  }
  void submit() async{
    final form = formkey.currentState;
    if(validate()) {
      try {
        final auth = Provider
            .of(context)
            .auth;
        if (authFormType == AuthFormType.login) {
          String uid = await auth.logarUsuarioEmailSenha(_email, _password);
          print("Conectado com o id $uid");
          Navigator.of(context).pushReplacementNamed('/home');
        }else if(authFormType == AuthFormType.reset_senha){
          await auth.sendPasswordResetEmail(_email);
          print("Ensira um e-mail para alterar a senha");
          _warning = "Um link de Redefinição de senha foi enviado para o e-mail $_email";
          setState(() {
            authFormType = AuthFormType.login;
          });
        }
        else {
          String uid = await auth.criarUsuarioEmailSenha(
              _email, _password, _nome);
          print("Criou uma conta com o id $uid");
          Navigator.of(context).pushReplacementNamed('/home');
        }
      } catch (e) {
        print(e);
        setState(() {
          _warning = e.message;
        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {

    final _width =MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;


    return Scaffold(
      body: Container(
        color: primaryColor,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,

        child: SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(height: _height * 0.025),
              showAlert(),
              SizedBox(height: _height * 0.025),
              buildHeaderText(),
              SizedBox(height: _height * 0.05),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formkey,
                  child: Column(
                    children: buildInputs() + buildButtons(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget showAlert(){
    if(_warning != null){
        return Container(
          color: Colors.amberAccent,
          width: double.infinity,
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(Icons.error_outline),
              ),
              Expanded(child: AutoSizeText(_warning, maxLines: 3,),),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: (){
                    setState(() {
                      _warning = null;
                    });
                  },
                ),
              )
            ],
          ),
        );
    }
    return SizedBox(height: 0,);
  }

  AutoSizeText buildHeaderText() {
    String _headerText;
    if(authFormType == AuthFormType.criarconta){
      _headerText = "Criar uma nova conta";
    }else if(authFormType == AuthFormType.reset_senha){
      _headerText = "Redefinir a senha";
    }
    else{
      _headerText = "Login";
    }
    return AutoSizeText(
      _headerText,
      maxLines: 1,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 35,
        color: Colors.white,
      ),
    );
  }
  //lista de Widget
  List<Widget> buildInputs(){
    List<Widget> textFields = [];

    if(authFormType == AuthFormType.reset_senha){
      textFields.add(
        TextFormField(
          validator: EmailValidador.validate,
          style: TextStyle(fontSize: 22.0),
          decoration: buildCriarUsuarioInputDecoration("Email"),
          onSaved: (value) => _email = value,
        ),
      );
      textFields.add(SizedBox(height: 20,));
      return textFields;
    }
    //se estivesse no estado de inscrição, adicione o nome
    if(authFormType == AuthFormType.criarconta){
      textFields.add(
        TextFormField(
          validator: NomeValidador.validate,
          style: TextStyle(fontSize: 22.0),
          decoration: buildCriarUsuarioInputDecoration("Nome"),
          onSaved: (value) => _nome = value,
        ),
      );
      textFields.add(SizedBox(height: 20,));
    }
    //adicionar o e-mail e a senha
    textFields.add(
      TextFormField(
        validator: EmailValidador.validate,
        style: TextStyle(fontSize: 22.0),
        decoration: buildCriarUsuarioInputDecoration("E-mail"),
        onSaved: (value) => _email = value,
      ),
    );
    textFields.add(SizedBox(height: 20,));
    textFields.add(
      TextFormField(
        validator: SenhaValidador.validate,
        style: TextStyle(fontSize: 22.0),
        decoration: buildCriarUsuarioInputDecoration("Senha"),
        obscureText: true,
        onSaved: (value) => _password = value,
      ),
    );
    textFields.add(SizedBox(height: 20,));
    return textFields;
  }

  InputDecoration buildCriarUsuarioInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      focusColor: Colors.white,
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 0.0)),
      contentPadding: const EdgeInsets.only(left: 14.0, bottom: 10.0, top: 10.0),
    );
  }
  List<Widget> buildButtons (){
    String _switchButtonText, _newFormState, _submitButtonText;
    bool _showForgotPassword = false;
    if(authFormType == AuthFormType.login){
      _switchButtonText = "Gostaria de criar uma conta ?";
      _newFormState = "criarconta";
      _submitButtonText = "login";
      //resetar a senha
      _showForgotPassword = true;
    }else if(authFormType == AuthFormType.reset_senha){
      _switchButtonText = "Gostaria de retornar ao login ?";
      _newFormState = "login";
      _submitButtonText = "enviar";
    }
    else{
      _switchButtonText = "Já tem uma conta para logar-se ?";
      _newFormState = "login";
      _submitButtonText = "criarconta";
    }

    //criar uma lista
    return[
      Container(
        width: MediaQuery.of(context).size.width * 0.7,
        child: RaisedButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          color: Colors.white,
          textColor: primaryColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _submitButtonText, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300),
            ),
          ),
          onPressed: submit,
        ),
      ),
      //resetar a senha
      showForgotPassword(_showForgotPassword),
      FlatButton(
        child: Text(_switchButtonText, style: TextStyle(color: Colors.white),),
        onPressed: (){
          switchFormState(_newFormState);
        },
      )
    ];
  }
  Widget showForgotPassword(bool visible){
    return Visibility(
      child: FlatButton(
        child: Text(
          "Esqueceu a senha !.",
          style: TextStyle(color: Colors.white),
        ),
        onPressed: (){
          setState(() {
            authFormType = AuthFormType.reset_senha;
          });
        },
      ),
      visible: visible,
    );
  }
}
