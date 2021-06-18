import 'package:flutter/material.dart';
import 'package:items_store_app/items_store_app/model/pokemon_item.dart';
import 'package:items_store_app/items_store_app/pages/item_shopping_cart.dart';
import 'package:items_store_app/shake_transition/main_shake_transition.dart';

class PokemonDetails extends StatelessWidget {
  final Pokemon pokemon;
  final ValueNotifier<bool> notifierBottomBarVisible = ValueNotifier(false);

  PokemonDetails({Key? key, required this.pokemon}) : super(key: key);

  void _openCart(BuildContext context) async {
    notifierBottomBarVisible.value = false;
    await Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (_, animation1, animation2) {
        return FadeTransition(
          opacity: animation1,
          child: ItemShoppingCart(pokemon: pokemon,),
        );
      }),
    );
    notifierBottomBarVisible.value = true;
  }

  Widget _buildCarousel(context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.5,
      child: Stack(
        children: [
          Positioned.fill(
            child: Hero(
              tag: 'background_${pokemon.pokedexNumber}',
              child: Container(
                color: Color(pokemon.color).withOpacity(0.25),
              ),
            ),
          ),
          Positioned(
            left: 70,
            right: 70,
            top: 10,
            child: ShakeTransition(
              axis: Axis.vertical,
              duration: const Duration(milliseconds: 1400),
              child: Hero(
                tag: 'number_${pokemon.pokedexNumber}',
                child: Material(
                  color: Colors.transparent,
                  child: FittedBox(
                    child: Text(
                      pokemon.pokedexNumber.toString(),
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.05),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ),
          PageView.builder(
              itemCount: pokemon.images.length,
              itemBuilder: (context, index) {
                final tag = index == 0
                    ? 'image_${pokemon.pokedexNumber}'
                    : 'image_${pokemon.pokedexNumber}_$index';
                return Container(
                  alignment: Alignment.center,
                  child: ShakeTransition(
                    axis: Axis.vertical,
                    duration: index == 0
                        ? const Duration(milliseconds: 1400)
                        : Duration.zero,
                    child: Hero(
                      tag: tag,
                      child: Image.asset(
                        pokemon.images[index],
                        height: 200,
                        width: 200,
                      ),
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      notifierBottomBarVisible.value = true;
    });
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Image.asset(
          'assets/pokemons/pokemon_logo.png',
          height: 60,
        ),
        leading: BackButton(
          color: Colors.black,
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildCarousel(context),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ShakeTransition(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              pokemon.name,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22),
                            ),
                            const Spacer(),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '\$${pokemon.oldPrice.toInt().toString()}',
                                    style: TextStyle(
                                        color: Colors.red,
                                        decoration: TextDecoration.lineThrough,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    '\$${pokemon.currentPirce.toInt().toString()}',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      ShakeTransition(
                        duration: const Duration(milliseconds: 1100),
                        child: Text(
                          'EVOLUTIONS',
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ShakeTransition(
                        duration: const Duration(milliseconds: 1100),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _PokemonEvolutions(name: 'Bulbasaur'),
                            _PokemonEvolutions(name: 'Ivysaur'),
                            _PokemonEvolutions(name: 'Venusaur '),
                          ],
                        ),
                      ),
                      const SizedBox(height: 35),
                      ShakeTransition(
                        duration: const Duration(milliseconds: 1200),
                        child: Text(
                          'DESCRIPTION',
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ),
                      // const SizedBox(height: 20),
                      // Text(
                      //   'There is a plant seed on its back right from the day this Pokémon is born. The seed slowly grows larger.',
                      //   style: TextStyle(
                      //     fontSize: 17,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ValueListenableBuilder<bool>(
              valueListenable: notifierBottomBarVisible,
              builder: (context, value, child) {
                return AnimatedPositioned(
                  duration: const Duration(milliseconds: 250),
                  left: 0,
                  right: 0,
                  bottom: value ? 0 : -kToolbarHeight*1.5,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        FloatingActionButton(
                          heroTag: 'fav_1',
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.favorite,
                            color: Colors.black,
                          ),
                          onPressed: () {},
                        ),
                        Spacer(),
                        FloatingActionButton(
                          heroTag: 'fav_2',
                          backgroundColor: Colors.black,
                          child: Icon(Icons.shopping_cart_outlined),
                          onPressed: () {
                            _openCart(context);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              })
        ],
      ),
    );
  }
}

class _PokemonEvolutions extends StatelessWidget {
  final String name;

  const _PokemonEvolutions({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Text(
        name,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 17,
        ),
      ),
    );
  }
}
