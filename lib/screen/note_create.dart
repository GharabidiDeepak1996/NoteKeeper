import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutternotekeeperapp/database/dao.dart';
import 'package:flutternotekeeperapp/database/database.dart';
import 'package:flutternotekeeperapp/database/entity.dart';
import 'package:intl/intl.dart';

class NoteDetail extends StatefulWidget {
  String appBarTitle;

  NoteDetail(this.appBarTitle);

  @override
  State<StatefulWidget> createState() {
    return NoteDetailState(appBarTitle);
  }
}

class NoteDetailState extends State<NoteDetail> {
  var listOfCurrencies = ['High', 'Low'];
  var itemSelected = 'High';
  String appBarTitle;

  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  NoteDetailState(this.appBarTitle);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    TextStyle textStyle = Theme.of(context).textTheme.subhead;
    return WillPopScope(
      onWillPop: () {
        //when user press back it will be move to last screen
        backToScreen();
      },
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                //when user press back it will be move to last screen
                backToScreen();
              },
            ),
            title: Text(appBarTitle),
          ),
          body: Form(
            key: _formKey,
              child:  Padding(
                padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
                child:  ListView(
                  children: <Widget>[
                    //FirstElement
                    ListTile(
                      title: DropdownButton(
                        items: listOfCurrencies.map((String itemSelected) {
                          return DropdownMenuItem(
                            value: itemSelected,
                            child: Text(itemSelected),
                          );
                        }).toList(),
                        onChanged: (String value) {
                          setState(() {
                            itemSelected = value;
                          });
                        },
                        style: textStyle,
                        value: itemSelected,
                      ),
                    ),

                    //SecondElement
                    Padding(
                      padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                      child: TextFormField(
                        controller: title,
                        style: textStyle,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter title';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            errorStyle: TextStyle(
                              color: Colors.red,
                              fontSize: 15.0,
                            ),
                            labelStyle: textStyle,
                            labelText: 'Rate of Interest',
                            hintText: 'In percent',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      ),
                    ),

                    //Third Element
                    Padding(
                      padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                      child: TextFormField(
                        controller: description,
                        style: textStyle,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please enter description';
                          }
                        },
                        decoration: InputDecoration(
                            errorStyle: TextStyle(
                              color: Colors.red,
                              fontSize: 15.0,
                            ),
                            labelStyle: textStyle,
                            labelText: 'Description',
                            hintText: 'In percent',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      ),
                    ),

                    //four Element Button
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                              color: Theme.of(context).primaryColor,
                              textColor: Theme.of(context).primaryColorDark,
                              child: Text(
                                "Save",
                                textScaleFactor: 1.5,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (_formKey.currentState.validate()) {
                                    onSubmit();
                                  }
                                  debugPrint("Save");
                                });
                              }),
                        ),
                        Container(
                          width: 20.0,
                        ),
                        Expanded(
                            child: RaisedButton(
                                color: Theme.of(context).primaryColor,
                                textColor: Theme.of(context).primaryColorDark,
                                child: Text(
                                  "Delete",
                                  textScaleFactor: 1.5,
                                ),
                                onPressed: () {
                                  setState(() {
                                    debugPrint("delete");
                                  });
                                })
                        ),
                      ],
                    )
                  ],
                ),
              ),),
          )
    );
  }

  void backToScreen() {
    Navigator.pop(context, true); //navigator its handle push and pop
  }

  Future<void> onSubmit() async {
    backToScreen();
    var date = DateFormat.yMMMd().format(DateTime.now());
    final database = await $FloorAppDatabase.databaseBuilder('flutter_database.db').build();
    var noteData = Note(title.text, description.text, itemSelected, date);
    database.personDao.insertPerson(noteData);
    _showAlertDialog('Status', 'Note Saved Successfully');
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
}
