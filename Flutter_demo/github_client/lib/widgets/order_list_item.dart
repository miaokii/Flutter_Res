import 'package:flutter/material.dart';
import '../index.dart';

class OrderListItem extends StatelessWidget {
  const OrderListItem({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
      color: listBackGroundColor,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          color: Colors.white,
          child: Container(
            margin:
                const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '单号：QY323456735734588',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '待备菜',
                      style: TextStyle(color: mainColor),
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Divider(
                    height: 1,
                    color: listSplitLineColor,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text.rich(
                      TextSpan(children: [
                        TextSpan(
                            text: '菜品数量：',
                            style:
                                TextStyle(fontSize: 13, color: keyTextColor)),
                        TextSpan(
                            text: '12',
                            style:
                                TextStyle(fontSize: 13, color: valueTextColor)),
                      ]),
                      textAlign: TextAlign.start,
                    )),
                Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text.rich(
                      TextSpan(children: [
                        TextSpan(
                            text: '自提点：',
                            style:
                                TextStyle(fontSize: 13, color: keyTextColor)),
                        TextSpan(
                            text: '西城国际',
                            style:
                                TextStyle(fontSize: 13, color: valueTextColor)),
                      ]),
                      textAlign: TextAlign.start,
                    )),
                Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text.rich(
                      TextSpan(children: [
                        TextSpan(
                            text: '要求到达时间：',
                            style:
                                TextStyle(fontSize: 13, color: keyTextColor)),
                        TextSpan(
                            text: '2020-01-02 23:23',
                            style:
                                TextStyle(fontSize: 13, color: valueTextColor)),
                      ]),
                      textAlign: TextAlign.start,
                    )),
                Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text.rich(
                      TextSpan(children: [
                        TextSpan(
                            text: '创建时间：',
                            style:
                                TextStyle(fontSize: 13, color: keyTextColor)),
                        TextSpan(
                            text: '2020-04-12 12:23:00',
                            style:
                                TextStyle(fontSize: 13, color: valueTextColor)),
                      ]),
                      textAlign: TextAlign.start,
                    )),
                Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text.rich(
                      TextSpan(children: [
                        TextSpan(
                            text: '共计：',
                            style:
                                TextStyle(fontSize: 13, color: keyTextColor)),
                        TextSpan(
                            text: '12.00',
                            style: TextStyle(fontSize: 13, color: Colors.red)),
                      ]),
                      textAlign: TextAlign.start,
                    )),
                Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Divider(
                      height: 1,
                      color: listSplitLineColor,
                    )),
                Padding(
                    padding: const EdgeInsets.only(top: 5, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith(
                                        (states) => mainColor)),
                            child: Text(
                              '去备菜',
                              style:
                                  TextStyle(fontSize: 13, color: Colors.white),
                            )),
                        SizedBox(width: 10),
                        OutlinedButton(
                            onPressed: () {},
                            child: Text('查看详情',
                                style: TextStyle(
                                    fontSize: 13, color: keyTextColor))),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
