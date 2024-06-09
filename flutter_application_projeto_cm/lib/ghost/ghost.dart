import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GhostSettings extends ChangeNotifier {
  String _ghostImage = '/colors/color_white.png';
  String _hatImage = '';
  List<Product> _purchasedProducts = [];
  double money = 1000;

  String get ghostImage => _ghostImage;
  String get hatImage => _hatImage;

  GhostSettings() {
    _loadSettings();
  }

  void setGhostImage(String imagePath) {
    _ghostImage = imagePath;
    notifyListeners();
    saveSettings();
  }

  void setHatImage(String imagePath) {
    _hatImage = imagePath;
    notifyListeners();
    saveSettings();
  }

  Future<void> saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('ghostImage', _ghostImage);
    prefs.setString('hatImage', _hatImage);
    prefs.setStringList('purchasedProducts', _purchasedProducts.map((p) => p.name).toList());
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _ghostImage = prefs.getString('ghostImage') ?? '/colors/color_white.png';
    _hatImage = prefs.getString('hatImage') ?? '';
    List<String> purchasedProductNames = prefs.getStringList('purchasedProducts') ?? [];
    _purchasedProducts = purchasedProductNames.map((name) => allProducts.firstWhere((product) => product.name == name)).toList();
    notifyListeners();
  }

  List<Product> getPurchasedProducts() {
    return List.from(_purchasedProducts);
  }

  void addPurchasedProduct(Product product) {
    _purchasedProducts.add(product);
    saveSettings();
    notifyListeners();
  }

  bool isPurchased(Product product) {
    return _purchasedProducts.contains(product);
  }

  void debitMoney(double price, BuildContext context) {
    if (money - price >= 0) {
      money -= price;
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Saldo Insuficiente"),
            content: Text("Seu saldo é insuficiente para realizar esta compra."),
            actions: <Widget>[
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}

class Product {
  final String name;
  final double price;
  final String imageUrl;
  final String type;

  Product({required this.name, required this.price, required this.imageUrl, required this.type});
}

final List<Product> allProducts = [
  Product(name: 'Hat 1', price: 350, imageUrl: 'assets/hats/hat1.png', type: 'hat'),
  Product(name: 'Hat 2', price: 500, imageUrl: 'assets/hats/hat2.png', type: 'hat'),
  Product(name: 'Color 1', price: 1500, imageUrl: 'assets/colors/color_white.png', type: 'color'),
  Product(name: 'Color 2', price: 1500, imageUrl: 'assets/colors/color_pink.png', type: 'color'),
  // Adicione todos os outros produtos aqui
];