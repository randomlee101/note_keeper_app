import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'note_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "NoteKeeper",
      theme: ThemeData(primarySwatch: Colors.green, fontFamily: 'Montserrat'),
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> data = [];
  List<String> sub = [];
  Color color;
  int count = 0;
  TextStyle txt;
  TextStyle txt3;

  void wholeProgram() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      txt = TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w600);
      txt3 = TextStyle(
          fontFamily: 'Montserrat', fontSize: 32, color: Colors.white);
      if(sharedPreferences.getStringList("data") != null) {
        data = sharedPreferences.getStringList("data");
        sub = sharedPreferences.getStringList("sub");
        count = data.length;
        color = Colors.green;
      }
    });
  }

  void add(String newData, String newSub) async{
    setState((){
      data.add(newData);
      sub.add(newSub);
      data = data;
      sub = sub;
      count = data.length;
    });

  }

  void setData() async
  {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove("data");
    sharedPreferences.remove("sub");
    sharedPreferences.setStringList("data", data);
    sharedPreferences.setStringList("sub", sub);
  }

  void getData() async
  {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    data = sharedPreferences.getStringList("data");
    sub = sharedPreferences.getStringList("sub");
  }


  void delete(int i) {
    setState(() {
      data = data;
      sub = sub;
      data.removeAt(i);
      sub.removeAt(i);
      count = data.length;
    });
  }

  void update(int i, String newData, String newSub) {
    setState(() {
      data = data;
      sub = sub;
      data.removeAt(i);
      data.insert(i, newData);
      sub.removeAt(i);
      sub.insert(i, newSub);
    });
  }

  @override
  Widget build(BuildContext context) {
    wholeProgram();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Note Keeper",
          style: txt,
        ),
        actions: <Widget>[
          GestureDetector(
            child: Icon(
              Icons.border_color,
              size: 20,
            ),
            onTap: () async {
              final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NoteDetails(
                            existing: 'SAVE',
                          )));
              if (result[0] == true) {
                add(result[1], result[2]);
                setData();
              }
            },
          ),
          SizedBox(
            width: 24,
          )
        ],
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: count,
        itemBuilder: ((context, count) {
          if(count == null)
            {
              return Center(child: Text("Nothing Here Yet"),);
            }
          else{
          return Card(
              child: ListTile(
            leading: CircleAvatar(
              child: Text(
                data[count].substring(0, 1),
                style: txt3,
              ),
              backgroundColor: color,
              radius: 32,
            ),
            title: Text(
              data[count],
              style: txt,
            ),
            subtitle: Text(
              sub[count],
              style: txt,
            ),
            trailing: GestureDetector(
              child: Icon(
                Icons.delete_outline,
                size: 28,
              ),
              onTap: () {
                print(data[count]);
                final snack = SnackBar(
                    content: Text(
                      "Note Deleted",
                      style: txt,
                    ),
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,
                    action: SnackBarAction(
                      textColor: Colors.white,
                      label: "UNDO",
                      onPressed: () {
                        print("UNDO");
                      },
                    ));
                Scaffold.of(context).showSnackBar(snack);
                delete(count);
                setData();
              },
            ),
            onTap: () async {
              print("Go to note details for " + data[count]);
              final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NoteDetails(
                            existing: 'UPDATE',
                            id: count,
                            name: data[count],
                            desc: sub[count],
                          )));
              if (result[0] == true) {
                update(result[1], result[2], result[3]);
                setData();
              }
            },
          ));
        }}),
      ),
    );
  }
}
