import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shops_app/providers/products.dart';
import 'package:shops_app/screens/edit_product_scree.dart';
import 'package:shops_app/widgets/app_drawer.dart';
import 'package:shops_app/widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  const UserProductsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text("User Prodict"),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.routeName);
              })
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: productsData.items.length,
          itemBuilder: (context, index) {
            var item = productsData.items[index];
            return Column(
              children: [
                UserProductItem(
                  item.id,
                  item.title,
                  item.imageUrl,
                ),
                Divider(),
              ],
            );
          },
        ),
      ),
    );
  }
}
