import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sampleproject/ui/ngo_item.dart';

Widget ngoList() {
  ngoItem();
  int count;
  return FutureBuilder(
    future: ngoItem(),
    builder: (context, snapshot) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              itemCount: 1,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context,int index){
                return;
              }),
        ),
      ],
    );
  }


  );
}

/*
Container(
child:
);
*/
