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
var x = 1
var hex = 0x124fdf

var y = 1.1
var y = 1.43e5

// dart2.1后，必要时int字面量会自动转换double类型
double z = 1

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
assert((3>>1) == 1)
// 0011 << 1 = 0110
assert((3<<1) == 6)
// 0011 | 0100 = 0111
assert((3|4) == 7)
// 0011 & 0100 = 0000
assert((3&4) == 0)
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

## 2.3、Boolean

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

捕获语句中可以同时使用 `on` 和 `catch` ，也可以单独分开使用。 使用 `on` 来指定异常类型， 使用 `catch` 来 捕获异常对象

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

