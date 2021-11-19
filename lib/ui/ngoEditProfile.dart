import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:sampleproject/net/flutterfire.dart';
import 'package:sampleproject/ui/register_resto.dart';
import 'package:sampleproject/ui/resto_dashboard.dart';
import 'package:sampleproject/ui/resto_profile.dart';

import 'login_page.dart';
import 'ngo_dashboard.dart';

DatabaseReference reference;
String name;
String license;
String authentication;
String foodquality;
String description;
String rating;
String approval;
String city;
String address;
String ngos;
String role;
String profilePic;
String email;
String contact;
TextEditingController _emailField ;
TextEditingController _nameField ;
TextEditingController _contactField ;
TextEditingController _addressField ;
TextEditingController _descField ;
class EditNgoProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Share a Meal',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: EditNGOProfile(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class EditNGOProfile extends StatefulWidget {
  @override
  _EditNGOProfileState createState() => _EditNGOProfileState();
}

class _EditNGOProfileState extends State<EditNGOProfile> {
  String temp;
  final formKey = new GlobalKey<FormState>();
  _RegisterRestoState(String variable) {
    this.temp = variable;
  }

  String dropdownValue=city;
  String holder = '';
  String downloadURL;
  void getDropDownItem() {
    setState(() {
      holder = dropdownValue;
    });
  }

  @override
  void initState() {
    super.initState();
    retrieve();
    _myActivity = '';
    _myActivityResult = '';
    reference = FirebaseDatabase.instance.reference().child("Users");
  }
  String _myActivity;
  String _myActivityResult;
  File _image;
  String url;
  _saveForm() {
    var form = formKey.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        _myActivityResult = _myActivity;
      });
    }
  }

  int _user;
  final List<String> _dropdownValues = [
    "Mumbai",
    "Pune",
    "Sangli",
    "Delhi",
    "Kolkata"
  ];
  bool changeButton = false;
  bool _autovalidate = false;

  @override
  Widget build(BuildContext context) {
    Future getImage() async {
      PickedFile image =
      (await ImagePicker().getImage(source: ImageSource.gallery));
      setState(() {
        _image = File(image.path);
      });
    }

    Future uploadPic(BuildContext context) async {
      if (_image == null) {
        return;
      } else {
        String filename = basename(_image.path);
        firebase_storage.Reference ref =
        firebase_storage.FirebaseStorage.instance.ref().child(filename);
        /*await firebase_storage.FirebaseStorage.instance
              .ref(filename)
              .putFile(_image);*/
        firebase_storage.UploadTask task = firebase_storage
            .FirebaseStorage.instance
            .ref(FirebaseAuth.instance.currentUser.uid)
            .putFile(_image);
        var dowurl =
        await (await task.whenComplete(() => null)).ref.getDownloadURL();
        url = dowurl.toString();
        print(url);
        updateProfile(
            FirebaseAuth.instance.currentUser.uid,
            temp,
            _descField.text,
            _nameField.text,
            _emailField.text,
            _addressField.text,
            _contactField.text,
            dropdownValue,
            ngos,
            approval,
            url,
            foodquality,
            license);
      }
    }

    _emailField = TextEditingController(text: email);
    _nameField = TextEditingController(text: name);
    _contactField = TextEditingController(text: contact);
    _addressField = TextEditingController(text: address);
    _descField = TextEditingController(text: description);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Text(
                  '   Share a Meal',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "BonaNova",
                      fontSize: 25),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(15.0),
          child: IconButton(
            icon: Icon(
              Icons.restaurant_menu_outlined,
              color: Colors.white60,
            ),
            onPressed: () {},
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: IconButton(
              icon: Icon(
                Icons.notifications_none,
                color: Colors.white60,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
      backgroundColor: Colors.grey[900],
      body: FutureBuilder(
          future: retrieve(),
          builder: (context, snapshot) {
            retrieve();
            return SingleChildScrollView(
              child: Center(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      GestureDetector(
                        onTap: () {
                          getImage();
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 70,
                          child: ClipOval(
                            child: (_image != null)
                                ? Image.file(
                              _image,
                              width: 140,
                              height: 140,
                              fit: BoxFit.cover,
                            )
                                : Image.network(
                              profilePic,
                              width: 140,
                              height: 140,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton.icon(
                              onPressed: () {
                                getPdf('license');
                              },
                              icon: Icon(
                                Icons.description,
                                color: Colors.teal,
                              ),
                              label: Text(
                                "License",
                                style: TextStyle(color: Colors.teal),
                              )),
                          TextButton.icon(
                              onPressed: () {
                                getPdf('foodquality');
                              },
                              icon: Icon(
                                Icons.article_outlined,
                                color: Colors.teal,
                              ),
                              label: Text(
                                "Food Quality",
                                style: TextStyle(color: Colors.teal),
                              )),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 285,
                          height: 55,
                          child: TextFormField(
                            autocorrect: true,
                            style: TextStyle(
                              color: Colors.white60,
                              fontFamily: "BonaNova",
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Name of the NGO can't be empty";
                              }
                              return null;
                            },
                            controller: _nameField,
                            decoration: InputDecoration(
                              labelText: '',
                              labelStyle: TextStyle(
                                color: Colors.white60,
                                fontFamily: "BonaNova",
                              ),
                              hintStyle: TextStyle(color: Colors.grey),
                              filled: true,
                              fillColor: Colors.grey[800],
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    30,
                                  ),
                                ),
                                borderSide:
                                BorderSide(color: Colors.black, width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    30,
                                  ),
                                ),
                                borderSide:
                                BorderSide(color: Colors.black, width: 1),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 285,
                          height: 55,
                          child: TextFormField(
                            style: TextStyle(
                              color: Colors.white60,
                              fontFamily: "BonaNova",
                            ),
                            autocorrect: true,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Email can't be empty";
                              }

                              return null;
                            },
                            controller: _emailField,
                            decoration: InputDecoration(
                              labelText: '',
                              labelStyle: TextStyle(
                                color: Colors.white60,
                                fontFamily: "BonaNova",
                              ),
                              hintStyle: TextStyle(color: Colors.grey),
                              filled: true,
                              fillColor: Colors.grey[800],
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    30,
                                  ),
                                ),
                                borderSide:
                                BorderSide(color: Colors.black, width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    30,
                                  ),
                                ),
                                borderSide:
                                BorderSide(color: Colors.black, width: 1),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 285,
                          height: 55,
                          child: TextFormField(
                            style: TextStyle(
                              color: Colors.white60,
                              fontFamily: "BonaNova",
                            ),
                            autocorrect: true,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Contact can't be empty";
                              }
                              return null;
                            },
                            controller: _contactField,
                            decoration: InputDecoration(
                              labelText: '',
                              labelStyle: TextStyle(
                                color: Colors.white60,
                                fontFamily: "BonaNova",
                              ),
                              hintStyle: TextStyle(color: Colors.white60),
                              filled: true,
                              fillColor: Colors.grey[800],
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    30,
                                  ),
                                ),
                                borderSide:
                                BorderSide(color: Colors.black, width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    30,
                                  ),
                                ),
                                borderSide:
                                BorderSide(color: Colors.black, width: 1),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 285,
                          height: 55,
                          child: TextFormField(
                            style: TextStyle(
                              color: Colors.white60,
                              fontFamily: "BonaNova",
                            ),
                            autocorrect: true,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Address can't be empty";
                              }
                              return null;
                            },
                            controller: _addressField,
                            decoration: InputDecoration(
                              labelText: '',
                              labelStyle: TextStyle(
                                color: Colors.white60,
                                fontFamily: "BonaNova",
                              ),
                              hintStyle: TextStyle(color: Colors.grey),
                              filled: true,
                              fillColor: Colors.grey[800],
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(30)),
                                borderSide:
                                BorderSide(color: Colors.black, width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(30)),
                                borderSide:
                                BorderSide(color: Colors.black, width: 1),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        width: 285,
                        height: 55,
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                              color: Colors.black,
                              style: BorderStyle.solid,
                              width: 0.80),
                        ),
                        child: Center(
                          child: DropdownButton(
                            dropdownColor: Colors.grey[800],
                            value:
                            _user == null ? null : _dropdownValues[_user],
                            hint: new Text(
                              '$city',
                              style: TextStyle(
                                color: Colors.white60,
                                fontFamily: "BonaNova",
                              ),
                            ),
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white60,
                            ),
                            elevation: 16,
                            underline: Container(
                              height: 0,
                            ),
                            items: _dropdownValues
                                .map(
                                  (String value) => DropdownMenuItem<String>(
                                value: value,
                                child: new Text(
                                  value,
                                  style: TextStyle(
                                    color: Colors.white60,
                                    fontFamily: "BonaNova",
                                  ),
                                ),
                              ),
                            )
                                .toList(),
                            isExpanded: false,
                            onChanged: (value) {
                              setState(() {
                                _user = _dropdownValues.indexOf(value);
                                dropdownValue = value;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 285,
                          height: 55,
                          child: TextFormField(
                            autocorrect: true,
                            style: TextStyle(
                              color: Colors.white60,
                              fontFamily: "BonaNova",
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Description cannot be empty";
                              }
                              return null;
                            },
                            controller: _descField,
                            decoration: InputDecoration(
                              labelText: '',
                              labelStyle: TextStyle(
                                color: Colors.white60,
                                fontFamily: "BonaNova",
                              ),
                              hintStyle: TextStyle(color: Colors.grey),
                              filled: true,
                              fillColor: Colors.grey[800],
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    30,
                                  ),
                                ),
                                borderSide:
                                BorderSide(color: Colors.black, width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    30,
                                  ),
                                ),
                                borderSide:
                                BorderSide(color: Colors.black, width: 1),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: 150,
                        height: 50,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.teal,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(35),
                              ),
                            ),
                            onPressed: () async {
                              if (formKey.currentState.validate()) {
                                // use the information provided
                                String uid =
                                    FirebaseAuth.instance.currentUser.uid;
                                uploadPic(context);
                                updateProfile(uid, role, _descField.text, _nameField.text, email, _addressField.text, _contactField.text, dropdownValue, ngos, approval, profilePic, foodquality, license);
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        NgoDashboard(text: uid),
                                  ),
                                );
                              }
                            },
                            child: Text(
                              "Save Changes ",
                              style: TextStyle(
                                  fontSize: 16, fontFamily: "BonaNova"),
                            )),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: new Row(
      children: [
        CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.black)),
        Container(
          margin: EdgeInsets.only(left: 7),
          child: Text("   Please wait..."),
        ),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

Future<void> retrieve() async {

  reference = FirebaseDatabase.instance
      .reference()
      .child("Users")
      .child(FirebaseAuth.instance.currentUser.uid);
  await reference.once().then((DataSnapshot snapshot) {
    Map<dynamic, dynamic> values = snapshot.value;
    name = values["name"];
    description = values["description"];
    city = values["city"];
    role = values["role"];
    profilePic = values["profilePic"];
    email = values["email"];
    rating = values["rating"];
    approval = values["aprroval"];
    ngos = values["ngos"];
    contact = values["contact"];
    address = values["address"];
    foodquality = values['foodquality'];
    license = values['license'];
  });
  _emailField = TextEditingController(text: email);
  _nameField = TextEditingController(text: name);
  _contactField = TextEditingController(text: contact);
  _addressField = TextEditingController(text: address);
  _descField = TextEditingController(text: description);
}

void updateProfile(
    String uid,
    String role,
    String description,
    String name,
    String email,
    String address,
    String contact,
    String city,
    String ngos,
    String approval,
    String profilePic,
    String foodquality,
    String license,
    ) {
  Map<String, String> userdata = {
    'name': name,
    'email': email,
    'address': address,
    'contact': contact,
    'city': city,
    'description': description,
    'profilePic': profilePic,
    'rating': rating,
    'ngos': ngos,
    'role': "NGO",
    'approval': approval,
    'license': license,
    'foodquality': foodquality
  };
  reference.set(userdata);
}

Future getPdf(String docType) async {
  FilePickerResult result = (await FilePicker.platform.pickFiles());
  pdf = File(result.files.single.path);
  if (pdf == null) {
    return;
  } else {
    String filename = basename(pdf.path);
    firebase_storage.Reference ref =
    firebase_storage.FirebaseStorage.instance.ref().child(filename);
    /*await firebase_storage.FirebaseStorage.instance
              .ref(filename)
              .putFile(_image);*/
    firebase_storage.UploadTask task = firebase_storage.FirebaseStorage.instance
        .ref(FirebaseAuth.instance.currentUser.uid + docType)
        .putFile(pdf);
    var dowurl =
    await (await task.whenComplete(() => null)).ref.getDownloadURL();
    String url = dowurl.toString();
    print(url);
    if(docType=="license"){
      license = url;
    }
    else{
      foodquality = url;
    }

    DatabaseReference reference = FirebaseDatabase.instance
        .reference()
        .child("Users")
        .child(FirebaseAuth.instance.currentUser.uid);
    reference.child(docType).set(url);
  }
}
