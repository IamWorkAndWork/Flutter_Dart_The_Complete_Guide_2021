import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shops_app/providers/cart.dart';
import 'package:shops_app/screens/cart_screen.dart';
import 'package:shops_app/widgets/app_drawer.dart';
import 'package:shops_app/widgets/badge.dart';
import 'package:shops_app/widgets/product_grid.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({Key key}) : super(key: key);

  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products Overview"),
        actions: <Widget>[
          _buildPopupMenuButton(),
          _buildCartBadge(context),
        ],
      ),
      drawer: AppDrawer(),
      body: ProductsGrid(_showOnlyFavorites),
    );
  }

  Consumer<Cart> _buildCartBadge(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, cart, ch) {
        return Badge(
          child: ch,
          value: cart.itemCount.toString(),
        );
      },
      child: IconButton(
        icon: Icon(
          Icons.shopping_cart,
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(CartScreen.routeName);
        },
      ),
    );
  }

  PopupMenuButton<FilterOptions> _buildPopupMenuButton() {
    return PopupMenuButton(
      onSelected: (value) {
        setState(() {
          if (value == FilterOptions.Favorites) {
            _showOnlyFavorites = true;
          } else {
            _showOnlyFavorites = false;
          }
        });
      },
      icon: Icon(Icons.more_vert),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            child: Text("Only Favorites"),
            value: FilterOptions.Favorites,
          ),
          PopupMenuItem(
            child: Text("Show All"),
            value: FilterOptions.All,
          ),
        ];
      },
    );
  }
}
