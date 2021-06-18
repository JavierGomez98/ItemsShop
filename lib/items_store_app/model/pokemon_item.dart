class Pokemon {
  final String name;
  final double oldPrice;
  final double currentPirce;
  final List<String> images;
  final String pokedexNumber;
  final String type;
  final int color;

  Pokemon({
    required this.name, 
    required this.oldPrice, 
    required this.currentPirce, 
    required this.images, 
    required this.pokedexNumber,
    required this.type,
    required this.color
  });
}

final pokemons = <Pokemon>[
  Pokemon(
    name: 'Bulbasaur',
    currentPirce: 149,
    oldPrice: 299,
    images: ['assets/pokemons/pokemon1_1.png','assets/pokemons/pokemon1_2.png'],
    pokedexNumber: '001',
    type: 'Grass',
    color: 0xFF9bcc50
  ),
  Pokemon(
    name: 'Charmander',
    currentPirce: 249,
    oldPrice: 399,
    images: ['assets/pokemons/pokemon2_1.png','assets/pokemons/pokemon2_2.png'],
    pokedexNumber: '004',
    type: 'Fire',
    color: 0xFFfd7d24
  ),
  Pokemon(
    name: 'Squirtle',
    currentPirce: 349,
    oldPrice: 499,
    images: ['assets/pokemons/pokemon3_1.png','assets/pokemons/pokemon3_2.png'],
    pokedexNumber: '007',
    type: 'Water',
    color: 0xFF30a7d7
  ),
  Pokemon(
    name: 'Zorua',
    currentPirce: 449,
    oldPrice: 599,
    images: ['assets/pokemons/pokemon4_1.png','assets/pokemons/pokemon4_2.png'],
    pokedexNumber: '570',
    type: 'Dark',
    color: 0xFF707070
  ),
];