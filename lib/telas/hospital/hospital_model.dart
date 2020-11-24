import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guiacidade/servicos/mapa_teste.dart';

class HospitalModel extends StatefulWidget {
  const HospitalModel({Key key, this.nome,}) : super(key: key);
  final DocumentSnapshot nome;
  @override
  _HospitalModel createState() => _HospitalModel();
}

class _HospitalModel extends State<HospitalModel> {
  Future getHospitalModel() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("hospital").where('nome', isEqualTo: widget.nome).getDocuments();
    return qn.documents;
  }
  navegacaoMapaTeste(DocumentSnapshot nome){
    Navigator.push(context, MaterialPageRoute(builder: (context) => HospitalModel(nome: nome,)));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dados Completos"),
      ),
      body: Container(
        child: FutureBuilder(
            future: getHospitalModel(),
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return new Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                  itemCount: 1,
                  itemBuilder: (_, index) {
                    return Column(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.store),
                          title: Text("Nome"),
                          subtitle: Text(widget.nome.data["nome"]),
                        ),
                        ListTile(
                          leading: Icon(Icons.location_searching),
                          title: Text("Endereço"),
                          subtitle: Text(widget.nome["endereco"]),
                        ),
                        ListTile(
                          leading: Icon(Icons.local_phone),
                          title: Text("Telefone"),
                          subtitle: Text(widget.nome["telefone"]),
                        ),
                        ListTile(
                          leading: Icon(Icons.location_city),
                          title: Text("Cidade"),
                          subtitle: Text(widget.nome['cidade']),
                        ),
                        FlatButton(
                          child: ListTile(
                            contentPadding: EdgeInsets.all(1),
                            leading: Icon(Icons.map),
                            title: Text("Mapa"),
                            trailing: Icon(Icons.keyboard_arrow_right),
                          ),
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => MapaTeste(nome: widget.nome['nome'])));},
                        )
                      ],
                    );
                  });
            }),
      ),
    );
  }
}