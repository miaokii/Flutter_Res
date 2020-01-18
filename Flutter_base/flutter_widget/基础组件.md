

# Widget

## 1、widget

几乎每个Flutter都是`widget`，不仅可以展示UI元素，也可以表示特定功能的组件，App主题数据传递的Theme等

> Everything is widget

## 2、Widget与Element

在Flutter中，Widget的功能是“描述一个UI元素的配置数据”，它就是说，Widget其实并不是表示最终绘制在设备屏幕上的显示元素，而它只是描述显示元素的一个配置数据。

实际上，Flutter中真正代表屏幕上显示元素的类是`Element`，**Widget只是UI元素的一个配置数据，并且一个Widget可以对应多个`Element`**。这是因为同一个Widget对象可以被添加到UI树的不同部分，而真正渲染时，UI树的每一个`Element`节点都会对应一个Widget对象。总结一下：

- Widget实际上就是`Element`的配置数据，Widget树实际上是一个配置树，而真正的UI渲染树是由`Element`构成；但是由于`Element`是通过Widget生成的，所以它们之间有对应关系，在大多数场景，可以宽泛地认为Widget树就是指UI控件树或UI渲染树。
- 一个Widget对象可以对应多个`Element`对象，根据同一份配置（Widget），可以创建多个实例`Element`。

## 3、Widget主要接口

Widget类的声明：

```dart
@immutable
abstract class Widget extends DiagnosticableTree {
  const Widget({ this.key });
  final Key key;

  @protected
  Element createElement();

  @override
  String toStringShort() {
    return key == null ? '$runtimeType' : '$runtimeType-$key';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.defaultDiagnosticsTreeStyle = DiagnosticsTreeStyle.dense;
  }

  static bool canUpdate(Widget oldWidget, Widget newWidget) {
    return oldWidget.runtimeType == newWidget.runtimeType
        && oldWidget.key == newWidget.key;
  }
}
```

- `Widget`类继承自`DiagnosticableTree`，`DiagnosticableTree`即“诊断树”，主要作用是提供调试信息。
- `Key`: 主要的作用是决定是否在下一次`build`时复用旧的widget，决定的条件在`canUpdate()`方法中。
- `createElement()`：如前所述“一个Widget可以对应多个`Element`”；Flutter Framework在构建UI树时，会先调用此方法生成对应节点的`Element`对象。此方法是Flutter Framework隐式调用的，在我们开发过程中基本不会调用到。
- `debugFillProperties(...)` 复写父类的方法，主要是设置诊断树的一些特性。
- `canUpdate(...)`是一个静态方法，它主要用于在Widget树重新`build`时复用旧的widget，其实具体来说，应该是：是否用新的Widget对象去更新旧UI树上所对应的`Element`对象的配置；通过其源码我们可以看到，只要`newWidget`与`oldWidget`的`runtimeType`和`key`同时相等时就会用`newWidget`去更新`Element`对象的配置，否则就会创建新的`Element`。

为Widget显式添加key的话可能（但不一定）会使UI在重新构建时变的高效。

`Widget`类本身是一个抽象类，其中最核心的就是定义了`createElement()`接口，在Flutter开发中，我们通常会通过继承`StatelessWidget`或`StatefulWidget`来间接继承`Widget`类来实现。

## 4、StatelessWidget

`StatelessWidget`继承自Widget，重写了`createElement()`

```dart
@override
StatelessElement createElement() => new StatelessElement(this);
```

`StatelessElement` 间接继承自`Element`类，与`StatelessWidget`相对应（作为其配置数据）。

`StatelessWidget`用于不需要维护状态的场景，它通常在`build`方法中通过嵌套其它Widget来构建UI，在构建过程中会递归的构建其嵌套的Widget。

```dart
// 回显字符串 的 widget
class Echo extends StatelessWidget {
  const Echo({
    Key key,  
    @required this.text,
    this.backgroundColor:Colors.grey,
  }):super(key:key);

  final String text;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: backgroundColor,
        child: Text(text),
      ),
    );
  }
}

// 使用
Widget build(BuildContext context) {
  return Echo(text: "hello world");
}
```

> `widget`的构造函数参数应使用命名参数，其中的必要参数要添加`@required`标注，这样有利于静态代码分析器进行检查。在继承`widget`时，第一个参数通常应该是`Key`，如果Widget需要接收子Widget，那么`child`或`children`参数通常应被放在参数列表的最后。按照惯例，StatelessWidget的属性应尽可能的被声明为`final`，防止被意外改变。

## 5、Context

`build`方法有一个`context`参数，它是`BuildContext`类的一个实例，表示当前widget在widget树中的上下文，每一个widget都会对应一个context对象（因为每一个widget都是widget树上的一个节点）。

`context`是当前widget在widget树中位置中执行”相关操作“的一个句柄，比如它提供了从当前widget开始向上遍历widget树以及按照widget类型查找父级widget的方法。

```dart
body: Container(
        child: Builder(builder: (context) {
          // 在Widget树中向上查找最近的父级`Scaffold` widget
          Scaffold scaffold = context.ancestorWidgetOfExactType(Scaffold);
          // 直接返回 AppBar的title， 此处实际上是Text("Context测试")
          return (scaffold.appBar as AppBar).title;
        }),
      ),
```

## 6、StatefulWidget

`StatefulWidget`继承自widget，重写了`createElement（）`，返回的`Element`对象和StatelessWidget不同。并且新增`createState()`方法

```dart
abstract class StatefulWidget extends Widget {
  const StatefulWidget({ Key key }) : super(key: key);

  @override
  StatefulElement createElement() => new StatefulElement(this);

  @protected
  State createState();
}
```

- `StatefulElement` 间接继承自`Element`类，与StatefulWidget相对应（作为其配置数据）。`StatefulElement`中可能会多次调用`createState()`来创建状态(State)对象。
- `createState()` 用于创建和Stateful widget相关的状态，它在Stateful widget的生命周期中可能会被多次调用。例如，当一个Stateful widget同时插入到widget树的多个位置时，Flutter framework就会调用该方法为每一个位置生成一个独立的State实例，其实，本质上就是一个`StatefulElement`对应一个State实例。

## 7、state

State维护StatefulWidget的状态，其中的状态信息可以：

1. 在widget创建被读取
2. 在widget生命周期被改变，当state改变，手动调用setState()方法通知SDK状态改变，随后SDK调用build()重新构建widget树，跟新UI

State有两个常用属性

1. widget：当前state实例相关联的widget实例

2. context：StatefulWidget对应的BuildContext

   ### 7.1、state生命周期

   一个StatefulWidget在创建和移除中，state生命周期如下：

   1. initState

   2. didChangeDependencies

   3. build

   4. deactivate

   5. despose

      #### 7.1.1、initState

      当Widget第一次插入到Widget树时会被调用，对于每一个State对象，Flutter framework只会调用一次该回调，所以，通常在该回调中做一些一次性的操作，如状态初始化、订阅子树的事件通知等。不能在该回调中调用`BuildContext.inheritFromWidgetOfExactType`（该方法用于在Widget树上获取离当前widget最近的一个父级`InheritFromWidget`），原因是在初始化完成后，Widget树中的`InheritFromWidget`也可能会发生变化，所以正确的做法应该在在`build（）`方法或`didChangeDependencies()`中调用它。

      #### 7.1.2、didChangeDependencies

      当State对象的依赖发生变化时会被调用；例如：在之前`build()` 中包含了一个`InheritedWidget`，然后在之后的`build()` 中`InheritedWidget`发生了变化，那么此时`InheritedWidget`的子widget的`didChangeDependencies()`回调都会被调用。

      > 场景：当系统语言Locale或应用主题改变时，Flutter framework会通知widget调用此回调。

      #### 7.1.3、build

      构建widget子树，在以下场景被调用

      1. 在调用`initState()`之后。
      2. 在调用`didUpdateWidget()`之后。
      3. 在调用`setState()`之后。
      4. 在调用`didChangeDependencies()`之后。
      5. 在State对象从树中一个位置移除后（会调用deactivate）又重新插入到树的其它位置之后

      #### 7.1.4、didUpdateWidget

      在widget重新构建时，Flutter framework会调用`Widget.canUpdate`来检测Widget树中同一位置的新旧节点，然后决定是否需要更新，如果`Widget.canUpdate`返回`true`则会调用此回调。`Widget.canUpdate`会在新旧widget的key和runtimeType同时相等时会返回true，也就是说在在新旧widget的key和runtimeType同时相等时`didUpdateWidget()`就会被调用。

      #### 7.1.5、deactivate

      当State对象从树中被移除时，会调用此回调。在一些场景下，Flutter framework会将State对象重新插到树中，如包含此State对象的子树在树的一个位置移动到另一个位置时（可以通过GlobalKey来实现）。如果移除后没有重新插入到树中则紧接着会调用`dispose()`方法。

      #### 7.1.6、dispose

      当State对象从树中被永久移除时调用；通常在此回调中释放资源。

<img src="https://cdn.jsdelivr.net/gh/flutterchina/flutter-in-action/docs/imgs/3-2.jpg" alt="State生命周期"  />

### 7.2、在widget树中获取state对象

StatefulWidget的逻辑在State里面，获取state对象可以调用一些方法。如：`Scaffold`组建的状态类`ScaffoldState`中定义了`SnackBar`（底部提示条），可以提示信息。

#### 7.2.1、通过context获取

context对象有个`findAncestorStateOfType()`方法，该方法从当前节点沿着widget树想上查找state对象。

```dart
ScaffoldState _state = context.findAncestorStateOfType();
_state.showSnackBar(
  SnackBar(
    content: Text('我是SnackBar'),
  )
);
```

如果StatefulWidget状态是私有的，不应获取state对象，如果是共有的，可以获取state对象，但是context.findAncestorStateOfType获取的state状态是通用的，不能在语法层面指定state是否私有，所以Flutter SDK语法层面有了默认约定：

- 如果StatefulWidget状态希望暴露，应当在在SatefulWidget中提供`of`静态方法获取state对象
- 如果StatefulWidget状态不希望暴露，不提供of方法

```dart
ScaffoldState _state=Scaffold.of(context); 
_state.showSnackBar(
  SnackBar(
    content: Text("我是SnackBar"),
  ),
);
```

#### 7.2.2、GlobalKey

通过GlobalKey可获取state对象，步骤为：

1. 给StatefulWidget添加`GlobalKey`
2. 通过GlobalKey获取state

```dart
class _CounterWidgetState extends State<ConterWidget> {
  // GlobalKey保证全局唯一性，静态变量存储
  static GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    ScaffoldState _state = _globalKey.currentState;
    _state.showSnackBar(
      SnackBar(
        content: Text('我是SnackBar'),
      )
    );
  }
}
```

GlobalKey是Flutter提供的一种在整个APP中引用element的机制。如果一个widget设置了`GlobalKey`，就我们便可以通过`globalKey.currentWidget`获得该widget对象、`globalKey.currentElement`来获得widget对应的element对象，如果当前widget是`StatefulWidget`，则可以通过`globalKey.currentState`来获得该widget对应的state对象。

> 注意：使用GlobalKey开销较大，如果有其他可选方案，应尽量避免使用它。另外同一个GlobalKey在整个widget树中必须是唯一的，不能重复。

