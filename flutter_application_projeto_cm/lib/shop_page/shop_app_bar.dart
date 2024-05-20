import 'package:flutter/material.dart';

class ShopAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ShopAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const Text(
                'Back',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
          const Text('Shop'),
          Container(
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/coin.png', width: 24, height: 24), // Exibe a imagem da moeda
                const SizedBox(width: 5),
                const Text('999999', style: TextStyle(fontSize: 18)), // Exibe a quantidade de moedas
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
