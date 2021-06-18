import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:items_store_app/items_store_app/model/pokemon_item.dart';

const _buttonSizeWidth = 160.0;
const _buttonSizeHeight = 60.0;
const _buttonCircleSize = 60.0;
const _finalImageSize = 30.0;
const _imageSize = 150.0;

class ItemShoppingCart extends StatefulWidget {
  final Pokemon pokemon;

  const ItemShoppingCart({Key? key, required this.pokemon}) : super(key: key);

  @override
  _ItemShoppingCartState createState() => _ItemShoppingCartState();
}

class _ItemShoppingCartState extends State<ItemShoppingCart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animationResize;
  late Animation _animationMovement1;
  late Animation _animationMovement2;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1750));
    _animationResize = Tween(
      begin: 1.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.0,
          0.35,
          curve: Curves.bounceOut
        ),
      ),
    );
    _animationMovement1 = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.35,
          0.45,
        ),
      ),
    );
    _animationMovement2 = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.3,
          0.9,
          curve: Curves.elasticIn,
        ),
      ),
    );

    _controller.addStatusListener((status) {
      if(status == AnimationStatus.completed) {
        Navigator.of(context).pop(true);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildPanel() {
    final size = MediaQuery.of(context).size;
    final currentImageSize = (_imageSize*_animationResize.value).clamp(_finalImageSize, _imageSize);
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
      tween: Tween(
        begin: 1.0,
        end: 0.0,
      ),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(
            0.0,
            value * size.height * 0.6,
          ),
          child: child,
        );
      },
      child: Container(
        width: (size.width * _animationResize.value).clamp(_buttonCircleSize, size.width),
        height: (size.height * 0.6 * _animationResize.value).clamp(_buttonCircleSize, size.height * 0.6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomLeft: _animationResize.value == 1 ? Radius.zero : Radius.circular(30),
            bottomRight: _animationResize.value == 1 ? Radius.zero : Radius.circular(30),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: _animationResize.value == 1 ? MainAxisAlignment.start : MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: _animationResize.value == 1 ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
                children: [
                  Image.asset(
                    widget.pokemon.images.first,
                    height: currentImageSize,
                  ),
                  if(_animationResize.value == 1) ...[
                    Column(
                      children: [
                        Text(
                          widget.pokemon.name,
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          '\$${widget.pokemon.currentPirce.toInt().toString()}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ],
                    ),
                  ]
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      color: Colors.transparent,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final buttonSizeWidth = (_buttonSizeWidth * _animationResize.value).clamp(_buttonCircleSize, _buttonSizeWidth);
          final panelSizeWidth = (size.width * _animationResize.value).clamp(_buttonCircleSize, size.width);
          return Stack(
            fit: StackFit.expand,
            children: [
              Positioned.fill(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    color: Colors.black87,
                  ),
                ),
              ),
              Positioned.fill(
                child: Stack(
                  children: [
                    if(_animationMovement1.value != 1) ...[
                      Positioned(
                        top: size.height * 0.4 + (_animationMovement1.value * size.height * 0.45),
                        left: size.width/2 - panelSizeWidth/2,
                        width: panelSizeWidth,
                        child: _buildPanel(),
                      ),
                    ],
                    Positioned(
                      bottom: 40.0 - (_animationMovement2.value * 100),
                      left: size.width / 2 - buttonSizeWidth / 2,
                      child: TweenAnimationBuilder<double>(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                        tween: Tween(
                          begin: 1.0,
                          end: 0.0,
                        ),
                        builder: (context, value, child) {
                          return Transform.translate(
                            offset: Offset(
                              0.0,
                              value * size.height * 0.6,
                            ),
                            child: child,
                          );
                        },
                        child: InkWell(
                          onTap: () {
                            _controller.forward();
                          },
                          child: Container(
                            width: buttonSizeWidth,
                            height: (_buttonSizeHeight * _animationResize.value).clamp(_buttonCircleSize, _buttonSizeHeight),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.shopping_cart_outlined,
                                    color: Colors.white,
                                  ),
                                  if(_animationResize.value == 1) ...[
                                    const SizedBox(width: 10),
                                    Text(
                                      'ADD TO CART',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ]
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}
