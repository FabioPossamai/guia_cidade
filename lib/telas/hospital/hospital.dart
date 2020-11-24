import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guiacidade/telas/hospital/hospital_model.dart';



class Hospital extends StatefulWidget {
  const Hospital({Key key, this.nome}) : super(key: key);
  final String nome;

  @override
  _HospitalState createState() => _HospitalState();
}

class _HospitalState extends State<Hospital> {
  Future getHospital() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("hospital").getDocuments();
    return qn.documents;
  }
  navegacaoHospitalModel(DocumentSnapshot nome){
    Navigator.push(context, MaterialPageRoute(builder: (context) => HospitalModel(nome: nome,)));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Hospitais"),
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
                  future: getHospital(),
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
                                  onTap: () => navegacaoHospitalModel(snapshot.data[index])
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
