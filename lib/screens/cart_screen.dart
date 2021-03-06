import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart';
import '../widgets/cart_item.dart';
import '../providers/cart_provider.dart' show Cart;

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

static const routeName ='/cart';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
      title:Text('Your cart'),
      ),
       body: Column(
         children: <Widget>[
           Card(
             margin: EdgeInsets.all(15),
             child:Padding(
                padding: EdgeInsets.all(10),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: <Widget>[
                   Text('Total', style: TextStyle(fontSize: 20),),
                   Spacer(),
                   Chip(
                     label: Text('\$${cart.totalAmount.toStringAsFixed(2)}',
                     style: TextStyle(
                       color: Colors.white
                     ),),
                     backgroundColor: Theme.of(context).primaryColor,
                   ),
                   FlatButton(onPressed: (){
                     Provider.of<Orders>(context,listen: false).addOrder(
                         cart.items.values.toList(), cart.totalAmount);
                     cart.clear();
                   },
                       child: Text("ORDER NOW",),
                   textColor: Theme.of(context).primaryColor,)
                 ],
               ),
             ) ,
           ),
           SizedBox(height: 10,),
           Expanded(child: ListView.builder(
               itemCount: cart.items.length,
               itemBuilder: (ctx,i)=>CartItem(
                 cart.items.values.toList()[i].id,
                 cart.items.keys.toList()[i],
                 cart.items.values.toList()[i].price,
                 cart.items.values.toList()[i].quantity,
                 cart.items.values.toList()[i].title,

               ),
           ),
           ),
           
         ],
       ),
    );
  }
}
