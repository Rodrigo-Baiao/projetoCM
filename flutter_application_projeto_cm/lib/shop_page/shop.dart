import 'package:flutter/material.dart';
import 'package:flutter_application_projeto_cm/shop_page/shop_app_bar.dart';



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
  final Map<String, Section> sections = {
    'Hats': Section(
      name: 'Hats',
      imageUrl: 'assets/hats/hat_section.png',
      products: [
        Product(name: 'Hat 1', price: 350, imageUrl: 'assets/hats/hat1.png'),
        Product(name: 'Hat 2', price: 500, imageUrl: 'assets/hats/hat2.png'),
        Product(name: 'Hat 3', price: 600, imageUrl: 'assets/hats/hat3.png'),
        Product(name: 'Hat 4', price: 650, imageUrl: 'assets/hats/hat4.png'),
        Product(name: 'Hat 5', price: 800, imageUrl: 'assets/hats/hat5.png'),
        Product(name: 'Hat 6', price: 1000, imageUrl: 'assets/hats/hat6.png'),
      ],
    ),
    'Spook´s Colors': Section(
      name: 'Colors',
      imageUrl: 'assets/colors/color_section.png',
      products: [
        Product(name: 'Color 1', price: 1500, imageUrl: 'assets/colors/color1.png'),
        Product(name: 'Color 2', price: 1500, imageUrl: 'assets/colors/color2.png'),
        Product(name: 'Color 3', price: 1500, imageUrl: 'assets/colors/color3.png'),
        Product(name: 'Color 4', price: 1500, imageUrl: 'assets/colors/color4.png'),
        Product(name: 'Color 5', price: 1500, imageUrl: 'assets/colors/color5.png'),
        Product(name: 'Color 6', price: 1500, imageUrl: 'assets/colors/color6.png'),
      ],
    ),
    'Backgrounds Color': Section(
      name: 'Backgrounds',
      imageUrl: 'assets/backgrounds/background_section.png',
      products: [
        Product(name: 'Background 1', price: 250, imageUrl: 'assets/backgrounds/bg1.png'),
        Product(name: 'Background 2', price: 250, imageUrl: 'assets/backgrounds/bg2.png'),
        Product(name: 'Background 3', price: 250, imageUrl: 'assets/backgrounds/bg3.png'),
        Product(name: 'Background 4', price: 250, imageUrl: 'assets/backgrounds/bg4.png'),
        Product(name: 'Background 5', price: 250, imageUrl: 'assets/backgrounds/bg5.png'),
        Product(name: 'Background 6', price: 250, imageUrl: 'assets/backgrounds/bg6.png'),
        Product(name: 'Background 7', price: 250, imageUrl: 'assets/backgrounds/bg7.png'),
        Product(name: 'Background 8', price: 250, imageUrl: 'assets/backgrounds/bg8.png'),
        Product(name: 'Background 9', price: 250, imageUrl: 'assets/backgrounds/bg9.png'),
        Product(name: 'Background 10', price: 250, imageUrl: 'assets/backgrounds/bg10.png'),
        Product(name: 'Background 11', price: 250, imageUrl: 'assets/backgrounds/bg11.png'),
        Product(name: 'Background 12', price: 250, imageUrl: 'assets/backgrounds/bg12.png'),
      ],
    ),
    'Windows': Section(
      name: 'Windows',
      imageUrl: 'assets/windows/window_section.png',
      products: [
        Product(name: 'Window 1', price: 2500, imageUrl: 'assets/windows/window1.png'),
        Product(name: 'Window 2', price: 2500, imageUrl: 'assets/windows/window2.png'),
        Product(name: 'Window 3', price: 2500, imageUrl: 'assets/windows/window3.png'),
      ],
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          crossAxisSpacing: 30,
          mainAxisSpacing: 30,
        ),
        itemCount: sections.length,
        itemBuilder: (context, index) {
          final section = sections.values.elementAt(index);
          return SectionButton(section: section);
        },
      ),
    );
  }
}

class Section {
  final String name;
  final String imageUrl;
  final List<Product> products;

  Section({required this.name, required this.imageUrl, required this.products});
}

class Product {
  final String name;
  final double price;
  final String imageUrl;

  Product({required this.name, required this.price, required this.imageUrl});
}

class SectionButton extends StatelessWidget {
  final Section section;

  SectionButton({required this.section});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductListPage(section: section),
          ),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.grey[200], // Fundo cinza
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Image.asset(section.imageUrl, fit: BoxFit.contain),
              ),
              SizedBox(height: 20),
              Text(section.name, textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductListPage extends StatelessWidget {
  final Section section;

  ProductListPage({required this.section});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(section.name),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: section.products.length,
        itemBuilder: (context, index) {
          final product = section.products[index];
          return ProductCard(product: product);
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.asset(product.imageUrl),
        title: Text(product.name),
        subtitle: Row(
          children: [
            Image.asset('assets/coin.png', width: 16, height: 16), // Exibe a imagem da moeda
            SizedBox(width: 5), // Adiciona espaço entre a imagem e o preço
            Text('${product.price.toStringAsFixed(2)}'), // Exibe o preço do produto
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailPage(product: product),
            ),
          );
        },
      ),
    );
  }
}
class ProductDetailPage extends StatelessWidget {
  final Product product;

  ProductDetailPage({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        centerTitle: true, // Centraliza o título na página de detalhes do produto
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(product.imageUrl, height: 300, fit: BoxFit.contain), // Exibe a imagem do produto em grande
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/coin.png', width: 24, height: 24), // Exibe a imagem da moeda
                SizedBox(width: 10),
                Text('${product.price.toStringAsFixed(2)}', style: TextStyle(fontSize: 24)), // Exibe o preço do produto
              ],
            ),
            SizedBox(height: 50), // Adiciona espaço entre o preço e o botão de comprar
            ElevatedButton(
              onPressed: () {
                // Adicionar lógica para comprar o produto
              },
              child: Text('Buy'),
            ),
          ],
        ),
      ),
    );
  }
}