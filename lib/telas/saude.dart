import 'package:flutter/material.dart';
import 'package:guiacidade/telas/hospital/hospital.dart';

class Saude extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Area da Saúde"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                //delegate: CustomSearchDelegate(),
              );
            },
          ),
        ],
      ),
      body: GridView.count(
          padding: const EdgeInsets.all(3.0),
          crossAxisCount: 3,
          children: <Widget>[
            FlatButton(
              child: Column(
                children: <Widget>[
                  Menu(titulo: "Hospital", icon: Icons.local_hospital, cor: Colors.blue),
                ],
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Hospital()));
              },
            ),
            FlatButton(
              child: Column(
                children: <Widget>[
                  Menu(titulo: "Clinicas", icon: Icons.local_hospital, cor: Colors.blue),
                ],
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Saude()));
              },
            ),
            FlatButton(
              child: Column(
                children: <Widget>[
                  Menu(titulo: "Laboratorio", icon: Icons.local_hospital, cor: Colors.blue),
                ],
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Saude()));
              },
            )
          ]
      ),
    );
  }
}
class Menu extends StatelessWidget {
  Menu({this.titulo, this.icon, this.cor});
  //Menu({this.titulo, this.icon, this.cor});

  final String titulo;
  final IconData icon;
  final MaterialColor cor;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: InkWell(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(icon, size: 70.0,color: cor),
              Text(titulo,style: TextStyle(fontSize: 12.0),)
            ],
          ),
        ),
      ),
    );
  }
}
