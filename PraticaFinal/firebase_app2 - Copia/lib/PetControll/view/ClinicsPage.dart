import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';


class ClinicsPage extends StatefulWidget {
  @override
  _ClinicsPageState createState() => _ClinicsPageState();
}

class _ClinicsPageState extends State<ClinicsPage> {
  var locationMessage = '';
  String userlatitude;
  String userlongitude;
  List<DocumentSnapshot> listaClinicas = null;


  @override
  void initState() {
    // TODO: implement initState
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var snap = FirebaseFirestore.instance
        .collection('clinicas')
        .where('isActive', isEqualTo: true)
        .snapshots();
    return Scaffold(
      backgroundColor: Color(0XFFd6d6d6),
      body: body(snap),
    );
  }

  body( snap ) {
    return Container(
      margin: EdgeInsets.only(top: 29),
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              color: Color(0xFFFF9000),
              child: Text("CLÍNICAS", style: TextStyle( fontSize: 28, fontWeight: FontWeight.bold))
          ),
          StreamBuilder(
          stream: snap,
          builder: (BuildContext context,  AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.data.docs.length == 0) {
              return Center(child: Text('Nenhuma Clínica'));
            }


            return Expanded(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: ( context, index ) {
                        var item = snapshot.data.docs[index];
                        return Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(color: Color(0XFFFFFFFF),borderRadius: BorderRadius.circular(5)),
                          child: ListTile(
                            title: Text(item['nome'], style: TextStyle(fontSize: 20, color: Color(0xFFFF9000),)),
                            subtitle: Row(
                              children: [
                                Text(item['telefone'], style: TextStyle(fontSize: 16, color: Color(0xFFFF9000),)),

                              ],
                            ),
                            trailing: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xEFFF9000),
                                side: BorderSide(
                                  color: Color(0xFFFF9000),
                                  width: 2,
                                ),
                              ),
                              child: Text("Ver no mapa",  style: TextStyle(fontSize: 15, color: Colors.white,)),
                              onPressed: () {
                                //distanceBetween(item['latitude'], item['longitude']);
                                googleMap(item['latitude'], item['longitude']);
                              },
                            ),
                          ),
                        );
                      }
                  ),
                )
            );
          })
        ],
      ),
    );
  }

  void distanceBetween(var itemLatitude, var itemLongitude) {

    var resultado = Geolocator.bearingBetween(double.parse(userlatitude), double.parse(userlongitude), double.parse(itemLatitude), double.parse(itemLongitude));
    print(resultado);
    print(userlatitude+userlongitude+itemLatitude+itemLongitude);
  }

  // function for getting the current location
  // but before that you need to add this permission!
  void getCurrentLocation() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lat = position.latitude;
    var long = position.longitude;

    // passing this to latitude and longitude strings
    userlatitude = "$lat";
    userlongitude = "$long";

    print("User"+ userlatitude + " " + userlongitude);
  }

  // function for opening it in google maps
  void googleMap(var latitude, var longitude) async {
    String googleUrl =
        "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";

    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else
      throw ("Couldn't open google maps");
  }


  String Distance(var latitude, var longitude) {

  }
}