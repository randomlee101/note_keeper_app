import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notekeeper/main.dart';
import 'package:sqflite/sqflite.dart';

class NoteDetails extends StatefulWidget {
  @override
  _NoteDetailsState createState() => _NoteDetailsState();

  final String existing;
  final int id;
  final String name;
  final String desc;
  NoteDetails({this.existing, this.id, this.name, this.desc});
}

int count = 0;



TextStyle txt3 = TextStyle(
    fontFamily: 'Montserrat', fontSize: 32, fontWeight: FontWeight.w700);

class _NoteDetailsState extends State<NoteDetails> {

  TextEditingController title = new TextEditingController();
  TextEditingController description = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    title.text = widget.name;
    description.text = widget.desc;

    String v = widget.name;

    if(widget.name == null)
      {
        v = "New Note";
      }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          v,
          style: TextStyle(
              letterSpacing: 2,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w700),
        ),
        leading: InkWell(
          child: Icon(Icons.arrow_back_ios),
          onTap: () {
            List<dynamic> r = [false];
            Navigator.pop(context, r);
          },
        ),
      ),
      body: Container(
          child: Center(
        child: Wrap(
          children: <Widget>[
            Center(
              child: Text(
                "Note Keeper",
                style: txt3,
              ),
            ),
            Container(
              child: TextField(
                controller: title,
                decoration: InputDecoration(
                    labelText: "Note",
                    labelStyle: TextStyle(
                        fontFamily: 'montserrat',
                        color: Colors.green,
                        letterSpacing: 2),
                    prefixIcon: Icon(
                      Icons.book,
                      color: Colors.green,
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green, width: 5)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green, width: 5))),
                style: TextStyle(
                    fontFamily: 'montserrat', fontWeight: FontWeight.w600),
              ),
              padding: EdgeInsets.all(25),
            ),
            Container(
                padding: EdgeInsets.all(25),
                child: TextField(
                  controller: description,
                  maxLines: 3,
                  minLines: 1,
                  decoration: InputDecoration(
                      labelText: "Description",
                      labelStyle: TextStyle(
                          fontFamily: 'montserrat',
                          color: Colors.green,
                          letterSpacing: 2),
                      prefixIcon: Icon(
                        Icons.text_fields,
                        color: Colors.green,
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.green, width: 5)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 5, color: Colors.green))),
                  style: TextStyle(
                      fontFamily: 'montserrat', fontWeight: FontWeight.w600),
                )),
            Container(
              padding: EdgeInsets.all(25),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Container(
                          margin: EdgeInsets.only(left: 5, right: 5),
                          child: RaisedButton(
                            child: Text(
                              widget.existing,
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                            color: Colors.green,
                            onPressed: () {
                              if(widget.existing == "SAVE") {
                                List<dynamic> r = [
                                  true,
                                  title.text,
                                  description.text
                                ];
                                Navigator.pop(context, r);
                              }
                              else if(widget.existing == "UPDATE")
                                {
                                  List<dynamic> r = [true, widget.id, title.text, description.text];
                                  Navigator.pop(context, r);
                                }
                            },
                          )
                      )
                  ),

                ],
              ),
            ),
          ],
        ),
      )),
    );


  }
}
