import 'package:flutter/material.dart';

class NoteDetail extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return NoteDetailState();
  }
}

class NoteDetailState extends State<NoteDetail>{

  static var _priorities=['Hight','Low'];

  TextEditingController titleController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();

  @override
  Widget build(BuildContext context) {

    TextStyle textStyle=Theme.of(context).textTheme.title;

    return Scaffold(
      appBar: AppBar(
        title:Text('Edit Note'),
      ),
      body: Padding(
          padding: EdgeInsets.only(top: 15.0,left:10.0,right:10.0),
        child: ListView(
          children: <Widget>[
            ListTile(
              title:DropdownButton(

                  items: _priorities.map((String dropDownStringItem){
                      return DropdownMenuItem<String>(
                        value:dropDownStringItem,
                        child:Text(dropDownStringItem),
                      );
                    }).toList(),

                  style:textStyle,

                  value:'Low',

                  onChanged: (valueSelectedByUser){
                    setState(() {
                      debugPrint('User selected $valueSelectedByUser');
                    });
                  }
              )
            ),

            //SECOND ELEMENT
            Padding(
              padding: EdgeInsets.only(top:15.0,bottom:15.0),
              child:TextField(
                controller: titleController,
                style:textStyle,
                onChanged: (value){
                  debugPrint('Something Changed in Title Text Field');
                },
                decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: textStyle,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  )
                ),
              )
            ),

            //THIRD ELEMENT
            Padding(
                padding: EdgeInsets.only(top:15.0,bottom:15.0),
                child:TextField(
                  controller: descriptionController,
                  style:textStyle,
                  onChanged: (value){
                    debugPrint('Something Changed in Description Text Field');
                  },
                  decoration: InputDecoration(
                      labelText: 'Description',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      )
                  ),
                )
            ),

            //FOURTH ELEMENT
            Padding(
              padding: EdgeInsets.only(top:15.0,bottom:15.0),
              child: Row(
                children: <Widget>[
                  //EXPANDED 1
                  Expanded(
                    child:RaisedButton(
                      color:Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child:Text(
                        'Save',
                        textScaleFactor:1.5,
                      ),
                      onPressed: (){
                        setState((){
                          debugPrint("Save button clicked");
                        });
                      },
                    )
                  ),

                  Container(width: 5.0,),

                  //EXPANDED 2
                  Expanded(
                      child:RaisedButton(
                        color:Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child:Text(
                          'Delete',
                          textScaleFactor:1.5,
                        ),
                        onPressed: (){
                          setState((){
                            debugPrint("Delete button clicked");
                          });
                        },
                      )
                  ),

                ],
              ),
            )

          ],
        ),
      )
    );
  }
}