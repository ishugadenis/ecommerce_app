import '../screens/cart_screen.dart';
import '../widgets/app_drawer.dart';
import 'package:ecommerce_app/widgets/badge.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../providers/products_provider.dart';
import '../widgets/product_grid.dart';
import '../widgets/badge.dart';
import '../screens/cart_screen.dart';

enum FilterOptions{
 Favorites,
 All,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
 var _showOnlyFavorites =false;
  // const ProductsOverviewScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue){
              setState(() {
                if(selectedValue == FilterOptions.Favorites ){
                  _showOnlyFavorites = true;
                }else{
                  _showOnlyFavorites =false;
                }
              });

            },
            icon: Icon(
              Icons.more_vert,
            ),
            itemBuilder: (_)=>[
              PopupMenuItem(child: Text('Onlt Favrites'), value: FilterOptions.Favorites,),
              PopupMenuItem(child: Text('Show All'), value: FilterOptions.All,)
            ],
          ),
          Consumer<Cart>(builder: ( _, cart,ch) =>Badge(
            value: cart.itemCount.toString(), color: Colors.purple,
            child: ch!,
         ),
            child:IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed:() {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              }

            ) ,
    ),

        ],
      ),
      drawer: AppDrawer(),
      body: ProductsGrid(_showOnlyFavorites),
    );
  }
}


