// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FeedLimitAnimation extends StatefulWidget {
  final String phrase;

  const FeedLimitAnimation({super.key, required this.phrase});

  @override
  _FeedLimitAnimationState createState() => _FeedLimitAnimationState();
}

class _FeedLimitAnimationState extends State<FeedLimitAnimation> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<Offset>? _offsetAnimation;
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _initializePrefs();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(0.0, -2.0),
    ).animate(CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeOut,
    ));
  }

  Future<void> _initializePrefs() async {
    _prefs = await SharedPreferences.getInstance();
    _prefs.getInt('lastFedTime');
  }    

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation!,
      child: Opacity(
        opacity: 1.0 - _controller!.value,
        child: InkWell(
          child: Row(
            children: [
              Text(
                widget.phrase,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 206, 35, 35),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
