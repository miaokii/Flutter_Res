import 'package:flutter/material.dart';
import 'package:github_client/index.dart';

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
          title: Text(
            '订单列表',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          bottom: PreferredSize(
              child: Text('dhhs'), preferredSize: Size(double.infinity, 40)),
        ),
        body: ListView(
          children: [
            
            OrderListItem(),
            OrderListItem(),
            OrderListItem(),
            OrderListItem(),
            OrderListItem(),
            OrderListItem(),
            OrderListItem(),
            OrderListItem(),
            SizedBox(height: 10)
          ],
        ));
  }
}
