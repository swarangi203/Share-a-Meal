import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// bas karna bhot bolri kya ha you wa
Widget restoHome(){
  return SingleChildScrollView(
    child: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
          ),
          SizedBox(
            width: 200,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () async {
                // yaha pe functionality aaegi
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Donate meal",
                    style: TextStyle(fontSize: 20, fontFamily: "BonaNova"),
                  ),
                  Icon(Icons.add),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}