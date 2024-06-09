import 'package:flutter/material.dart';
import 'package:flutter_application_projeto_cm/ghost/ghost.dart';
import 'package:flutter_application_projeto_cm/shop_page/shop_app_bar.dart';
import 'package:provider/provider.dart';

class ShopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ShopAppBar(),
      body: ShopHomePage(),
    );
  }
}

class ShopHomePage extends StatelessWidget {
  final List<Product> products = [
    Product(name: 'Hat 1', price: 150, imageUrl: 'assets/hats/hat1.png', type: 'hat'),
    Product(name: 'Hat 2', price: 100, imageUrl: 'assets/hats/hat2.png', type: 'hat'),
    Product(name: 'Hat 3', price: 250, imageUrl: 'assets/hats/hat3.png', type: 'hat'),
    Product(name: 'Hat 4', price: 300, imageUrl: 'assets/hats/hat4.png', type: 'hat'),
    Product(name: 'Hat 5', price: 250, imageUrl: 'assets/hats/hat5.png', type: 'hat'),
    Product(name: 'Hat 6', price: 50, imageUrl: 'assets/hats/hat6.png', type: 'hat'),
    Product(name: 'Color 1', price: 500, imageUrl: 'assets/colors/color_green.png', type: 'color'),
    Product(name: 'Color 2', price: 500, imageUrl: 'assets/colors/color_pink.png', type: 'color'),
    Product(name: 'Color 3', price: 500, imageUrl: 'assets/colors/color_blue.png', type: 'color'),
    Product(name: 'Color 4', price: 500, imageUrl: 'assets/colors/color_yellow.png', type: 'color'),
    Product(name: 'Color 5', price: 500, imageUrl: 'assets/colors/color_light_pink.png', type: 'color'),
  ];

    @override
    Widget build(BuildContext context) {
      final ghostSettings = Provider.of<GhostSettings>(context);


  final availableProducts = products.where((product) =>
      !ghostSettings
          .getPurchasedProducts()
          .any((purchasedProduct) => purchasedProduct.name == product.name)
  ).toList();



    return Scaffold(
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          crossAxisSpacing: 30,
          mainAxisSpacing: 30,
        ),
        itemCount: availableProducts.length,
        itemBuilder: (context, index) {
          final product = availableProducts[index];
          return SectionButton(
            product: product,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailPage(
                    product: product,
                    onBuy: () {
                      ghostSettings.addPurchasedProduct(product);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class SectionButton extends StatelessWidget {
  final Product product;
  final Function onTap;

  SectionButton({required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Image.asset(product.imageUrl, fit: BoxFit.contain),
              ),
              SizedBox(height: 20),
              Text(product.name, textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}



class ProductDetailPage extends StatelessWidget {
  final Product product;
  final Function onBuy;

  ProductDetailPage({required this.product, required this.onBuy});

  @override
  Widget build(BuildContext context) {
    final ghostSettings = Provider.of<GhostSettings>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(product.imageUrl, height: 300, fit: BoxFit.contain),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/coin.png', width: 24, height: 24),
                SizedBox(width: 10),
                Text('${product.price}', style: TextStyle(fontSize: 24)),
              ],
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                if(ghostSettings.money - product.price >= 0){
                  onBuy();
                }
                Navigator.pop(context);
                ghostSettings.debitMoney(product.price, context);
              },
              child: Text('Buy'),
            ),
          ],
        ),
      ),
    );
  }
}
