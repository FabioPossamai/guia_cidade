import 'package:firebase_auth/firebase_auth.dart';

class ServeicoAutenticacao {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //altera a instancia, se o usuario estiver logado ou não
  Stream<String> get onAuthStateChanged => _firebaseAuth.onAuthStateChanged.map(
      (FirebaseUser user) => user?.uid,
  );

  //E-mail e Senha para criar uma conta
  //função assincrona
  Future<String> criarUsuarioEmailSenha(String email, String senha, String nome) async{
    final currentuser = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: senha);

    //autalizar o usuario
    var userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = nome;
    await currentuser.updateProfile(userUpdateInfo);
    await currentuser.reload();
    return currentuser.uid;
  }

  //E-mail e Senha para logar na aplicação
  Future<String> logarUsuarioEmailSenha(String email, String senha) async{
    return (await _firebaseAuth.signInWithEmailAndPassword(email: email, password: senha)).uid;
  }

  //sair da aplicação
  Sair(){
    return _firebaseAuth.signOut();
  }
  //Reseta a senha
  Future sendPasswordResetEmail(String email) async{
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
class NomeValidador{
  static String validate(String value){
    if(value.isEmpty){
      return "Favor Verificar o campo Nome !.";
    }
    if(value.length < 2){
      return "O Nome deve ter mais do que dois caracteres !.";
    }
    if(value.length > 50){
      return "O Nome deve ser menor do 50 caracatres !.";
    }
    return null;
  }
}
class EmailValidador{
  static String validate(String value){
    if(value.isEmpty){
      return "Favor Verificar o campo E-mail !.";
    }
    return null;
  }
}
class SenhaValidador{
  static String validate(String value){
    if(value.isEmpty){
      return "Favor Verificar o campo da senha !.";
    }
    return null;
  }
}