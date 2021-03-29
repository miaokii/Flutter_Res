import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:github_client/routes/login_page.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'index.dart';

void main() {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 多顶层共享数据，多个数据共享
    // 将主题、用户、语言三种状态绑定到应用上
    // 如此，任何路由中都可以通过Provider.of来
    // 获取当前状态，这三种状态是全局共享的
    return MultiProvider(
      providers: <SingleChildWidget> [
        ChangeNotifierProvider.value(value: ThemeModel()),
        ChangeNotifierProvider.value(value: UserModel())
      ],
      // 消费者，当主题和语言改变时，会重新构建
      child: Consumer<ThemeModel> (
        builder: (context, theme, child) {
          return ScreenUtilInit(
            designSize: Size(375, 667),
            builder: () => MaterialApp(
              theme: ThemeData(
                  primarySwatch: theme.theme
              ),
              onGenerateTitle: (context) {
                return "ds";
              },
              routes: {
                'login': (context) => LoginRoute(),
                'lo': (context) => LoginPage(),
                '/': (context) => HomePage()
              },
            ),
          );
        },
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/login_bg.png'),
            fit: BoxFit.cover
          ),
        ),
        // 在安全区域内布局
        child: SafeArea(
          child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(padding: EdgeInsets.only(top: 77.r),
                  child: Image(image: AssetImage('assets/images/login_logo.png'),
                  width: 90.w,
                  height: 90.h
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 40.r),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    LoginRoleWidget()
                  ],
                )),
                Padding(padding: EdgeInsets.only(top: 10.r),
                child: LoginInputWidget(),)
            ]
        )
        )
      )
    );
  }
}

class LoginRoleWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _LoginRoleState();
  }
}

class _LoginRoleState extends State<LoginRoleWidget> {

  void _roleSwitch() {

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 30, right: 10),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: _roleSwitch,
                child: Text('云厨房工作人员',
                    style: TextStyle(
                    fontSize: 18
                    ),
                ),
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.resolveWith((states) {
                    return Colors.black;
                  }),

                  padding: MaterialStateProperty.all(EdgeInsets.all(10))
                ),
              ),

              TextButton(
                onPressed: _roleSwitch,
                child: Text('门店人员'),
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.resolveWith((states) {
                      return Colors.black;
                    }),
                    padding: MaterialStateProperty.all(EdgeInsets.all(10))
                ),
              ),
            ],
          ),
          Container(
            width: 48.w,
            height: 3.w,
            color: Colors.green,
          )
        ],
      )
    );
  }
}

class LoginInputWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginInputState();
  }
}

class _LoginInputState extends State<LoginInputWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 30, right: 30),
      height: 100.h,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
        ],
      ),
    );
  }
}
