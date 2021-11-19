import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final bool inStock;
  final int price;

  ProductItem(this.id, this.title, this.imageUrl, this.inStock, this.price);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {},
          child: Hero(
            tag: id,
            child: Stack(
              children: [
                FadeInImage(
                  placeholder:
                      AssetImage('assets/images/product-placeholder.png'),
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(
                      Icons.shopping_cart,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      // cart.addItem(product.id, product.price, product.title);
                      Scaffold.of(context).hideCurrentSnackBar();
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Added item to cart!',
                          ),
                          duration: Duration(seconds: 2),
                          action: SnackBarAction(
                            label: 'UNDO',
                            onPressed: () {
                              // cart.removeSingleItem(product.id);
                            },
                          ),
                        ),
                      );
                    },
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: inStock == true
              ? Column(
                  children: [
                    SizedBox(height: 10),
                    Text(
                      "Rs.$price",
                      style: TextStyle(
                          color: Colors.white, fontStyle: FontStyle.italic),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "In Stock",
                      style: TextStyle(color: Colors.green, fontSize: 8),
                    ),
                  ],
                )
              : Column(
                  children: [
                    SizedBox(height: 10),
                    Text(
                      "Rs.$price",
                      style: TextStyle(
                          color: Colors.white, fontStyle: FontStyle.italic),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "No Stock",
                      style: TextStyle(color: Colors.red, fontSize: 8),
                    ),
                  ],
                ),
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
