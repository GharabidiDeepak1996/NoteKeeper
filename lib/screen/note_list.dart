import 'package:flutter/material.dart';
import 'package:flutternotekeeperapp/database/dao.dart';
import 'package:flutternotekeeperapp/database/database.dart';
import 'package:flutternotekeeperapp/database/entity.dart';

import 'note_create.dart';

class NoteList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NoteListState();
  }
}
class NoteListState extends State<NoteList> with WidgetsBindingObserver{

  var count=0;
  List<Note> noteList;


  @override
  void initState() {
super.initState();
WidgetsBinding.instance.addObserver(this);
    updateList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NoteKeeper App"),
      ),
   body: getNoteListView(),
    floatingActionButton: FloatingActionButton(
      elevation: 2.0,
      tooltip: 'Add Note',
      child: Icon(Icons.add),
      onPressed: (){
        navigateToDetail("Add Note");
        debugPrint('floating button on tapped');
      },
    ),);
  }

  //function
  ListView getNoteListView(){
    TextStyle textStyle=Theme.of(context).textTheme.subhead;
return ListView.builder(
     //important
    itemCount: count,
    itemBuilder: (BuildContext context,int postion){
       //in this here i will get the list of items then Add into Listtile. And listTile return to ListView
      return  Dismissible(
          key: Key(noteList[postion].toString()),
          onDismissed: (direction){
            var item=noteList[postion].title;
            var itemId=noteList[postion].id;
            debugPrint("itemID $itemId");
            deleteItem(itemId);
            noteList.removeAt(postion);
            Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('$item deleted')));
          },
        background: Container(
          alignment: Alignment.centerRight,
          margin: EdgeInsets.all(7.0),
          padding: EdgeInsets.only(right: 20.0),
          color: Colors.red,
          child: Icon(Icons.delete_sweep,
            color: Colors.white,),
        ) ,
          child: Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: getPriorityColor(noteList[postion].priority),
                child: getPriorityIcon(noteList[postion].priority),
              ),

              title: Text(noteList[postion].title, style: textStyle,),
              subtitle: Text(noteList[postion].date,style: textStyle,),
              /*trailing: Icon(Icons.delete,
                color: Colors.grey,),*/
              onTap: (){
                navigateToDetail("Edit Note");
              },),
          ),
      );
    });
  }

  void navigateToDetail(String title) async{
   bool result= await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => NoteDetail(title),),
    );
   if(result == true){
   updateList();
   }
  }

  Future<List> fetchAllList() async {
    final database = await $FloorAppDatabase.databaseBuilder('flutter_database.db').build();
   return database.personDao.findAllNotes();
  }
  // Returns the priority color
  Color getPriorityColor(String priority) {
    switch (priority) {
      case 'High':
        return Colors.red;
        break;
      case 'Low':
        return Colors.yellow;
        break;

      default:
        return Colors.yellow;
    }
  }

  // Returns the priority icon
  Icon getPriorityIcon(String priority) {
    switch (priority) {
      case 'High':
        return Icon(Icons.play_arrow);
        break;
      case 'Low':
        return Icon(Icons.keyboard_arrow_right);
        break;

      default:
        return Icon(Icons.keyboard_arrow_right);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      // went to Background
    }
    if (state == AppLifecycleState.resumed) {
      // came back to Foreground
    }
  }


  void updateList(){
    Future<List> list= fetchAllList();
    list.then((value){
      setState(() {
        noteList=value;
        count= noteList.length;
      });
    });
  }

  Future<void> deleteItem(int id) async{
    final database = await $FloorAppDatabase.databaseBuilder('flutter_database.db').build();
     database.personDao.deleteParticularItem(id);
  }

}
