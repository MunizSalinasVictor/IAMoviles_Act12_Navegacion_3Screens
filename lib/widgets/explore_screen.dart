import 'package:flutter/material.dart';
import 'profile_screen.dart';
import 'frieren_detail_screen.dart'; // Importamos la pantalla de detalle

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crunchyroll El Victor'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.person_outline, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView( // Cambiamos Column por SingleChildScrollView
        child: Column(
          children: [
            // Título "Explorar"
            const Padding(
              padding: EdgeInsets.only(top: 16.0, left: 16.0, bottom: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Explorar',
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),

            // Fila con título "Popular" e íconos de filtro
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Popular',
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 8),
                        child: IconButton(
                          icon: const Icon(Icons.filter_list, color: Colors.orange, size: 24),
                          onPressed: () {},
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.filter_alt, color: Colors.orange, size: 24),
                        onPressed: () {},
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Grid 2x2 con tarjetas cliqueables
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.85,
                shrinkWrap: true, // Necesario para que funcione dentro de SingleChildScrollView
                physics: const NeverScrollableScrollPhysics(), // El scroll lo maneja el padre
                children: [
                  _buildAnimeCard(
                    'Gachiakuta', 
                    'https://raw.githubusercontent.com/MunizSalinasVictor/IAMoviles_Act12_Navegacion_3Screens/refs/heads/main/gachiakuta.jpeg',
                    context,
                  ),
                  _buildAnimeCard(
                    'One Piece', 
                    'https://raw.githubusercontent.com/MunizSalinasVictor/IAMoviles_Act12_Navegacion_3Screens/refs/heads/main/one%20piece.jpg',
                    context,
                  ),
                  _buildAnimeCard(
                    'Frieren', 
                    'https://raw.githubusercontent.com/MunizSalinasVictor/IAMoviles_Act12_Navegacion_3Screens/refs/heads/main/frieren.jpg',
                    context,
                  ),
                  _buildAnimeCard(
                    'Fire Force', 
                    'https://raw.githubusercontent.com/MunizSalinasVictor/IAMoviles_Act12_Navegacion_3Screens/refs/heads/main/fire%20force.jpg',
                    context,
                  ),
                ],
              ),
            ),
            
            // Espacio adicional al final para mejor scroll
            const SizedBox(height: 20),
          ],
        ),
      ),

      // Bottom Navigation Bar (sin cambios)
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        currentIndex: 1,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'Categorías'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favoritos'),
          BottomNavigationBarItem(icon: Icon(Icons.emoji_events), label: 'Premium'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Ajustes'),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              break;
            case 1:
              // Ya estamos en ExploreScreen
              break;
            case 2:
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Próximamente: Favoritos'),
                  backgroundColor: Colors.orange,
                  duration: Duration(seconds: 1),
                ),
              );
              break;
            case 3:
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Próximamente: Premium'),
                  backgroundColor: Colors.orange,
                  duration: Duration(seconds: 1),
                ),
              );
              break;
            case 4:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
              break;
          }
        },
      ),
    );
  }

  // Tarjeta cliqueable que navega al detalle con el título correspondiente
  Widget _buildAnimeCard(String title, String imageUrl, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FrierenDetailScreen(animeTitle: title),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.orange.withOpacity(0.2),
              BlendMode.darken,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.orange.withOpacity(0.3),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.8),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 8,
              left: 8,
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 8,
                      color: Colors.black,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}