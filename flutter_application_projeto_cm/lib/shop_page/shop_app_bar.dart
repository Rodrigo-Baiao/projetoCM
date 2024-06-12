import 'package:flutter/material.dart';
import 'package:flutter_application_projeto_cm/ghost/ghost.dart';
import 'package:provider/provider.dart';

class ShopAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ShopAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final ghostSetting = Provider.of<GhostSettings>(context);
    double money = ghostSetting.money;

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
                Image.asset('assets/coin.png', width: 24, height: 24), 
                const SizedBox(width: 5),
                Text('$money', style: const TextStyle(fontSize: 18)), 
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
