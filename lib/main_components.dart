import 'package:flutter/material.dart';
import 'data.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class NumEntry extends StatefulWidget {
  @override
  _NumEntryState createState() => _NumEntryState();
}

class _NumEntryState extends State<NumEntry> {

  int numOfEntry = 3;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Text(
              "$numOfEntry 명"
          ),
          Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(Icons.expand_less),
                  onTap: increaseNumOfEntry,
                ),
                GestureDetector(
                  child: Icon(Icons.expand_more),
                  onTap: decreaseNumofEntry,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void increaseNumOfEntry(){
    if(numOfEntry < 14){
      setState(() {
        numOfEntry += 1;
      });
    }
  }

  void decreaseNumofEntry(){
    if(numOfEntry > 3){
      setState(() {
        numOfEntry -= 1;
      });
    }
  }
}

class SelectSubject extends StatefulWidget {
  @override
  _SelectSubjectState createState() => _SelectSubjectState();
}

class _SelectSubjectState extends State<SelectSubject> {

  final List<DropdownMenuItem> subjects = [];
  String currentSubject = "주제";

  @override
  void initState() {
    for(String s in subjectList){
      subjects.add(
        DropdownMenuItem(
          child: Text(s),
          value: s,
        )
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SearchableDropdown.single(
              items: subjects,
              hint: "select",
              value: currentSubject,
              searchHint: "select subject one",
              onChanged: (subject){
                setState(() {
                  currentSubject = subject;
                });
              },
            isExpanded: false,
          )
        ],
      ),
    );
  }
}

class OnOffButton extends StatefulWidget {
  @override
  _OnOffButtonState createState() => _OnOffButtonState();
}

class _OnOffButtonState extends State<OnOffButton> {

  bool currentState = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: setButton(currentState),
    );
  }

  Widget setButton(bool isOn){
    if(isOn){
      return onButton();
    } else {
      return offButton();
    }
  }

  Widget onButton(){
    return GestureDetector(
      onTap: changeState,
      child: Container(
        height: 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
            width: 1
          )
        ),
        child: Center(
          child: Text(
            "ON", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget offButton(){
    return GestureDetector(
      onTap: changeState,
      child: Container(
        height: 30,
        decoration: BoxDecoration(
            color: Colors.grey[600],
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
                width: 1
            )
        ),
        child: Center(
          child: Text(
            "OFF", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  void changeState(){
    setState(() {
      currentState = !currentState;
    });
  }
}

