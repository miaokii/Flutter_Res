import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        'self_manager': (context)=>TapBoxA(),
        'parent_manager': (context)=>ParentWidget(),
        'booth_manager': (context) => ParentWidgetC(),
        'base_widget': (context) => FlutterBasicForm(),
        'form': (context) => FormTestRoute(),
        '/': (context) => HomePage()
      },
      initialRoute: '/',
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('状态管理'),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              child: Text('Widget管理自身状态'),
              color: Colors.red,
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context).pushNamed('self_manager');
              },
            ),
            FlatButton(
              child: Text('父Widget管理子Widget状态'),
              onPressed: () {
                Navigator.of(context).pushNamed('parent_manager');
              },
            ),
            FlatButton(
              child: Text('混合状态管理'),
              onPressed: () {
                Navigator.of(context).pushNamed('booth_manager');
              },
            ),
            FlatButton(
              child: Text('基础组建'),
              onPressed: (){
                Navigator.of(context).pushNamed('base_widget');
              },
            ),
            FlatButton(
              child: Text('表单组建'),
              onPressed: (){
                Navigator.of(context).pushNamed('form');
              },
            )
          ],
        ),
      ),
    );
  }
}

// TapBoxA管理自身状态
// -------- TapBoxA --------
class TapBoxA extends StatefulWidget {
  
  TapBoxA({
    Key key
  }): super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TapBoxAState();
  }
}

class _TapBoxAState extends State<TapBoxA> {
  bool _active = false;

  void _handleTap() {
    setState(() {
      _active = !_active;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('自身管理state'),
      ),
      // 手势检测widget
      body: GestureDetector(
        onTap: _handleTap,
        child: Container(
          child: new Text(
            _active ? 'Active' : 'Inactive',
            style: new TextStyle(fontSize: 20.0, color: Colors.white),
            textAlign: TextAlign.center,
            
          ),
          width: 200.0,
          height: 200.0,
          decoration: BoxDecoration(
            color: _active ? Colors.lightGreen[700] : Colors.grey[700]
          ),
        ),
      )
    );
  }
}

// ParentWidget管理TapBoxB状态
// --------- ParentWidget ---------
class ParentWidget extends StatefulWidget {
  @override
  State<ParentWidget> createState() => _ParentWidgetState();
}

class _ParentWidgetState extends State<ParentWidget> {
  bool _active = false;

  void _handleTapBoxChanged(bool newValue) {
    setState(() {
      _active = !_active;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // 传递parent管理的状态
      child: new TapBoxB(
        active: _active,
        // 监听触摸
        onChanged: _handleTapBoxChanged,
      ),
    );
  }
}

// --------- TapBoxB ----------
class TapBoxB extends StatelessWidget {
  TapBoxB({
    Key key,
    this.active: false,
    @required this.onChanged
  }): super(key: key);

  // 状态
  final bool active;
  // 点击回调 闭包
  final ValueChanged<bool> onChanged;

  void _handleTap() {
    onChanged(!active);
  }

  @override
  Widget build(BuildContext context) {  
    return new GestureDetector(
      onTap: _handleTap,
      child: Scaffold(
        appBar: AppBar(
        title: Text('Parent管理state'),
      ),
      body: Container(
        child: new Text(
            active ? 'Active' : 'Inactive',
            textAlign: TextAlign.center,
            style: new TextStyle(
              fontSize: 32.0,
              color: Colors.white
            ),
          ),
        width: 200,
        height: 200,
        decoration:  new BoxDecoration(
          color: active ? Colors.lightGreen[700] : Colors.grey[700]
        )
      ),
      )
    );
  }
}

// ParentWidget
// 共同管理状态
// parent管理点击状态
// tapBoxc管理自身高亮状态
class ParentWidgetC extends StatefulWidget {
  @override
  _ParentWidgetCState createState() => _ParentWidgetCState();
}

class _ParentWidgetCState extends State<ParentWidgetC> {
  bool _active = false;
  void _handleTapBoxChanged(bool newValue) {
    setState(() {
      _active = !_active;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TapBoxC(
        active: _active,
        onChanged: _handleTapBoxChanged,
      ),
    );
  }
}

class TapBoxC extends StatefulWidget {

  TapBoxC({
    Key key,
    this.active: false,
    @required this.onChanged
  }): super(key: key);

  final bool active;
  final ValueChanged<bool> onChanged;
  
  @override
  State<StatefulWidget> createState() {
    return _TapBoxCState();
  }
}

class _TapBoxCState extends State<TapBoxC> {
  bool _highlight = false;

  void _higlightTapDown(TapDownDetails details) {
    setState(() {
      _highlight = true;
    });
  }

  void _highlightTapUp(TapUpDetails details) {
    setState(() {
      _highlight = false;
    });
  }

  void _highlightTapCancel() {
    setState(() {
      _highlight = false;
    });
  }

  void handleTap() {
    // statefulState自身保持着widget对象的引用
    widget.onChanged(!widget.active);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _higlightTapDown,
      onTapUp: _highlightTapUp,
      onTap: handleTap,
      onTapCancel: _highlightTapCancel,
      child: Container(
        child: new Center(
          child: new Text(
            widget.active ? 'active' : 'inactive',
            style: new TextStyle(
              fontSize: 32, 
              color: Colors.white,
              height: 1,
              background: Paint()..color = Colors.red,
              decoration: TextDecoration.underline,
              decorationStyle: TextDecorationStyle.dashed,
            )
          ),
        ),
        width: 200,
        height: 200,
        decoration: new BoxDecoration(
          color: widget.active ? Colors.lightGreen[700] : Colors.grey[600],
          border: _highlight ? new Border.all(
            color: Colors.red[700],
            width: 10
          ) : null
        ),
      ),
    );
  }
}

// ---- 控件 ----
class FlutterBasicForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() { 
    return _FlutterBasicFormState();
  }
}

class _FlutterBasicFormState extends State<FlutterBasicForm> with SingleTickerProviderStateMixin {

  // bool _switchValue = false;
  // bool _checkValue = false;

  // nameField 键盘控制器
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  FocusNode _nameFocusNode = FocusNode();
  FocusNode _passFocusNode = FocusNode();
  FocusScopeNode _focusScopeNode;

  AnimationController _animationController;

  @override
  void initState() {
    // 监听文本变化
    _passController.addListener((){
     print(_passController.text); 
    }
    );

    // 设置默认值
    _nameController.text = 'miaokii';
    // 默认选中
    _nameController.selection = TextSelection(
      baseOffset: 3,
      extentOffset: 6
    );

    // 监听聚焦
    _nameFocusNode.addListener((){
      print('nameField focus: ${_nameFocusNode.hasFocus}');
    });

    _passFocusNode.addListener((){
      print('passField focus: ${_passFocusNode.hasFocus}');
    });

    // 动画
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 4
      )
    );
    _animationController.forward();
    _animationController.addListener( (){
      setState(() {
        print('改变进度');        
      });
    }
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _nameController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('基础组建'),
      ),
      body: Theme(
        data: Theme.of(context).copyWith(
          hintColor: Colors.green,
          inputDecorationTheme: InputDecorationTheme(
            //定义label字体样式
            labelStyle: TextStyle(color: Colors.grey),
            //定义提示文本样式
            hintStyle: TextStyle(color: Colors.grey, fontSize: 20)
          )
        ),
        child: Padding(
          padding: EdgeInsets.all(17),
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // Text.rich(TextSpan(
              //   children: [
              //     TextSpan(
              //       text: '1、TextSpan:'
              //     ),
              //     TextSpan(
              //       text: 'https://baidu.com',
              //       style: TextStyle(
              //         color: Colors.blue
              //       ),
              //     ),
              //   ]
              // )
              // ),
              // RaisedButton(
              //   child: Text('RaisedButton'),
              //   onPressed: (){
              //     print('RaisedButton pressed');
              //   },
              // ),
              // FlatButton(
              //   child: Text('FlatButton'),
              //   onPressed: (){
              //     print('FlatButton pressed');
              //   },
              // ),
              // OutlineButton(
              //   child: Text('OutlineButton'),
              //   onPressed: () {
              //     print('OntlineButton pressed');
              //   },
              // ),
              // IconButton(
              //   icon: Icon(Icons.thumb_up),
              //   onPressed: () {
              //     print('IconButton pressed');
              //   },
              // ),
              // RaisedButton.icon(
              //   icon: Icon(Icons.send),
              //   label: Text('发送'),
              //   onPressed: (){
              //     print('带图标button');
              //   },
              // ),
              // RaisedButton(
              //   // 背景色
              //   color: Colors.blue,
              //   // 高亮色
              //   highlightColor: Colors.blue[700],
              //   // 按钮主题，深色，文字颜色和按钮主题反着
              //   colorBrightness: Brightness.dark,
              //   // 
              //   splashColor: Colors.grey,
              //   child: Text('自定义按钮'),
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(20),
              //   ),
              //   onPressed: () {
              //     print('flatButton tap');
              //   },
              // ),
              Text('\uE914 \uE000 \uE90D',
              style: TextStyle(
                fontFamily: 'MaterialIcons',
                fontSize: 50,
                color: Colors.green
                )
              ),
              // Switch(
              //   value: _switchValue,
              //   onChanged: (value){
              //     setState(() {
              //       _switchValue = value;
              //     });
              //   },
              // ),
              
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: <Widget>[
              //     Checkbox(
              //       value: _checkValue,
              //       onChanged: (value) {
              //         setState(() {
              //           _checkValue = value;
              //         });
              //       },
              //     ),
              //     Text('复选框')
              //   ],
              // ),
              TextField(
                controller: _nameController,
                focusNode: _nameFocusNode,
                decoration: InputDecoration(
                  labelText: '用户名',
                  hintText: '用户名或邮箱',
                  prefixIcon: Icon(Icons.person),
                  // 隐藏下划线
                  // border: InputBorder.none
                ),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                style: TextStyle(
                  fontSize: 15
                ),
                textAlign: TextAlign.start,
                autofocus: false,
                obscureText: false,
                maxLines: 1,
                // 文本最大长度
                maxLength: 10,
                // 输入长度超过最大长度是否阻止输入，true阻止输入，false不阻止当时输入框会变红
                maxLengthEnforced: false,
                onChanged: (value) {
                  print('input $value');
                },
                onEditingComplete: (){
                  print('输入完成 ${_nameController.text}');
                },
                onSubmitted: (value) {
                  print('输入完成，输入结果：$value');
                },
                cursorColor: Colors.red,
                cursorRadius: Radius.circular(2),
                cursorWidth: 2,
              ),
              TextField(
                controller: _passController,
                focusNode: _passFocusNode,
                decoration: InputDecoration(
                  hintText: '至少8未数字加字母',
                  labelText: '密码',
                  prefixIcon: Icon(Icons.lock)
                ),
                obscureText: true,
                style: TextStyle(
                  fontSize: 15
                ),
              ),
              Container(
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: '电子邮件地址',
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.mail)
                  ),
                ),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.green, width: 4))
                ),
              ),
              Builder(builder: (ctx) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      child: Text('移动焦点'),
                      onPressed: (){
                        // 将焦点从第一个filed移动到第二个field
                        // 第一种方法
                        // FocusScope.of(context).requestFocus(_passFocusNode);
                        // 第二种方法
                        if (null == _focusScopeNode) {
                          _focusScopeNode = FocusScope.of(context);
                        }
                        _focusScopeNode.requestFocus(_passFocusNode);
                      },
                    ),
                    RaisedButton(
                      child: Text('隐藏键盘'),
                      onPressed: () {
                        _nameFocusNode.unfocus();
                        _passFocusNode.unfocus();
                      },
                    )
                  ],
                );
              },),
              // 如果进度条没有值，会播放循环动画，模糊进度
              LinearProgressIndicator(
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation(Colors.blue),
                value: 0.9,
              ),
              CircularProgressIndicator(
                // valueColor: ColorTween(
                //   begin: Colors.grey,
                //   end: Colors.blue
                // ).animate(_animationController),
                // value: _animationController.value,
              ),
              SizedBox(
                height: 20,
                child: LinearProgressIndicator(),
              ),
              SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(),
              )
            ],
          ),
        ),
      )
    );
  }
}

// 表单组建 FormField 抽象类，子类必须是 FormField类型
class FormTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FormTestRouteState();
  }
}

class _FormTestRouteState extends State<FormTestRoute> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  GlobalKey _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Test'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          // globalkey获取state
          key: _formKey,
          // 开启自动校验
          autovalidate: true,
          child: Column(
            children: <Widget>[
              TextFormField(
                autofocus: true,
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: '用户名或邮箱',
                  labelText: '用户名',
                  icon: Icon(Icons.person)
                ),
                // 校验用户名
                validator: (value){
                  return value.trim().length > 0 ? null : '用户名不能为空';
                },
              ),
              TextFormField(
                controller: _passController,
                decoration: InputDecoration(
                  labelText: '密码',
                  hintText: '您的登陆密码',
                  icon: Icon(Icons.lock)                  
                ),
                obscureText: true,
                validator: (value) {
                  return value.trim().length > 5 ? null : '密码不能少于6位';
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                /*  通过_formKey获取state
                child: Row(
                  children: <Widget>[
                    // 延伸到父widget row左右，colum上下
                    Expanded(
                      child: 
                      RaisedButton(
                        // 文字到边界距离
                        padding: EdgeInsets.all(15),
                        child: Text('登陆'),
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        onPressed: (){
                          // 不能通过Form.of(context)来获取state，
                          // 此处的context为FormTestRoute的context
                          // 而Form.of(context)是根据所指定context向根去查找，
                          // 而FormState是在FormTestRoute的子树中
                          if ((_formKey.currentState as FormState).validate()) {
                            print('通过验证，用户名：${_nameController.text}，密码：${_passController.text}');
                          }
                        },
                      ),
                    )
                  ],
                ),
                */
                // 通过 context获取
                // 通过Builder来构建登录按钮，Builder会将widget节点的context作为回调参数：
                child: Builder(builder: (context){
                  return RaisedButton(
                    padding: EdgeInsets.all(15),
                    child: Text('登陆'),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    onPressed: (){
                      // if ((_formKey.currentState as FormState).validate()) {
                      //   print('通过验证，用户名：${_nameController.text}，密码：${_passController.text}');
                      // }
                      // FormState _state = context.findAncestorStateOfType();
                      FormState _state = Form.of(context);
                      if (_state.validate()) {
                        print('通过验证，用户名：${_nameController.text}，密码：${_passController.text}');
                      }
                    },
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }

}