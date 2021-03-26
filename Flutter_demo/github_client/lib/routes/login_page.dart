
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:github_client/common/api_type.dart';
import 'dart:async';
import 'package:github_client/index.dart';
import 'package:provider/provider.dart';

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
        "password": _nameField.text,
        "type":2,
        "username": _pwdField.text
      };
      NetReq.request<User>(API.pwdLogin,
          params: param,
          method: Method.POST,
          onSuccess: (data) {
            print(data);
          }, onError: (error) {
            print(error);
          });

      // User user;
      // try {
      //   // user = await NetReq(context).pwdLogin(_nameField.text, _pwdField.text);
      //   // // 登录页面返回后，首页后build，传false，更新user后不触发更新
      //   // Provider.of<UserModel>(context, listen: false).user = user;
      // } catch (e) {
      //   print(e);
      // } finally {
      //   Navigator.of(context).pop();
      // }
      //
      // if (user != null) {
      //   Navigator.of(context).pop();
      // }
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
                  icon: Icon(Icons.lock)
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