import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:try240721/HomePage.dart';
import 'package:mysql_client/mysql_client.dart';
import 'package:try240721/RegisterPage.dart';
void main() {
  runApp(MaterialApp(
    home: LoginPage(),
  ));
}

class LoginPage extends StatefulWidget {//ful會改變
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  @override
  void initState() {//初始化
    super.initState();
    _fetchData();//連資料庫
  }

  void _fetchData() async {
    //MYSQL
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
                    controller: _emailController, // 绑定电子邮件输入框的控制器
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email_outlined),//https://www.fluttericon.cn/v
                      labelText: '電子信箱',
                    ),
                  ),//電子信箱
                  SizedBox(height: 20),
                  TextField(
                    controller: _ageController, // 绑定电子邮件输入框的控制器
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock_outlined),
                      labelText: '密碼',
                    ),
                    obscureText: true,
                  ),//密碼
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: loginBtn,/*() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    },*/
                    child: Text(' 登入'),
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
                        MaterialPageRoute(builder: (context) => Registerpage()),
                      );
                    },
                    child: Text('立即註冊'),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.transparent, // 无背景颜色
                      textStyle: TextStyle(fontSize: 18),
                      shadowColor: Colors.transparent, // 去除阴影
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    },
                    child: Text('忘記密碼'),
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
  void loginBtn() async {
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
      String email = _emailController.text;
      String age = _ageController.text;

      print('输入的名称: $email');
      print('输入的电话: $age');

      // 查询数据库，检查是否有匹配的账号
      var result = await conn.execute(
        'SELECT * FROM users WHERE name = :name AND age = :age',
        {'name': email, 'age': age},
      );

      print('查询结果行数: ${result.rows.length}');

      if (result.rows.isNotEmpty) {
        _emailController.clear();
        _ageController.clear();
        // 如果找到匹配的账号，登录成功，跳转到主页
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        // 没有找到匹配的账号，提示登录失败
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('登录失败：账号或密码错误')),
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