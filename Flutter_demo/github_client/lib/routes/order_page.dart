import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OrderPageState();
  }
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('订单列表', style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        textTheme: TextTheme(

        ),
      ),
      body: Center(
        child: Text('OrderList'),
      ),
    );
  }
}