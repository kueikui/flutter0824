import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:try240721/main.dart';
import 'package:try240721/HomePage.dart';
import 'package:try240721/HistoricalRecord.dart';
import 'package:try240721/KnowledgePage.dart';
import 'package:try240721/MessagePage.dart';
import 'package:mysql_client/mysql_client.dart';
import 'package:http/http.dart' as http;
void main() {
  runApp(MaterialApp(
    home: PersonalInfo(),
  ));
}

class PersonalInfo extends StatefulWidget {
  @override
  _PersonalInfoState createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  String _name = '', _phone = '', _age = '',_gender = '',_email = '';

  @override
  void initState() {//初始化
    super.initState();
    _fetchData();
  }

  void _fetchData() async {//MYSQL
    final conn = await MySQLConnection.createConnection(
      //host: '203.64.84.154',
      host:'10.0.2.2',
      //127.0.0.1 10.0.2.2
      port: 3306,
      userName: 'root',
      //password: 'Topic@2024',
      password: '0000',
      //databaseName: 'care', //testdb
      databaseName: 'testdb',
    );

    await conn.connect();

    try {
      print('ok');
      var result = await conn.execute('SELECT name, phone, age, gender, email FROM users LIMIT 1');

      if (result.rows.isNotEmpty) {//有資料
        var row = result.rows.first;
        setState(() {
          _name = row.colAt(0)!;
          _phone = row.colAt(1)!;
          _age = row.colAt(2)!;
          _gender = row.colAt(3)!;
          _email = row.colAt(4)!;
        });
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      await conn.close();
    }
  }


  //頁面
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('個人資料'),
      //   backgroundColor: Color(0xFFF5E3C3),
      // ),
      body: Column(
        children: [
          Container(
            height: 100,
            color: Color(0xFFF5E3C3),//背景底色
            width: double.infinity,
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                '個人資料',
                style: TextStyle(fontSize: 24, height: 5),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  title: Text('姓名',style: TextStyle(fontSize: 20),),
                  subtitle: Text(_name),
                  //trailing: Icon(Icons.arrow_forward_ios),//>
                  onTap: () {//點了之後
                  },
                ),
                Divider(),
                ListTile(
                  title: Text('手機'),
                  subtitle: Text(_phone),
                  //trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {

                  },
                ),
                Divider(),
                ListTile(
                  title: Text('生日'),
                  subtitle: Text(_age),
                  //trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {

                  },
                ),
                Divider(),
                ListTile(
                  title: Text('性別'),
                  subtitle: Text(_gender),
                  //trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {

                  },
                ),
                Divider(),
                ListTile(
                  title: Text('EMAIL'),
                  subtitle: Text(_email),
                  //trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {

                  },
                ),
                Divider(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '首頁'),
          BottomNavigationBarItem(icon: Icon(Icons.history_edu), label: '跌倒紀錄'),
          BottomNavigationBarItem(icon: Icon(Icons.lightbulb_outline), label: '知識補充'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_outlined), label: '123'),
          BottomNavigationBarItem(icon: Icon(Icons.person_sharp), label: '個人資料'),
        ],
        currentIndex: 4,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
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
