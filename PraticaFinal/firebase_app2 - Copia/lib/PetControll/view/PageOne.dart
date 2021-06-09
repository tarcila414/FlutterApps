import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PageOne extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      primary: Color(0XFFFFFFFF),//Color(0xFF9E9E9E)//Color(0XFF757575),
    );
    return Container(
      color: Color(0XFFd6d6d6),
      padding: EdgeInsets.only(left: 20.0,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SizedBox(
            height: 90,
            width: 340,
            child: ElevatedButton(
                style: style,
                onPressed: (){

                  Navigator.pushNamed(context, "/perfil");
                } ,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(color: Color(0x3FFF9000),borderRadius: BorderRadius.circular(5)),

                      child: Icon( Icons.perm_identity,  color: Color(0xFFFF9000), size: 40,),
                    ),
                      //Icon( Icons.alternate_email,  color: Colors.black,),
                    Container(
                        margin: EdgeInsets.only(left: 30),
                        decoration: BoxDecoration(color: Color(0xff),borderRadius: BorderRadius.circular(5)),
                        child: Text("PERFIL", style: TextStyle(color:  Color(0xFFFF9000), fontSize: 28),))
                  ],
                ),

            ),
          ),
          SizedBox(
            height: 90,
            width: 340,
            child: ElevatedButton(
                style: style,
                onPressed: (){
                  Navigator.pushNamed(context, "/pets");
                } ,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(color: Color(0x3FFF9000),borderRadius: BorderRadius.circular(5)),

                      child: Icon( Icons.pets,  color: Color(0xFFFF9000), size: 40,),
                    ),
                    //Icon( Icons.alternate_email,  color: Colors.black,),
                    Container(
                        margin: EdgeInsets.only(left: 30),
                        decoration: BoxDecoration(color: Color(0xff),borderRadius: BorderRadius.circular(5)),
                        child: Text("MEUS PETS", style: TextStyle(color:  Color(0xFFFF9000), fontSize: 28),))
                  ],
                )),),
          SizedBox(
            height: 90,
            width: 340,
            child: ElevatedButton(
                style: style,
                onPressed: (){
                  Navigator.pushNamed(context, "/clinicas");
                } ,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(color: Color(0x3FFF9000),borderRadius: BorderRadius.circular(5)),

                      child: Icon( Icons.store_mall_directory,  color: Color(0xFFFF9000), size: 40,),
                    ),
                    //Icon( Icons.alternate_email,  color: Colors.black,),
                    Container(
                        margin: EdgeInsets.only(left: 30),
                        decoration: BoxDecoration(color: Color(0xff),borderRadius: BorderRadius.circular(5)),
                        child: Text("CLÍNICAS ", style: TextStyle(color:  Color(0xFFFF9000), fontSize: 28),))
                  ],
                )),),
          SizedBox(
            height: 90,
            width: 340,
            child: ElevatedButton(
                style: style,
                onPressed: (){
                  Navigator.pushNamed(context, "/adocoes");
                } ,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(color: Color(0x3FFF9000),borderRadius: BorderRadius.circular(5)),

                      child: Icon( Icons.child_friendly,  color: Color(0xFFFF9000), size: 40,),
                    ),
                    //Icon( Icons.alternate_email,  color: Colors.black,),
                    Container(
                        margin: EdgeInsets.only(left: 30),
                        decoration: BoxDecoration(color: Color(0xff),borderRadius: BorderRadius.circular(5)),
                        child: Text("ADOÇÕES", style: TextStyle(color:  Color(0xFFFF9000), fontSize: 28),))
                  ],
                )),),


          // SizedBox(
          //   height: 90,
          //   width: 340,
          //   child: ElevatedButton(
          //       style: style,
          //       onPressed: (){} ,
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         children: <Widget>[
          //           Container(
          //             padding: EdgeInsets.all(15),
          //             decoration: BoxDecoration(color: Color(0x3FFF9000),borderRadius: BorderRadius.circular(5)),
          //
          //             child: Icon( Icons.pets,  color: Color(0xFFFF9000), size: 40,),
          //           ),
          //           //Icon( Icons.alternate_email,  color: Colors.black,),
          //           Container(
          //               margin: EdgeInsets.only(left: 30),
          //               decoration: BoxDecoration(color: Color(0xff),borderRadius: BorderRadius.circular(5)),
          //               child: Text("PETS", style: TextStyle(color:  Color(0xFFFF9000), fontSize: 28),))
          //         ],
          //       )),),
        ],
      )
    );
  }
}
