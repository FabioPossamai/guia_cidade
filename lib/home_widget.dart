import 'package:flutter/material.dart';
import 'package:guiacidade/telas/home_view.dart';
import 'package:guiacidade/servicos/servico_autenticacao.dart';
import 'package:guiacidade/widgets/provider.dart';
import 'package:guiacidade/telas/saude.dart';
import 'package:guiacidade/telas/bares/bares.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentindex = 0;
  final List<Widget> _children = [HomeView(), Saude(), Bares()];

  @override
  Widget build(BuildContext context) {
    //remover isso aqui tbm de der erro
    return Scaffold(
      appBar: AppBar(
        title: Text("Guia da Cidade"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              try {
                ServeicoAutenticacao auth = Provider.of(context).auth;
                await auth.Sair();
                print("Sair");
              } catch (e) {
                print(e);
              }
            },
          )
        ],
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(3.0),
        crossAxisCount: 3,
        children: <Widget>[
          FlatButton(
            child: Column(
              children: <Widget>[
                Menu(
                    titulo: "Saúde",
                    icon: Icons.local_hospital,
                    cor: Colors.blue),
              ],
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Saude()));
            },
          ),
          FlatButton(
            child: Column(
              children: <Widget>[
                Menu(titulo: "Bares", icon: Icons.local_bar, cor: Colors.blue),
              ],
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Bares()));
            },
          )
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: -_currentindex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text("Home"),
          ),
          /*BottomNavigationBarItem(
            icon: new Icon(Icons.person),
            title: new Text("Perfil"),
          ),*/
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentindex = index;
    });
  }
}

class Menu extends StatelessWidget {
  Menu({this.titulo, this.icon, this.cor});

  final String titulo;
  final IconData icon;
  final MaterialColor cor;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(6.0),
      child: InkWell(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(icon, size: 70.0, color: cor),
              Text(titulo)
            ],
          ),
        ),
      ),
    );
  }
}
