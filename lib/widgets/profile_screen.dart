import 'package:flutter/material.dart';
import 'welcome_screen.dart';
import 'explore_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crunchyroll El Victor'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Buscador próximo a implementar'),
                  backgroundColor: Colors.orange,
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.person_outline, color: Colors.white),
            onPressed: () {
              // Ya estamos en ProfileScreen, no hacer nada o mostrar mensaje
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Ya estás en tu perfil'),
                  backgroundColor: Colors.orange,
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Mi Cuenta',
              style: TextStyle(
                color: Colors.orange,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.orange.shade800,
                  child: const Text(
                    'V',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Victor',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Miembro desde 2024',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 32),
            _buildProfileOption(
              icon: Icons.person_outline,
              title: 'Cambiar Perfil',
              onTap: () {},
            ),
            _buildProfileOption(
              icon: Icons.notifications_none,
              title: 'Notificaciones',
              onTap: () {},
            ),
            _buildProfileOption(
              icon: Icons.email_outlined,
              title: 'Email: victor@email.com',
              onTap: () {},
              showArrow: false,
            ),
            _buildProfileOption(
              icon: Icons.card_membership,
              title: 'Membresías 🐸',
              onTap: () {},
              showArrow: true,
            ),
            const Divider(color: Colors.orange, height: 32, thickness: 1),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const WelcomeScreen()),
                  );
                },
                icon: const Icon(Icons.logout, color: Colors.black),
                label: const Text(
                  'Cerrar sesión',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 5,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'Versión 1.0.0',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        currentIndex: 4,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: 'Categorías',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events),
            label: 'Premium',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Ajustes',
          ),
        ],
        onTap: (index) {
          if (index == 4) return; // Ya estamos en Ajustes/Profile
          
          switch (index) {
            case 0: // Inicio
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const WelcomeScreen()),
              );
              break;
            case 1: // Categorías (Explore)
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ExploreScreen()),
              );
              break;
            case 2: // Favoritos
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Próximamente: Favoritos'),
                  backgroundColor: Colors.orange,
                  duration: Duration(seconds: 1),
                ),
              );
              break;
            case 3: // Premium
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Próximamente: Premium'),
                  backgroundColor: Colors.orange,
                  duration: Duration(seconds: 1),
                ),
              );
              break;
          }
        },
      ),
    );
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool showArrow = true,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.orange, size: 28),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: showArrow
          ? Icon(Icons.arrow_forward_ios, color: Colors.orange.shade300, size: 20)
          : null,
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(vertical: 8),
    );
  }
}