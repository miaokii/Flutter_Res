## 1、StatefulWidget

`StatefulWidget`有状态的组建，可以拥有状态，状态在Weight的声明周期是可变的

`Stateful Widget`至少由两个类组成
- `StatefulWidget`类
- `State`类，StatefulWidget类本身不可变，但是state类的状态在weiget的生命周期可能变化

## 2、build方法的位置
将`build`方法放在`state`里面，可以提交开发的灵活性，如果将build（）方法放在StatefulWidget中会存在两个问题：

1. 状态访问不便
    
    `StatefulWidget`有很多状态，每种状态改变都会调用build方法，但是状态是保存在state中的，如果build方法在widget里面，build和state就分别在两个类里面，state状态为公开状态，失去私密性，状态也不可控

2. 继承`StatefulWidget`不便

    `AnimatedWidget`是动画基类，继承自`StatefulWidget`，`AnimatedWidget`引用了抽象方法`build(BuildContext context)`，继承自`AnimatedWidget`的类都要实现该方法，如果`StatefulWidget`中也有了`build`方法，并且`build`接受`state`对象，这就意味着`AnimatedWidget`必须将自己的`State`对象(记为`_animatedWidgetState`)提供给其子类，因为子类需要在其`build`方法中调用父类的`build`方法，代码可能是这样的：
    ```dart
      class MyAnimationWidget extends AnimatedWidget{
      @override
      Widget build(BuildContext context, State state){
        //由于子类要用到AnimatedWidget的状态对象_animatedWidgetState，
        //所以AnimatedWidget必须通过某种方式将其状态对象_animatedWidgetState
        //暴露给其子类   
        super.build(context, _animatedWidgetState)
      }
    ```

    这样很显然是不合理的，因为
    - `AnimatedWidget`的状态对象是`AnimatedWidget`内部实现细节，不应该暴露给外部
    - 如果要将父类状态暴露给子类，那么必须得有一种传递机制，而做这一套传递机制是无意义的，因为父子类之间状态的传递和子类本身逻辑是无关的。

## 3、MaterialPageRoute
`MaterialPageRoute`继承自`PageRoute`类，`PageRoute`是抽象类，表示占有整个屏幕空间的模态路由页面，定义了路由构建和切换过度动画

`MaterialPageRoute`提供在不同平台一致的切换动画
- Android：新页面从底部滑动到顶部，关闭反之 present
- iOS：push动画

`MaterialPageRoute`构造函数
```dart
MaterialPageRoute({
    // 回调函数，构建路由页面的具体内容，返回值是Widget
    WidgetBuilder builder,
    // 路由配置信息（名称，是否是初始路由）
    RouteSettings settings,
    // push新的路由时，是否保存原来的路由，要释放设置为false
    bool maintainState = true,
    // 是否为模态对话框，全屏滑入，对应present
    bool fullscreenDialog = false
})

// 如果自己实现动画，继承PageRoute实现
```
