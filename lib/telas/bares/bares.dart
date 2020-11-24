import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:guiacidade/telas/bares/bares_model.dart';







class Bares extends StatefulWidget {

  const Bares({Key key, this.nome}) : super(key: key);
  final String nome;

  @override
  _BaresState createState() => _BaresState();
}

class _BaresState extends State<Bares> {
  Future getBares() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("bares").getDocuments();
    return qn.documents;
  }
  navegacaoBareslModel(DocumentSnapshot nome){
    Navigator.push(context, MaterialPageRoute(builder: (context) => BaresModel(nome: nome,)));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Bares"),
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
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: FutureBuilder(
                  future: getBares(),
                  builder: (_, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return new Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (_, index) {
                            return Container(
                              child: Card(
                                child: ListTile(
                                  trailing: Icon(Icons.keyboard_arrow_right),
                                    title: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(snapshot.data[index].data["nome"]),
                                      ],
                                    ),
                                    onTap: () => navegacaoBareslModel(snapshot.data[index])
                                ),
                              ),
                            );
                          });
                    }
                  }),
            ),
          ],
        ));
  }
}
