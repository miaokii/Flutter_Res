## 1、变量

1. 一切皆对象，未初始化对象的默认值是null

2. 强类型语言

3. dynamic动态类型，var对象类型

4. Final和Const
   使用中从来不会修改的变量

   * Final: 只能被设置一次
   * Const: 在编译时已经确定（隐式的Final类型）

   >实例变量可以是final类型但不能是const类型。必须在构造函数执行前初始化final实例变量

## 2、内建类型

所有内建类型

- Number
- String
- Boolean
- List
- Map
- Set
- Rune
- Symbol

### 2.1、Number

Number有两种类型，int和double

- int：数值不大于64位，-2^63到2^63-1
- double: 64位浮点数

```Dart
var x = 1;
var hex = 0x124fdf;

var y = 1.1;
var y = 1.43e5;

// dart2.1后，必要时int字面量会自动转换double类型
double z = 1;

// 将字符串转换数字
var one = int.parse('1');
var oneString = one.toString();
var onePointOne = double.parse('1.1');
var onePointOneString = onePointOne.toString();

// double->String保留2位
// 3.14
String piAsString = 3.14159.toStringAsFixed(2);
```

int的按位操作

```Dart
// 0011 >> 1 = 0001
assert((3>>1) == 1);
// 0011 << 1 = 0110
assert((3<<1) == 6);
// 0011 | 0100 = 0111
assert((3|4) == 7);
// 0011 & 0100 = 0000
assert((3&4) == 0);
```

>数字类型的字面量是编译时常量，算术表达式中，只要计算因子是编译时常量，表达式结果也是编译时常量

### 2.2、String

字符串是一组UFT-16序列，字符串可以通过`${expression}`的方式内嵌表达式，如果表达式是标识符，{}可以省略

> 对象的toString()方法可以得到对象相应的字符串

```Dart
var s1 = 'string interpolation';
var s2 = 1.toString();
var s3 = s1.toUpperCase();
var s4 = s1 + ' ' + s3;
var s5 = ''' you 
can create
mulit-line String
''';
// 原始字符串
var s6 = r'In a raw string, even \n isn`t special.';
```

>一个编译时常量的字面量字符串中，如果存在插值表达式，表达式内容也是编译时常量， 那么该字符串依旧是编译时常量。 插入的常量值类型可以是 null，数值，字符串或布尔值。

```Dart
// const 类型数据
const aConstNum = 0;
const aConstBool = true;
const aConstString = 'a constant string';

// 非 const 类型数据
var aNum = 0;
var aBool = true;
var aString = 'a string';
const aConstList = [1, 2, 3];

//const 类型数据
const validConstString = '$aConstNum $aConstBool $aConstString';
//非 const 类型数据
const invalidConstString = '$aNum $aBool $aString $aConstList'; 
```

### 2.3、Boolean

`bool`表示布尔值，只有`true`和`false`是布尔类型，都是编译时常量，类型安全要求条件表达式应该明确使用true或false，进行明确的检查

```Dart
// 检查空字符串
var fullName = '';
print(fullName.isEmpty);

// 检查0
var point = 0;
print(point < 0);

// 检查null
var unicorn;
print(unicorn == null);

// 检查NaN
var iMeantToDoThis = 0/0;
print(iMeantToDoThis.isNaN);
```

### 2.4、List

在List字面量前添加const关键字，定义List类型的编译时常量

```Dart
// 类型推断为 List<int>类型
var list = [1, 2, 4];
liet[0] = 2
// 不能更改
var constList = const [1, 2, 4];
// constList[0] = 2 错误
```

### 2.5、Set

Set集合，元素唯一且无序

```Dart
// 类型推断为Set<String>，不能添加其他类型元素
var halogens = {'hello', 'chlorine', 'bromine', iodine};

// 创建空集合
var names1 = <String>{};
Set<String> names2 = {};
// 添加元素
names1.add('kai');
// 添加集合
names1.addAll(names2);
// 长度
print(names1.length)
// 这是Map，不是Set
var address = {};
// 编译时Set常量
final constantSet = const {
    'fluirine',
    'chlorine',
    'bormine',
    'iodine'
}
```

### 2.6、Map

Map就是字典，key-value键值对，key，value可以是任意类型，key不可重复

```Dart
// Map<String: String>
var gifts = {'first': 'partridge',
'second': 'turtledoves',
'fifth': 'golden rings'
}

// Map<int, String>
var nobleGass = {2: '2',
10: 'none',
18: 'argon'
}

// Map构造函数
var gifts = Map()
gifts['first'] = 1
gifts['second'] = 2

// 获取value    
// 1
print(gifts['first'])
// null
print(gifts['ddd'])
// 2
print(gifts.length)

// 运行时常量Map
final constantMap = const {
    'name': 'Lucy',
    'pass': '122212'
}
```

### 2.7 Rune

Rune表示字符串中的UTF-32编码字符。Dart字符串是一系列的UTF-16编码单元，要表示32位Unicode值需要Rune支持

>表示 Unicode 编码的常用方法是， \uXXXX, 这里 XXXX 是一个4位的16进制数。 例如，心形符号 (♥) 是 \u2665。 对于特殊的非 4 个数值的情况， 把编码值放到大括号中即可。 例如，emoji 的笑脸 (😀) 是 \u{1f600}。

`String`有属性可以获取rune数据。`codeUnitAt`和`codeUint`返回16位编码数据，属性`runes`获取字符串中的Rune

```Dart
var clapping = '\u{1f44f}';
// 👏
print(clapping);
// [55357, 56399]
print(clapping.codeUnits);
// [128079]
print(clapping.runes.toList());

Runes input = new Runes(
      '\u2665  \u{1f605}  \u{1f60e}  \u{1f47b}  \u{1f596}  \u{1f44d}');
// ♥  😅  😎  👻  🖖  👍
print(new String.fromCharCodes(input));
```

### 2.8、Symbol

Symbol对象表示Dart中申明的运算符或者标识符，如果要按名称引用标识符的 API 时， Symbol 就非常有用，因为代码压缩后会改变标识符的名称，但不会改变标识符的符号。 通过字面量 Symbol ，也就是标识符前面添加一个 # 号，来获取标识符的 Symbol 

```Dart
#radix
#bar
```

## 3、函数

函数也是对象，类型是`Function`，所以函数可以被赋值给变量或者作为参数传递给其他函数，也可以将Dart的类实例当作方法调用

```Dart
// 类型申明可以省略
bool isNoble(int num) {
    return _nobleGases[num] != null;
}

// 函数只有一行表达式，可以间简写
bool isNoble(int num) => _nobleGases[num] != null;
```

> `=>expr`语法是`{ return expr; }`的简写

函数有两种参数类型: required 和 optional。 required 类型参数在参数最前面， 随后是 optional 类型参数。 命名的可选参数也可以标记为 “@ required” 

### 3.1、可选参数

命名参数或者位置参数

#### 3.1.1、命名可选参数

调用函数可以使用指定命名参数`paramName: value`

```Dart
// 函数参数有名字 bold，hidden
enableFlags(bold: true, hidden: false);
```

定义函数时，使用`{param1, param2}`指定命名参数

```Dart
void enableFlags({bool bold, bool hidden}){...}

// 构造函数
// @required必填参数
const Scrollbar({Key key, @required Widget child})
```

#### 3.1.2、位置可选参数

将参数放到[]中标记参数是可选的

```Dart
String say(String form, String msg, [String device]) {
    var result = '$form says $msg';
    if (device != null) {
        result = '$result with a $device';
    }
    return result;
}
```

#### 3.1.3、默认参数值

定义方法时，可以使用=定义可选参数的默认值，默认值是编译时常量。若没有提供默认值，则为null

```Dart
// 命名可选参数的默认参数值
void func1({String name = 'MK'}) { 
  print('$name');
}
// 位置可选参数的默认参数值
void func2(String name, [int age = 2]) { 
  print('$name is $age years old');
}
```

list或map可以作为默认值传递

```Dart
// 默认参数值必须是编译时常量
void doStuff(
    {List<int> list = const [1, 2, 4],
    Map<String, String> gifts = const {
        'first': 'paper',
        'second': 'cotton',
        'third': 'leather'
    }}
) {
    print('list: $list');
    print('map: $gifts');
}
```

### 3.2、main()函数

main()是应用的入口，返回值为空，参数为可选的`List<String>`

```Dart
// web应用main（）
// ..是连级调用，相当于swift链式调用
void main() {
  querySelector('#sample_text_id')
    ..text = 'Click me!'
    ..onClick.listen(reverseText);
}

// 命令行应用main（）
void main(List<String> arguments) {
  ...
}
```

### 3.3、函数是一等对象

函数可以作为另一个函数的参数

```Dart
void printElement(int element) {
  print(element);
}

var list = [1, 2, 4];
// 将printElement函数作为参数传递
list.forEach(printElement);
```

可以将函数赋值给变量

```Dart
void printUpperCaseString(String msg) {
  print('${msg.toUpperCase()}');
}
// 赋值给变量printUpper
var printUpper = printUpperCaseString;
// HELLO MERY
printUpper('hello mery');

// 匿名函数
var loudify = (msg) => '${msg.toUpperCase()}';
print(loudify('hello'))
```

### 3.4、匿名函数

没有名字的函数，也被称为`lambda`或`closure`，匿名函数可以赋值给变量

```Dart
var list = ['apple', 'oranges', 'bananas'];
list.forEach((item) {
  print('index${list.indexOf(item)}: $item');
});
```

如果函数只有一条语句，可以使用简写

```Dart
list.forEach(
  (item) => print('index${list.indexOf(item)}: $item')
);
```

### 3.5、词法作用域

变量的作用域是固定的，在编码的时候变量作用域就已经确定

### 3.6、词法闭包

闭包就是一个函数对象，即使调用在原始作用域之外，它仍然可以捕获它作用域内的变量

```Dart
// 返回一个函数，返回的函数参数与[addBy]相加
Function makeAdder(num addBy) {
  // 使用闭包返回
  return (num i) => addBy + i;
}

// 等价于
Function makeAdder(num addBy) {
  num add(num i) {
    return addBy + i;
  }
  return add;
}

var add2 = makeAdder(2);
var add4 = makeAdder(4);
// 6
print(add2(4));
// 10
print(add4(6));
```

### 3.7、返回值

所有函数都有返回值，没有明确指定返回值，函数体会隐式添加`return null`

## 4、流程控制语句注意⚠️

- Dart的判断条件必须是布尔值，同swift

- switch case 的比较对象必须是同一类型，类没有重写==

- switch语句仅适用于有限情况

- switch每个非空case都要跟break跳出，或者continue、throw、return

- switch支持空的case语句

- 要在非空的case中实现fall-through形式，可以使用continue语句结合lebal方式实现

  >```Dart
  >var chara = 'a';
  >  switch (chara) {
  >    case 'a':
  >      print('a');
  >      // 不会跳出switch，会寻找toc标记的case，继续执行
  >      continue toc;
  >    case 'b':
  >      print('b');
  >      break;
  >    toc:
  >    case 'c':
  >      print('c');
  >      break;
  >    case 'd':
  >      print('d');
  >      break;
  >    default:
  >      print('--');
  >  }
  >
  >// a c
  >```

- assert语句语句中的条件为false，程序流程会被中断

- assert只在开发环境有效

##  5、异常

抛出和捕获异常，异常表示未知的错误情况，若没有捕获异常，异常抛出，导致异常的代码终止。异常有两种类型

- Exceotion
- Error

### 5.1、throw

```dart
// 抛出异常
throw FormatException('Expected at last 1 section');
// 抛出任意对象
throw 'out of llamas!'
```

因为抛出异常是一个表达式，可以在=>语句中使用，亦可在其他使用表达式的地方抛出异常

```Dart
void distanceTo(Point other) => throw UnimplementedError();
```

### 5.2、catch

捕获异常可以避免异常继续传递，可以指定多个catch，处理多种异常

```Dart
try {
  breedMoreLlamas();
} on OutOfLlamasException {
  // 一个特殊的异常
  buyMoreLlamas();
} on Exception catch (e) {
  // 其他任何异常
  print('Unknown exception: $e');
} catch (e) {
  // 没有指定的类型，处理所有异常
  print('Something really unknown: $e');
}
```

捕获语句中可以同时使用 `on` 和 `catch` ，也可以单独分开使用。 使用 `on` 来指定异常类型， 使用 `catch` 来 捕获异常对象，catch()函数可以指定1-2个参数，第一个是异常对象，第二个位堆栈信息

```Dart
try {
  // ···
} on Exception catch (e) {
  print('Exception details:\n $e');
} catch (e, s) {
  print('Exception details:\n $e');
  print('Stack trace:\n $s');
}
```

如果仅需要部分处理异常， 那么可以使用关键字 `rethrow` 将异常重新抛出

```Dart
void misbehave() {
  try {
    dynamic foo = true;
    print(foo++); // Runtime error
  } catch (e) {
    print('misbehave() partially handled ${e.runtimeType}.');
    rethrow; // Allow callers to see the exception.
  }
}

void main() {
  try {
    misbehave();
  } catch (e) {
    print('main() finished handling ${e.runtimeType}.');
  }
}
```

### 5.3、finaly

不管是否抛出异常，finally中的代码都会执行。如果`catch`没有匹配到异常，异常会在finally执行完后再次抛出

```dart
try {
    // 可能后抛出异常语句
  } catch (e) {
		// 捕获到异常
  } finally {
  	// 最后执行
}
```

## 6、类

Dart类基于Mixin继承机制，所有类都继承于`Object`

```Dart
class Point {
  // 未初始化的实例变量（属性）初始值null
  num x;	
  num y;
  num z = 0;
  
  // 与类名相同的构造函数
  Point(num x, num y) {
    this.x = x;
    // this可以省略
    y = y;
  }
}
```

> 类中`this`可以引用当前实例，当存在命名冲突时，必须使用this关键字，否则this可以省略

### 6.1、构造函数

构造函数创建对象，构造函数命名可以是`ClassName`或者`ClassName.identifier`

> - 没有声明构造函数时，Dart会提供默认构造函数
> - 子类不会继承父类的构造方法
> - 子类如果不声明构造函数，他就只有默认的构造函数（匿名，没有参数）

```Dart
class Point{
  num x, y;
  // 在构造函数执行前，语法糖已经设置了变量x和y
  Point(this.x, this.y);
}
```

使用构造函数创建实例

```Dart
// new关键字是可选的
var p1 = new New Point(1, 2);
var p2 = Point.formJson({'x':1, 'y':2});
```

#### 6.1.1、命名构造函数

命名构造函数可以为类实现多个构造函数，可以更清晰表达函数意图

```dart
class Point {
  num x, y;
  Point(this.x, this.y);
  // 命名构造函数-原点
  Point.origin() {
    x = 0;
    y = 0;
  }
}
```

#### 6.1.2、调用父类非默认构造函数

默认情况下，子类构造函数会自动调用父类的默认构造函数（匿名，无参），执行顺序：

1. initalizer list（初始化参数列表）
2. superclass's no-arg constructor（父类无名构造函数）
3. mian class's no-arg constructor（主类无名构造函数）

如果父类中没有匿名无参的构造函数，则要手动调用父类的其他构造函数，在当前构造函数冒号`:`之后，函数体之前，声明调用父类构造函数

```dart
class Person {
  String firstName;
	Person.fromJson(Map data) {
    print('in Person');
  }
}

class Employee extends Person {
	Employee.fromJson(Map data): super.fromJson(data) {
    print('in Employee');
  }
}

main(){
  var emp = Employee.fromJson({});
  /*	打印结果
  	父类的构造函数先于本类调用
  	in Person
		in Employee
  */
  if (emp is Employee) {
    emp.firstName = 'Bob';
  }
  // emp.firstName = Lucy
  (emp as Person).firstName = 'Lucy';
}
```

父类的构造函数参数在构造函数执行之前执行，所以参数可以是一个表达式或方法

```dart
class Employee extends Person {
  Employee(): super.fromJson(getDefaultData());
}
```

#### 6.1.3、重定向构造函数

有的构造函数的目的是重定向到同一类中的另一个构造函数，重定向构造函数的函数体为空，构造函数调用在冒号之后

> 其实就是自己调用自己的构造函数

```dart
import 'dart:math';

class Point{
  final num x, y;
  final num distance;
  
  Point(x, y)
    : x = x,
      y = y,
      distance = sqrt(x*x + y*y);
  
  // this(x, 0)就是Point(x, y)方法
	Point.alongXAxis(num x): this(x, 0);
}
```

#### 6.1.4、常量构造函数

如果要求生成的类对象固定不变，可以将对象定义为编译时常量，需要定义`const`构造函数，并声明所有实例变量为`final`

```dart
class ImmutablePoint {
  // 类属性
  static final ImmutablePoint origin = const ImmutablePoint(0, 0);
  // final修饰，实例属性
  final num x, y;
  // 在构造函数前加const创建编译时常量
  const ImmutablePoint(this.x, this.y);
}
```

构造两个相同的编译时常量会产生唯一一个实例

```Dart
var a = const ImmutablePoint(1, 1);
var b = const ImmutablePoint(1, 1);
// a和b是同一个实例
print(a==b);
```

常量上下文中，构造函数或者字面量前的const可以省略

```dart
// 常量上下文
const pointAndLine = {
  'point': [Point(1,1)],
  'line': [Point(1,10), Point(1, 11)]
};
```

脱离常量上下文，省略const创建的对象不是常量对象

```Dart
// 常量对象
var a = const Point(1, 2);
// 非常量对象
var b = Point(1, 2);
// false
print(a==b);
```

#### 6.1.5、工厂构造函数

当执行构造函数并不是总创建这个类的新的实例时，使用`factory`关键字。一个构造函数可能返回一个cache中的实例，或者返回子类的实例

> 工厂构造函数无法访问this

```dart
// 工厂构造函数
class Logger {
  final String name;
  bool mute = false;
  
  // _私有类属性
  static final Map<String, Logger> _cache = <String, Logger>{};
  
  // 私有构造函数
  Logger._internal(this.name);
  
  // 工厂构造函数
  factory Logger(String name) {
    if (_cache.containsKey(name)) {
      return _cache[name];
    } else {
      final logger = Logger._internal(name);
      _cache[name] = logger;
      return logger;
    }
  }
  
  void log(String msg) {
    if (!mute) print(msg);
  }
}
```

### 6.2、方法

方法为对象提供行为的函数，该行为可以时某个功能模块

```dart
[返回类型] [函数名]([参数列表]) {[函数实现]}
```

#### 6.2.1、实例方法

为实例对象调用

#### 6.2.2、Getter和Setter

每个实例属性都有getter，通常也有setter方法

```dart
class Rect {
  num left, top, width, height;
  Rect(this.left, this.top, this.width, this.height);
  
  // 两个计算属性 right和bottom
  num get right => left + width;
  set right(num value) => left = value - width;
  
  num get bottom => top + height;
  set bottom(num value) => top = value - height;
}
```

#### 6.2.3、抽象方法

实例方法，getter，setter方法可以抽象（只定义，不实现，显示交给其他类实现），抽象方法之存在于抽象类

```dart
// 抽象类和方法
abstract class Doer {
  // 抽象方法
  void doString();
}

class EffectiveDoer extends Doer {
  void doString() {
    // 实现抽象方法
  }
}
```

> 调用未实现的抽象方法会导致运行时错误

### 6.3、抽象类

使用`abstract`定义抽象类，抽象类不能被实例化。抽象类可以定义接口，以及部分实现

> 如果希望抽象类被实例话，可以定义工厂构造函数实现

### 6.4、隐式接口

每个类都隐式定义了一个接口，隐式接口包含了该类所有实例成员及其实现的接口

> A类要支持B类的API，但是不继承B，可以通过A实现B的接口

```dart
// 隐式接口
// Person类里隐式包含了greet()声明
class Person {
  // 包含在隐式接口里，但只在当前库可见
  final _name;
  // 不包含在隐式接口，因为这是构造函数
  Person(this._name);
  // 包含在隐式接口里
  String greet(String who) => "Hello, $who, I am $_name";
}

// Person接口实现
class Impostor implements Person {
  get _name => '';
  String greet(String who) => 'Hi $who. Do you know who I am?';
}

String greetBob(Person person) => person.greet('Bob');

// Hello, Bob, I am Kathy
print(greetBob(Person('Kathy')));
// Hi Bob. Do you know who I am?
print(greetBob(Impostor()));
```

一个类实现多个接口

```dart
class Point implements Comparable, Location {...}
```

### 6.5、继承

使用`extends`创建子类，使用`super`引用父类

#### 6.5.1、重写类成员

使用`@override`重写实例方法

#### 6.5.2、重写运算符

重载运算符实现想要的运算

```dart
class Vetor {
  final int x, y;
  Vetor(this.x, this.y);
  
  Vetor operator +(Vetor v) => Vetor(x + v.x, y + v.y);
  Vetor operator -(Vetor v) => Vetor(x - v.x, y - v.y);
}

var v1 = Vetor(1, 1);
var v2 = Vetor(1, 0);
  
assert(v1 + v2 == Vetor(2, 1));
assert(v1 - v2 == Vetor(0, 1));
```

> 重写`==`要重写对象的`hashCode` `getter`方法

#### 6.5.3、noSuchMethod()

当代码尝试调用不存在的方法或变量，重写noSuchMethod()方法处理

```dart
class A {
  // 如果不重写 noSuchMethod，访问
  // 不存在的实例变量时会导致 NoSuchMethodError 错误。
  @override
  void noSuchMethod(Invocation invocation) {
    print('You tried to use a non-existent member: ' +
        '${invocation.memberName}');
  }
}
```

除非符合下面的任意一项条件， 否则没有实现的方法不能够被调用：

- receiver 具有 `dynamic` 的静态类型 。
- receiver 具有静态类型，用于定义为实现的方法 (可以是抽象的), 并且 receiver 的动态类型具有 `noSuchMethod()` 的实现， 该实现与 `Object` 类中的实现不同。

### 6.6、枚举类型

使用 `enum` 关键字定义一个枚举类型：

```dart
enum Color { red, green, blue }
```

枚举中的每个值都有一个 `index` getter 方法， 该方法返回值所在枚举类型定义中的位置（从 0 开始）。 例如，第一个枚举值的索引是 0 ， 第二个枚举值的索引是 1。

```dart
assert(Color.red.index == 0);
assert(Color.green.index == 1);
assert(Color.blue.index == 2);
```

使用枚举的 `values` 常量， 获取所有枚举值列表（ list ）。

```dart
List<Color> colors = Color.values;
assert(colors[2] == Color.blue);
```

可以在 switch 语句中使用枚举， 如果不处理所有枚举值，会收到警告：

```dart
var aColor = Color.blue;

switch (aColor) {
  case Color.red:
    print('Red as roses!');
    break;
  case Color.green:
    print('Green as grass!');
    break;
  default: // 没有这个，会看到一个警告。
    print(aColor); // 'Color.blue'
}
```

枚举类型具有以下限制：

- 枚举不能被子类化，混合或实现。
- 枚举不能被显式实例化。

### 6.7、为类添加功能： Mixin

`Mixin`是复用代码的一种途径，复用的类可以在不同层级，可以不存在继承关系。通过`with`后面跟一个或多个混入名称使用

```dart
class Musician extends Performer with Musical {
  // ···
}

class Maestro extends Person with Musical, Aggressive, Demented {
  Maestro(String maestroName) {
    name = maestroName;
    canConduct = true;
  }
}
```

通过创建一个继承自 Object 且没有构造函数的类，来实现一个Mixin。 如果Mixin不希望作为常规类被使用，使用关键字`mixin`替换 `class`

```dart
mixin Musical {}
```

使用`on`来指定可以使用Mixin的父类类型：

```dart
mixin MusicalPerformer on Musician {
  // ···
}
```

### 6.8、初始化列表

除了使用父类的构造函数，还可以在构造函数体执行前初始化实例变量，使用逗号分隔

```Dart
class Point{
  num x, y;

  Point.fromJson(Map<String, num> json)
    : x = json['x'],
  		y = json['y'] {
        print('In Point.fromJson():($x, $y)');
      }
  // 使用assert验证输入
  Point.withAssert(this.x, this.y): assert(false) {
    print('Point.x > 0');
  }
}
```

> 初始化程序不能使用this

初始化列表可以设置final字段（final修饰的变量值可以赋值一次）

```dart
import 'dart:math';

class Point{
  final num x, y;
  final num distance;
  
  Point(x, y)
    : x = x,
      y = y,
      distance = sqrt(x*x + y*y);
}
```

### 6.9、获取对象类型

对象的runtimeType属性可以获取对象类型，此属性返回`Type`对象

```Dart
var s = '123334';
// String
print('${s.runtimeType}');
```

## 7、泛型

泛型具有形式化参数，`<...>`标记泛型，通常以大写字母E、T、S等代表泛型参数

- 减少代码重复
- 提高代码质量

### 7.1、使用字面量集合

List、Set、Map字面量可以参数化，对于List、Set在声明语句前加`<type>`，Map在申明语句前加`<keyType, valueType>`

```dart
var names = <String>['Kai', 'Lucy'];
var uniqueNames = <String>{'Kai', 'Lucy'};
var pages = <String, String>{'name': 'Kai', 'age': '12'}
```

### 7.2、使用泛型构造函数

在调用给构造函数时，在类名后面使用`<...>`来指定泛型类型
```dart
var nameSet = Set<String>.from(names);
// 创建key为int，value为map的字典
var views = Map<int, View>();
```

### 7.3、限制泛型类型

使用`extends`限制参数类型

```dart
class Foo<T extends SomeBaseClass> {
  // 打印方法
  String toString() => "Instance of 'Foo<$T>'";
}

class Extender extends SomeBaseClass {}

void main() {
  var someBaseClassFoo = Foo<SomeBaseClass>();
  var extenderFoo = Foo<Extender>()

  // 不指定泛型参数
  var foo = Foo()

  // 报错，因为Object不是SomeBaseClass类型
  var foo = Foo<Object>
}
```

### 7.4、使用泛型函数

方法和函数可以使用泛型

```dart
T first<T>(List<T> ts) {
  T tm = ts[0];
  return tm;
}
```
如下地方可以使用参数`T`
- 函数返回值类型
- 参数类型
- 局部变量类型

## 8、库和可见性

`import`和`library`指令可以重建一个模块化的、可共享的代码库，库提供了API，对代码起封装作用给：_开头的标识符仅在库内可见。

>每个dart程序都是一个库

### 8.1、使用库

使用`import`指定一个库命名空间中的内容如何在另一个库中使用

```dart
import 'dart:html';
```
import参数只需要一个指向库的URI，对于内置库，使用`dart:`方案，对于其他库，使用系统文件路径或者`package:`方案
> URI代表统一资源标识符，URL（统一资源定位符）是一种常见的URI
```dart
import 'package:test/test.dart';
```
>`package:`方案指定由包管理工具（如pub）提供的库

### 8.2、指定库前缀

如果导入两个存在冲突标识符的库，可以为其中一个指定前缀

```dart
import 'package:lib1/lib1.dart';
import 'package:lib2/lib2.dart' as lib2;

// 使用lib1中的Element
Element ele1 = Element();
// 使用lib2中的Element
lib2.Element ele2 = lib2.Element;
```

### 8.3、导入库的一部分

只是用库的一部分功能，可以部分导入

````dart
// 只导入lib1的foo
import 'package:lib1/lib1.dart' show foo;
// 导入lib2除foo外的库
import 'package:lib2/lib2.dart' hide foo;
````

### 8.4、延迟加载库

库可以延迟加载（`Deferred Loading`），使用`deferred as`导入

- 减少App启动时间
- 执行A/B测试，比如尝试各种算法的不同实现
- 加载很少使用的功能

```dart
// 延时导入库
import 'package:greeting/hello.dart' deferred as hello;
// 当使用的时候，使用loadLibrary（）函数加载
Future greet() async {
    await hello.loadLibrary();
    hello.printGreeting();
}
```

> `await`关键字暂停代码一直等到库加载完成

