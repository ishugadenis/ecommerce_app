import '../screens/edit_product_screen.dart';
import '../screens/user_products_screen.dart';
import '../screens/orders_screen.dart';
import '../providers/orders.dart';
import 'package:ecommerce_app/screens/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/cart_provider.dart';
import 'screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './providers/products_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
 const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers:
    [
        ChangeNotifierProvider(
        create: (ctx) => Products(),
        ),
      ChangeNotifierProvider(
        create: (ctx) =>Cart(),
      ),
      ChangeNotifierProvider(
          create: (ctx)=>Orders(),
      )
    ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          accentColor: Colors.purple,
          fontFamily: 'Lato',
        ),
        home:  ProductsOverviewScreen(),
        routes: {
              ProductDetailScreen.routeName :(_) => ProductDetailScreen(),
              CartScreen.routeName:(_)=>CartScreen(),
              OrdersScreen.routeName:(_)=>OrdersScreen(),
             UserProductsScreen.routeName:(_)=>UserProductsScreen(),
             EditProductScreen.routeName: (_)=> EditProductScreen(),
        },
      ),
    );
  }
}

