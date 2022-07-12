import 'package:flutter/material.dart';
import '../providers/orders.dart' as ord;
import 'dart:math';

class OrderItem extends StatefulWidget {
 // const OrderItem({Key? key}) : super(key: key);
  final ord.OrderItem order;
  OrderItem(this.order);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('\$${widget.order.amount}'),
            subtitle: Text('${widget.order.dateTime}' ),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less :
                Icons.expand_more,
              ),
              onPressed: (){
                setState(() {
               _expanded =!_expanded;
                });
              },
            ),
          ),
          if(_expanded)
            Container(
              height: min(widget.order.products.length *20.0 + 100,
              180),
              child: ListView(children:
                 widget.order.products.map((prod) =>
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: <Widget>[
                     Text(
                       prod.title,
                       style: TextStyle(
                         fontSize: 18,
                         color: Colors.black,
                       ),
                     ),
                     Text(
                       '${prod.quantity}x \$${prod.price}',
                       style: TextStyle(
                           fontSize: 18,
                           color: Colors.grey
                       ),
                     )
                   ],
                 )
                 ).toList(),
              ),
            )
        ],
      ),

    );
  }
}