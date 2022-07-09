import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    return ChangeNotifierProvider(
      create: (ctx) => Products(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          accentColor: Colors.purple,
          fontFamily: 'Lato',
        ),
        home:  ProductsOverviewScreen(),
        routes: {
              ProductDetailScreen.routeName :(_) => ProductDetailScreen(),
        },
      ),
    );
  }
}

