import 'package:flutter/material.dart';
import 'ngo_item.dart';

class ReusableCard extends StatelessWidget {
  String cardName;
  List<dynamic> list = ngolist;
  ReusableCard(String name){
    this.cardName = name;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(cardName),
    );
  }
}
