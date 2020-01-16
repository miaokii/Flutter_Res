# state生命周期

一个StatefulWidget在创建和移除中，state生命周期如下：

1. initState
2. didChangeDependencies
3. build
4. deactivate
5. despose

## 1、initState

当Widget第一次插入到Widget树时会被调用，对于每一个State对象，Flutter framework只会调用一次该回调，所以，通常在该回调中做一些一次性的操作，如状态初始化、订阅子树的事件通知等。不能在该回调中调用`BuildContext.inheritFromWidgetOfExactType`（该方法用于在Widget树上获取离当前widget最近的一个父级`InheritFromWidget`），原因是在初始化完成后，Widget树中的`InheritFromWidget`也可能会发生变化，所以正确的做法应该在在`build（）`方法或`didChangeDependencies()`中调用它。

## 2、didChangeDependencies

当State对象的依赖发生变化时会被调用；例如：在之前`build()` 中包含了一个`InheritedWidget`，然后在之后的`build()` 中`InheritedWidget`发生了变化，那么此时`InheritedWidget`的子widget的`didChangeDependencies()`回调都会被调用。

> 场景：当系统语言Locale或应用主题改变时，Flutter framework会通知widget调用此回调。

## 3、build

构建widget子树，在以下场景被调用

1. 在调用`initState()`之后。
2. 在调用`didUpdateWidget()`之后。
3. 在调用`setState()`之后。
4. 在调用`didChangeDependencies()`之后。
5. 在State对象从树中一个位置移除后（会调用deactivate）又重新插入到树的其它位置之后

## 4、didUpdateWidget

在widget重新构建时，Flutter framework会调用`Widget.canUpdate`来检测Widget树中同一位置的新旧节点，然后决定是否需要更新，如果`Widget.canUpdate`返回`true`则会调用此回调。`Widget.canUpdate`会在新旧widget的key和runtimeType同时相等时会返回true，也就是说在在新旧widget的key和runtimeType同时相等时`didUpdateWidget()`就会被调用。

## 5、deactivate

当State对象从树中被移除时，会调用此回调。在一些场景下，Flutter framework会将State对象重新插到树中，如包含此State对象的子树在树的一个位置移动到另一个位置时（可以通过GlobalKey来实现）。如果移除后没有重新插入到树中则紧接着会调用`dispose()`方法。

## 6、dispose

当State对象从树中被永久移除时调用；通常在此回调中释放资源。

<img src="https://cdn.jsdelivr.net/gh/flutterchina/flutter-in-action/docs/imgs/3-2.jpg" alt="State生命周期"  />