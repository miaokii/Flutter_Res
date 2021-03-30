
import 'package:flutter/material.dart';
import 'package:github_client/common/api_type.dart';
import 'package:github_client/index.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {

  int _role = 1;
  void _login() {
    Navigator.of(context).pushNamed('main');
  }

  void _setRole(int role) {
    setState(() {
      _role = role;
    });
  }

  List<Widget> _bodyWidgets() {
    return [
      Padding(padding: EdgeInsets.only(top: 77.r),
        child: Image(image: AssetImage('assets/images/login_logo.png'),
            width: 90.w,
            height: 90.h
        ),
      ),
      Padding(padding: EdgeInsets.only(top: 10.r),
          child: LoginRoleWidget((role) => _setRole(role))
      ),
      Padding(padding: EdgeInsets.only(top: 10.r),
        child: LoginInputWidget(),),
      Padding(padding: EdgeInsets.only(top: 45.r, left: 30, right: 30),
          child: Row(
            children: [
              Expanded(
                child: MaterialButton(child: Text('登 录', style: TextStyle(fontSize: 18),),
                  textColor: Colors.white,
                  height: 40,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  color: Color(0xff5FCA88),
                  onPressed: _login,
                ),
              )
            ],
          )
      )
    ];
  }

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
                    children: _bodyWidgets()
                )
            )
        )
    );
  }
}

class LoginRoleWidget extends StatefulWidget {

  LoginRoleWidget(this._onSelectedRole);
  Function(int) _onSelectedRole;

  @override
  State<StatefulWidget> createState() {
    return new _LoginRoleState();
  }
}

class _LoginRoleState extends State<LoginRoleWidget> {

  Function get _onSelectedRole => widget._onSelectedRole;
  /// 1是云厨房工作人员、2是门店人员
  int _role = 1;

  void _roleStaffSwitch() {
    if (_role == 2) {
      setState(() {
        _role = 1;
        _onSelectedRole(_role);
      });
    }
  }

  void _roleStoresSwitch() {
    if (_role == 1) {
      setState(() {
        _role = 2;
        _onSelectedRole(_role);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 30, right: 10),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  children: [
                    CusTextButton('云厨房工作人员',
                      fontSize: _role == 1 ? 18 : 15,
                      onPress: _roleStaffSwitch,
                    ),
                    Container(
                      color: Color(0xff5FCA88),
                      height: _role == 1 ? 3 : 0,
                      width: 45.r,
                    )
                  ],
                ),
                Column(
                  children: [
                    CusTextButton('门店人员',
                      fontSize: _role == 2 ? 18 : 15,
                      onPress: _roleStoresSwitch,
                    ),
                    Container(
                      color: Color(0xff5FCA88),
                      height: _role == 2 ? 3 : 0,
                      width: 45.r,
                    )
                  ],
                )
              ],
            ),
          ],
        )
    );
  }
}

class LoginInputWidget extends StatefulWidget {

  Function(bool) _loginTypeSwitch;

  @override
  State<StatefulWidget> createState() {
    return _LoginInputState();
  }
}

class _LoginInputState extends State<LoginInputWidget> {

  /// 是否是验证码登录
  bool _pwdLogin = true;
  /// 登录类型切换回调
  Function get _loginTypeSwitch => widget._loginTypeSwitch;

  void _pwdSwitch(){
    setState(() {
      _pwdLogin = !_pwdLogin;
      // _loginTypeSwitch(_vCodeLogin);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 30, right: 30, top: 10),
        // color: Colors.red,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextFormField(
                decoration: InputDecoration(
                    hintText: _pwdLogin ? '请输入用户名' : '请输入手机号',
                    icon: Icon(_pwdLogin ? Icons.person : Icons.phone_android_outlined, color: Color(0xFF5FCA88)),
                    border: InputBorder.none
                )
            ),
            Divider(height: 1,),
            Padding(padding: EdgeInsets.only(top: 5),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: _pwdLogin ? '请输入密码': '请输入验证码',
                    icon: Icon(_pwdLogin ? Icons.lock : Icons.verified_user_sharp, color: Color(0xFF5FCA88),),
                    border: InputBorder.none,
                    suffix: !_pwdLogin ? CusTextButton('发送验证码',
                      fontSize: 12,
                      textColor: Color(0xff5FCA88),
                      onPress: (){},) : null,
                  ),
                  obscureText: _pwdLogin,
                )
            ),
            Divider(height: 1,),
            CusTextButton(_pwdLogin ? '验证码登录' : '密码登录',
                textColor: Colors.black54,
                fontSize: 13,
                onPress: _pwdSwitch),
          ],
        )
    );
  }
}

class LoginRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginRouteState();
  }
}

class _LoginRouteState extends State<LoginRoute> {

  TextEditingController _nameField = TextEditingController();
  TextEditingController _pwdField = TextEditingController();

  /// 是否显示密码
  bool pwdShow = false;
  GlobalKey _formKey = new GlobalKey<FormState>();
  /// 用户框第一响应
  bool _nameAutoFocus = true;

  // 初始状态，自动填写上次登录的用户名，将焦点定位到输入密码的位置
  @override
  void initState() {
    _nameField.text = Global.profile.lastLogin;
    if (_nameField.text.isNotEmpty) {
      _nameAutoFocus = false;
    }
    super.initState();
  }

  void _passLogin() async {
    // 校验合法
    if ((_formKey.currentState as FormState).validate()) {
      HUD.loading(context);
      Map param = {
        "password": _pwdField.text,
        "type":1,
        "username": _nameField.text,
      };
      Result res = await NetReq.request(API.pwdLogin, params: param, method: Method.POST);
      HUD.hide(context);
      if (200 == res.code) {
        User user = User.fromJson(res.data);
        Provider.of<UserModel>(context, listen: false).user = user;
      } else {
        HUD.flash(res.message);
      }
    } else {
      HUD.flash('请输入用户名和密码');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('登录'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          autovalidate: true,
          child: Column(
            children: [
              TextFormField(
                autofocus: _nameAutoFocus,
                controller: _nameField,
                decoration: InputDecoration(
                  hintText: '用户名或邮箱',
                  labelText: '用户名',
                  icon: Icon(Icons.person)
                ),
                validator: (value) {
                  return value.trim().isNotEmpty ? null : '用户名不能为空';
                },
              ),
              TextFormField(
                controller: _pwdField,
                decoration: InputDecoration(
                  labelText: '密码',
                  hintText: '登录密码',
                  icon: Icon(Icons.lock),
                  suffix: IconButton(
                    icon: Icon(pwdShow ? Icons.remove_red_eye_outlined : Icons.remove_red_eye,
                    color: Colors.blue,),
                    onPressed: (){
                      setState(() {
                        pwdShow = !pwdShow;
                      });
                    },
                  )
                ),
                obscureText: !pwdShow,
                validator: (pwd) {
                  return pwd.trim().length > 4 ? null : '密码不少于4位';
                },
              ),
              Padding(padding: EdgeInsets.only(top: 20),
                child: RaisedButton(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Text('登录'),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  onPressed: _passLogin,
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}