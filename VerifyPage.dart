import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:try240721/HomePage.dart';
import 'package:try240721/main.dart';
import 'package:mysql_client/mysql_client.dart';
import 'package:try240721/RegisterPage.dart';
void main() {
  runApp(MaterialApp(
    home: VerifyPage(),
  ));
}

class VerifyPage extends StatefulWidget {//ful會改變
  @override
  _VerifyPageState createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  final TextEditingController _verifyController = TextEditingController();
  @override
  void initState() {//初始化
    super.initState();
    _fetchData();//連資料庫
  }

  void _fetchData() async {
    //MYSQL
    final conn = await MySQLConnection.createConnection(
      host: '203.64.84.154',
      //127.0.0.1 10.0.2.2
      port: 33061,
      userName: 'root',
      password: 'Topic@2024',
      databaseName: 'care', //testdb
    );
    await conn.connect();
  }

  @override
  Widget build(BuildContext context) {
    debugPaintSizeEnabled=false;
    return Scaffold(
      //appBar: AppBar(
      //title: Text('Demo'),
      //backgroundColor: Color(0xFF81D4FA),
      //),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 40), // 添加间距
                    height: 100, // 设置logo高度
                    child: Icon(
                      Icons.account_circle,
                      size: 100, // 设置图标大小
                      color: Color(0xFF4FC3F7), // 设置图标颜色
                    ),
                  ),
                  Text(
                    '全方位照護守護者',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),//全方位照護守護者
                  SizedBox(height: 20),
                  TextField(
                    controller: _verifyController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.verified_user_outlined),//https://www.fluttericon.cn/v
                      labelText: '用戶姓名',
                    ),
                  ),//用戶姓名

                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: registerBtn,
                    child: Text(' 註冊'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF4FC3F7), // 按钮颜色
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                  ),//登入
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text('取消註冊'),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.transparent, // 无背景颜色
                      textStyle: TextStyle(fontSize: 18),
                      shadowColor: Colors.transparent, // 去除阴影
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  void registerBtn() async {
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
      // 获取用户输入的账号和密码
      String name = _verityController.text;
      String email = _emailController.text;
      String age = _ageController.text;

      // 查询数据库，检查是否有匹配的账号
      var result = await conn.execute(
        'SELECT * FROM users WHERE email = :email AND age = age',
        {'email': email, 'age': age},
      );

      if (result.rows.isNotEmpty) {
        // 如果找到匹配的账号，提示註冊失败
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('登录失败：账号或密码错误')),
        );
      } else {
        // 否则插入新用户数据到数据库
        await conn.execute(
          'INSERT INTO users (name, email, age) VALUES (:name, :email, :age)',
          {'name': name, 'email': email, 'age': age},
        );

        // 提示用户注册成功并返回登录页面
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('注册成功！')),
        );

        // 清空输入框
        _nameController.clear();
        _emailController.clear();
        _ageController.clear();

        // 导航回登录页面
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }
    } catch (e) {
      print('数据库错误: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('登录失败：系统错误')),
      );
    } finally {
      await conn.close();
    }
  }
}