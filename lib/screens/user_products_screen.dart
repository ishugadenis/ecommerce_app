import '../screens/edit_product_screen.dart';
import 'package:flutter/material.dart';
import '../providers/products_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';
import '../widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  //const UserProductsScreen({Key? key}) : super(key: key);
static const routeName ='/user-products';
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: <Widget>[
          IconButton(
            icon:const Icon(
              Icons.add
            ),
            onPressed: (){
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          )
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
            itemCount:productData.items.length ,
            itemBuilder: (_, i)=>
               Column(
                 children: [
                   UserProductItem(
                     productData.items[i].id,
                     productData.items[i].title,
                     productData.items[i].imageUrl
                   ),
                   Divider(),
                 ],
               ),

        ),
      ),
    );
  }
}
