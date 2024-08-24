import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:try240721/main.dart';
import 'package:try240721/HomePage.dart';
import 'package:try240721/PersonalInfo.dart';
import 'package:try240721/KnowledgePage.dart';
import 'package:try240721/MessagePage.dart';

void main() {
  runApp(MaterialApp(
    home: HistoricalRecord(),
  ));
}

class  HistoricalRecord extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('跌倒紀錄'),
      //   backgroundColor: Color(0xFFF5E3C3),
      // ),
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              color:Color(0xFFF5E3C3),
              width: double.infinity,
              padding: EdgeInsets.all(10.0),
              child:Center(
                child: Text('跌倒紀錄',
                  style: TextStyle(fontSize: 24,height: 5),
                ),
              ),),
          Container(
            child: Text('這是跌倒紀錄頁面',
              style: TextStyle(fontSize: 24),
            ),),
        ],),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '首頁'),
          BottomNavigationBarItem(icon: Icon(Icons.history_edu), label: '跌倒紀錄'),
          BottomNavigationBarItem(icon: Icon(Icons.lightbulb_outline), label: '知識補充'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_outlined), label: '123'),
          BottomNavigationBarItem(icon: Icon(Icons.person_sharp), label: '個人資料'),
        ],
        currentIndex: 1,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(color: Colors.orange), // 选中文字颜色
        unselectedLabelStyle: TextStyle(color: Colors.grey), // 未选中文字颜色

        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          }
          else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HistoricalRecord()),
            );
          }
          else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => KnowledgePage()),
            );
          }
          else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MessagePage()),
            );
          }
          else if (index == 4) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PersonalInfo()),
            );
          }
        },
      ),
    );
  }
}