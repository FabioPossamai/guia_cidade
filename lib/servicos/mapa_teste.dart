import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaTeste extends StatefulWidget {

  const MapaTeste({Key key, this.nome,}) : super(key: key);
  final String nome;
  @override
  _MapaTesteState createState() => _MapaTesteState();
}

class _MapaTesteState extends State<MapaTeste> {
  GoogleMapController controller;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  var latitude;
  var longitude;

  void initMarker(specify, specifyId) async {
    if(latitude == null || longitude == null) {}
    latitude = specify['mapa'].latitude;
    longitude = specify['mapa'].longitude;
    var markerIdVal = specifyId;
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(specify['mapa'].latitude, specify['mapa'].longitude),
    );
    setState(() {
      markers[markerId] = marker;
    });
  }

  getMarkerData() async {
    Firestore.instance.collection('hospital').where('nome', isEqualTo: widget.nome).getDocuments().then((hospital) {
      if (hospital.documents.isNotEmpty) {
        for (int i = 0; i < hospital.documents.length; i++) {
          initMarker(hospital.documents[i].data, hospital.documents[i].documentID);
        }
      }
    });
  }
  getMarkerData1() async {
    Firestore.instance.collection('bares').where('nome', isEqualTo: widget.nome).getDocuments().then((hospital) {
      if (hospital.documents.isNotEmpty) {
        for (int i = 0; i < hospital.documents.length; i++) {
          initMarker(hospital.documents[i].data, hospital.documents[i].documentID);
        }
      }
    });
  }
  @override
  void initState() {
    getMarkerData();
    getMarkerData1();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GoogleMap(
            markers: Set<Marker>.of(markers.values),
            mapType: MapType.hybrid,
            initialCameraPosition:
            CameraPosition(target: LatLng(latitude, longitude), zoom: 17.5),
            onMapCreated: (GoogleMapController controller) {controller = controller;}
        )
    );
  }
}
