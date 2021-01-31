import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shops_app/providers/auth.dart';
import 'package:shops_app/providers/cart.dart';
import 'package:shops_app/providers/orders.dart';
import 'package:shops_app/providers/products.dart';
import 'package:shops_app/screens/auth_screen.dart';
import 'package:shops_app/screens/cart_screen.dart';
import 'package:shops_app/screens/edit_product_scree.dart';
import 'package:shops_app/screens/orders_screen.dart';
import 'package:shops_app/screens/product_detail_screen.dart';
import 'package:shops_app/screens/products_overview_screen.dart';
import 'package:shops_app/screens/splash_screen.dart';
import 'package:shops_app/screens/user_products_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (context) {
            return Products();
          },
          update: (context, auth, previousProducts) {
            return previousProducts
              ..update(auth.token, auth.userId,
                  previousProducts == null ? [] : previousProducts.items);
          },
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (context) {
            return Orders();
          },
          builder: (context, child) {
            return child;
          },
          update: (context, auth, previousOrders) {
            return previousOrders
              ..update(
                auth.token,
                auth.userId,
                previousOrders == null ? [] : previousOrders.orders,
              );
          },
        ),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, child) {
          return MaterialApp(
            title: 'MyShop',
            debugShowCheckedModeBanner: true,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              accentColor: Colors.deepOrange,
              fontFamily: 'Lato',
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: auth.isAUTH
                ? ProductsOverviewScreen()
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (context, authResultSnapshot) {
                      return authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen();
                    },
                  ),
            routes: {
              ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
              CartScreen.routeName: (ctx) => CartScreen(),
              OrdersScreen.routeName: (ctx) => OrdersScreen(),
              UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
              EditProductScreen.routeName: (ctx) => EditProductScreen(),
            },
          );
        },
      ),
    );
  }
}
