import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'data.dart';

class Sub extends StatelessWidget {

  static String subject;
  static int entryNum;
  static bool spyMode;

  Sub(String getSubject, int getEntryNum, bool getSpymode){
    subject = getSubject;
    entryNum = getEntryNum;
    spyMode = getSpymode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("게임 주제 :", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
                Text("$subject", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.brown, fontSize: 40),),
              ],
            ),
            SizedBox(height: 20,),
            CheckWord()
          ],
        ),
      ),
    );
  }
}

class CheckWord extends StatefulWidget {
  @override
  _CheckWordState createState() => _CheckWordState();
}

class _CheckWordState extends State<CheckWord> {

  String word = subjectMap[Sub.subject][Random().nextInt(subjectMap[Sub.subject].length)];
  bool isHide = true;
  int liar = Random().nextInt(Sub.entryNum -1) + 1;
  int spy = 0;
  int currentNum = 1;

  @override
  void initState() {
    liar = Random().nextInt(Sub.entryNum - 1) + 1;
    if(Sub.spyMode){
      spy = Random().nextInt(Sub.entryNum - 2) + 1;
      if(spy >= liar){
        spy += 1;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(currentNum > Sub.entryNum){
      return Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Container(
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Center(child: Text("게임을 시작하세요!", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 30),)),
        ),
      );
    } else {
      return isHide ? hideContainer(currentNum) : checkSubject(currentNum);
    }
  }

  Widget hideContainer(int n){
    return GestureDetector(
      onTap: (){
        setState(() {
          isHide = !isHide;
        });
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Container(
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("$n 번", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),),
                    Text("순서가 제시어를 확인할 차례입니다.", style: TextStyle(fontWeight: FontWeight.bold),),
                  ],
                ),
                Text("제시어 확인하기")
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget checkSubject(int n){
    Timer(Duration(seconds: 3), (){
      print("hello");
      setState(() {
        isHide = !isHide;
        currentNum ++;
      });
    });
    return Container(
      width: double.infinity,
      height: 100,
      child: Center(
        child: n == liar
            ? Text("라이어 당첨!", style: TextStyle(fontWeight: FontWeight.bold),)
            : n == spy ? Text("스파이 당첨!\n제시어는 $word", style: TextStyle(fontWeight: FontWeight.bold),)
                        : Text("제시어는 $word", style: TextStyle(fontWeight: FontWeight.bold),),
      )
    );
  }
}

