import 'package:doctorspot/db/db.dart';
import 'package:doctorspot/header.dart';
import 'package:doctorspot/location.dart';
import 'package:doctorspot/user.dart';
import 'package:doctorspot/user_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AddressBox extends StatefulWidget {
  AddressBox({this.email});
  final String? email;
  final addressController = TextEditingController();

  @override
  _AddressBoxState createState() => _AddressBoxState();
}

class _AddressBoxState extends State<AddressBox> {
  bool locateMe = false;
  Location location = Location();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Container(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    await location.getCurrentLocation();
                    setState(() {
                      locateMe = true;
                    });
                  },
                  child: Text('Locate me')),
              Visibility(
                  visible: locateMe,
                  child: Column(
                    children: [
                      Container(
                        height: 10,
                      ),
                      Text(
                          'Latitude:${location.latitude?.toStringAsPrecision(6)} '),
                      Text(
                          'Longitude: ${location.longitude?.toStringAsPrecision(6)}')
                    ],
                  )),
              Container(
                height: 50,
              ),
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: widget.addressController,
                  validator: (address) => address!.isEmpty ? '*Required' : '',
                  autocorrect: false,
                  cursorColor: Colors.black,
                  style: TextStyle(color: Colors.black),
                  minLines: 5,
                  maxLines: null,
                  decoration: InputDecoration(
                    labelText: 'Address',
                    alignLabelWithHint: true,
                    hintText: 'Your Address',
                    labelStyle: TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await UserDatabase.instance.insert('userLocation', {
                        'email': widget.email,
                        'latitude':
                            location.latitude?.toStringAsPrecision(6) ?? 0,
                        'longitude':
                            location.longitude?.toStringAsPrecision(6) ?? 0,
                        'address': widget.addressController.text
                      });
                    }
                    List<Map<String, dynamic>> userdata = await UserDatabase
                        .instance
                        .selectByEmail('userProfile', widget.email!);
                    print(userdata);
                    final user = User();
                    user.firstName = userdata[0]['firstName'];
                    user.lastName = userdata[0]['lastName'];
                    user.location = location;
                    user.email = widget.email!;
                    user.address = widget.addressController.text;
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return UserProfile(
                        user: user,
                      );
                    }));
                  },
                  child: Text('Submit')),
            ],
          ),
        ),
      ),
    );
  }
}
