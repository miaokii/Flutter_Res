import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

// 商品
class _Product {
  const _Product({ this.name });
  final String name;
}

// 定义选中商品的回调
typedef void _CartChangedCallBack(_Product produce, bool inCart);

class _ShoppingItem extends StatelessWidget {
  // 构造函数
  _ShoppingItem({ this.produce, this.incart, this.callback, this.removeCallBack});
  // 商品
  final _Product produce;
  // 是否在购物车
  final bool incart;
  // 点击回调
  final _CartChangedCallBack callback;
  // 长按
  final VoidCallback removeCallBack;

  // 颜色
  Color _getColor(BuildContext context) {
    return incart ? Colors.black54 : Theme.of(context).primaryColor;
  }

  // 文字属性
  TextStyle _getTextStyle(BuildContext context) {
    if (incart) {
      return TextStyle(
        color: Colors.black54,
        decoration: TextDecoration.lineThrough
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(produce.name[0]),
        backgroundColor: _getColor(context),
      ),
      onTap: (){
        callback(produce, incart);
      },
      onLongPress: (){
        removeCallBack();
      },
      title: Text(produce.name, style: _getTextStyle(context)),
    );
  }
}

class _ShoppingCart extends StatefulWidget {
 
  _ShoppingCart({this.products});
  final List<_Product> products;

  @override
  State<StatefulWidget> createState() {
    return _ShooppingState();
  }
}

class _ShooppingState extends State<_ShoppingCart> {

  Set<_Product> _shoppingCart = Set<_Product>();
  void _handleCartChange(_Product produce, bool inCart) {
    setState(() {
      if (!inCart) {
        _shoppingCart.add(produce);
      } else {
        _shoppingCart.remove(produce);
      }
    });
  }

  void _checkAll() {
    setState(() {
      if (_shoppingCart.isEmpty) {
        widget.products.forEach((element) {_shoppingCart.add(element);});
      } else {
        _shoppingCart.clear();
      }
    });
  }

  void _addNew(){
    setState(() {
      widget.products.add(_Product(name: WordPair.random().asPascalCase));
    });
  }

  void _remove(_Product produce, BuildContext context) {

    showDialog(
      context: context, 
      barrierDismissible: false,
      builder: (context){
        return AlertDialog(
          title: Text('提示'),
          content: Text('确认删除该商品吗?'),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                setState(() {
                  widget.products.remove(produce);
                });
                Navigator.of(context).pop(null);
              }, 
              child: Text('确认')
            ),
            FlatButton(
              onPressed: (){
                Navigator.of(context).pop(null);
              }, 
              textColor: Colors.red,
              child: Text('取消')
            ),
          ],
        );
      });
  }

  @override
  Widget build(BuildContext context) {
    final bool allSelected = _shoppingCart.length == widget.products.length;
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
        actions: <Widget>[
          IconButton(
            icon: Icon(allSelected ? Icons.check_circle : Icons.check_circle_outline), 
            onPressed: (){
              _checkAll();
          }),
          IconButton(icon: Icon(Icons.add), onPressed: (){
            _addNew();
          },)
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 8),
        children: widget.products.map((e) => _ShoppingItem(
            produce: e,
            incart: _shoppingCart.contains(e),
            callback: _handleCartChange,
            removeCallBack: (){
              _remove(e, context);
            },
          )).toList()
      ),
    );
  }
}

class ShoppingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _ShoppingCart(
       products: <_Product>[
        _Product(name: 'Flour'),
        _Product(name: 'Eggs'),
        _Product(name: 'Chocolate chips'),
      ],
    );
  }
}
