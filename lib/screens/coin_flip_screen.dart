import 'package:flutter/material.dart';
import 'dart:math';

// ChatGPT helped a bit too much with this one. :')

class CoinFlipView extends StatefulWidget {
  const CoinFlipView({super.key});

  @override
  State<CoinFlipView> createState() => _CoinFlipViewState();
}

class _CoinFlipViewState extends State<CoinFlipView> with SingleTickerProviderStateMixin {
  String _result = '';
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _flipping = false;

  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: pi * 2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _flipping = false;
          _result = _random.nextBool() ? 'Heads' : 'Tails';
        });
      }
    });
  }

  void _flipCoin() {
    if (_flipping) return;

    setState(() {
      _flipping = true;
      _result = '';
    });

    _controller.reset();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildCoin() {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final isHeads = _animation.value % (2 * pi) < pi;
        final face = isHeads ? '🪙' : '🔄';

        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(_animation.value),
          child: Text(
            face,
            style: const TextStyle(fontSize: 100),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Coin Flip')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: _buildCoin()),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _flipCoin,
            child: const Text('Flip Coin'),
          ),
          const SizedBox(height: 20),
          Text(
            _result.isNotEmpty ? 'Result: $_result' : '',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
