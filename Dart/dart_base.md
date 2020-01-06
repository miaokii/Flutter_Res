## 1、变量
1. 一切皆对象，未初始化对象的默认值是null
2.  强类型语言
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

const validConstString = '$aConstNum $aConstBool $aConstString'; //const 类型数据
const invalidConstString = '$aNum $aBool $aString $aConstList'; //非 const 类型数据
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