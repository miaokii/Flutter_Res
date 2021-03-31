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
    // return MultiProvider(
    //   providers: <SingleChildWidget> [
    //     ChangeNotifierProvider.value(value: ThemeModel()),
    //     ChangeNotifierProvider.value(value: UserModel())
    //   ],
    // 消费者，当主题和语言改变时，会重新构建
    // child: Consumer<ThemeModel> (
    //   builder: (context, theme, child) {
    //     return
    //   },
    // ),
    return ScreenUtilInit(
      designSize: Size(375, 667),
      allowFontScaling: false,
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter_ScreenUtil',
        theme: ThemeData(
            primaryColor: Colors.white,
            visualDensity: VisualDensity.adaptivePlatformDensity),
        routes: {
          '/': (context) => LoginPage(),
          'main': (context) => MainPage()
        },
      ),
    );
  }
}
