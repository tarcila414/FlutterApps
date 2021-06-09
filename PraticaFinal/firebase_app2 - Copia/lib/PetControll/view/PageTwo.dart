import 'package:flutter/material.dart';

class PageTwo extends StatefulWidget {
  @override
  _PageTwoState createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      primary: Color(0x8DFCA136),
      elevation: 15,
    );
    return SingleChildScrollView(
        child: Container(
            color: Color(0XFFFFFFFF),
            padding: EdgeInsets.only(left: 20.0, top: 90,  bottom: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                    SizedBox(
                      height: 350,
                      width: 340,
                      child: ElevatedButton(
                          style: style,
                          onPressed: (){} ,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(padding: EdgeInsets.only(top: 20)),
                              Container(
                                  margin: EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(color: Color(0xff),borderRadius: BorderRadius.circular(5)),
                                  child: Text("Vacinação anual ", style: TextStyle(color:  Color(0xFFFFFFFF), fontSize: 28, fontWeight: FontWeight.bold),)),
                              Container(
                                  padding: EdgeInsets.only( top: 15),
                                  alignment: Alignment.center,
                                  //margin: EdgeInsets.only(left: 10, right: 10),
                                  child: Text("Cães adultos devem ser vacinados todos os anos com as vacinas V10 ou V8. "
                                      "Elas protegem o cachorro contra cinomose, parvovirose, leptospirose e outras enfermidades graves"
                                      " que podem levar o animal à óbito. Outra vacina que deve ser realizada anualmente é a Antirrábica. "
                                      "Ela imuniza contra a Raiva, uma doença grave que pode ser transmitida para humanos.",
                                    style: TextStyle(color:  Color(0xFFFFFFFF), fontSize: 18),))
                            ],
                          )
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 20)),
                    SizedBox(
                      height: 500,
                      width: 340,
                      child: ElevatedButton(
                      style: style,
                      onPressed: () {},
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(padding: EdgeInsets.only(top: 20)),
                          Container(
                              margin: EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(color: Color(0xff),borderRadius: BorderRadius.circular(5)),
                              child: Text("Vermífugos ", style: TextStyle(color:  Color(0xFFFFFFFF), fontSize: 28, fontWeight: FontWeight.bold),)),
                          Container(
                              padding: EdgeInsets.only( top: 15),
                              alignment: Alignment.center,
                              //margin: EdgeInsets.only(left: 10, right: 10),
                              child: Text(
                                "Alguns medicamentos devem ser usados "
                                    "periodicamente no seu cachorro. Um caso muito importante "
                                    "é o vermífugo. Esses remédios eliminam vermes que podem gerar"
                                    " diversas doenças no seu cachorro. O animal contrai vermes principalmente "
                                    "em passeios na rua, mas mesmo aqueles que não saem de casa devem ser medicados. "
                                    "A transmissão também pode acontecer através de alimentos ou mesmo se ele lamber "
                                    "ou comer algo do chão.Os vermífugos possuem posologias diferentes que variam de acordo com"
                                    " o peso do cachorro, por isso procure um médico veterinário para definir qual o período, a dosagem "
                                    "e o vermífugo ideal para seu pet.",
                                style: TextStyle(color:  Color(0xFFFFFFFF), fontSize: 18),))
                        ],
                      )
                  ),
                ),
                    Padding(padding: EdgeInsets.only(bottom: 20)),
                    SizedBox(
                      height: 550,
                      width: 340,
                      child: ElevatedButton(
                          style: style,
                          onPressed: (){} ,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(padding: EdgeInsets.only(top: 20)),
                              Container(
                                  margin: EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(color: Color(0xff),borderRadius: BorderRadius.circular(5)),
                                  child: Text("Estresse ", style: TextStyle(color:  Color(0xFFFFffff), fontSize: 28, fontWeight: FontWeight.bold),)),
                              Container(
                                  padding: EdgeInsets.only( top: 15),
                                  alignment: Alignment.center,
                                  //margin: EdgeInsets.only(left: 10, right: 10),
                                  child: Text("Com a rotina corrida dos tutores, muitos pets desenvolvem estresse e comportamentos indesejados, como roer, latir incessantemente e fazer xixi fora do lugar."
                                      "Para cuidar da saúde mental do pet, é importante entender o comportamento do animal e organizar a rotina para que ele se sinta bem e tenha suas necessidades atendidas. "
                                      "Por exemplo, animais agitados precisam de exercício e atenção. Isso pode ser compreendido com passeios longos, dias em creches ou escolinhas, momentos de brincadeira antes do período sozinho e brinquedos interativos."
                                      "Os brinquedos interativos têm o intuito de entreter o pet enquanto o tutor não está em casa ou não pode brincar. Além de distrair, eles colaboram para a prática de atividade física do seu pet.",
                                    style: TextStyle(color:  Color(0xFFFFffff), fontSize: 18),))
                            ],
                          )
                  ),
                ),
                    Padding(padding: EdgeInsets.only(bottom: 20)),
                    SizedBox(
                      height: 400,
                      width: 340,
                      child: ElevatedButton(
                        style: style,
                        onPressed: (){},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(padding: EdgeInsets.only(top: 20)),
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(color: Color(0xff),borderRadius: BorderRadius.circular(5)),
                              child: Text("Antipulgas e remédio para carrapato", style: TextStyle(color:  Color(0xFFFFffff), fontSize: 28, fontWeight: FontWeight.bold),)),
                            Container(
                              padding: EdgeInsets.only( top: 15),
                              alignment: Alignment.center,
                              //margin: EdgeInsets.only(left: 10, right: 10),
                              child: Text("Os cuidados com a saúde também incluem o uso frequente de antipulgas e remédio para carrapatos. Esses medicamentos são "
                                  "responsáveis por deixar seu pet livre de pulgas, carrapatos, piolhos e mosquitos, evitando diversas doenças."
                                  "Disponíveis no formato de coleiras, pipetas, sprays e até medicamentos orais, os antipulgas "
                                  "possuem períodos de atuação diferentes. Converse com seu veterinário e defina o que funciona melhor para seu pet.",
                                style: TextStyle(color:  Color(0xFFFFffff), fontSize: 18),))
                        ],
                      )
                  ),
                ),

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
            ),
    );
  }
}
