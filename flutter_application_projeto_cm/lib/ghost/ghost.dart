import 'package:flutter/material.dart';
import 'package:flutter_application_projeto_cm/settings_page/sound.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GhostSettings extends ChangeNotifier {
  String _ghostImage = 'assets/colors/color_white.png';
  String _hatImage = '';

  List<Product> _purchasedProducts = [];
  double money = 1000;
  bool showMoneyAnimation = false;
  int animationAmount = 0;
  int _numFeedings = 0;
  static const int maxFeedings = 3;
  bool _showFeedLimitMessage = false; 
  bool get showFeedLimitMessage => _showFeedLimitMessage; 


  String get ghostImage => _ghostImage;
  String get hatImage => _hatImage;

  GhostSettings() {
    _loadSettings();
  }

  void feed() {
    if (_numFeedings < maxFeedings) {
      Sound.lickSound();
      money += 20;
      animationAmount = 20;
      showMoneyAnimation = true;
      _numFeedings++; 
      notifyListeners();

      Future.delayed(const Duration(seconds: 2), () {
        showMoneyAnimation = false;
        notifyListeners();
      });
    }else{
      _showFeedLimitMessage = true;
      notifyListeners();

      Future.delayed(const Duration(seconds: 2), () {
        _showFeedLimitMessage = false;
        notifyListeners();
      });
    }
  }

  void resetFeedings() {
    _numFeedings = 0;
    notifyListeners();
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
    _ghostImage = prefs.getString('ghostImage') ?? 'assets/colors/color_white.png';
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

   void addMoney(int amount) {
    money += amount;
    animationAmount = amount;
    showMoneyAnimation = true;
    notifyListeners();

    Future.delayed(const Duration(seconds: 2), () {
      showMoneyAnimation = false;
      notifyListeners();
    });
  }

  void debitMoney(double price, BuildContext context) {
    if (money - price >= 0) {
      money -= price;
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Saldo Insuficiente"),
            content: const Text("Seu saldo é insuficiente para realizar esta compra."),
            actions: <Widget>[
              TextButton(
                child: const Text("OK"),
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

  void resetCleanDust() {
    
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
        Product(name: 'Color 5', price: 500, imageUrl: 'assets/colors/color_white.png', type: 'color'),

];