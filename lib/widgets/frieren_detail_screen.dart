import 'package:flutter/material.dart';

class FrierenDetailScreen extends StatelessWidget {
  final String animeTitle;

  const FrierenDetailScreen({super.key, required this.animeTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título del anime (sin # X)
            Text(
              animeTitle,
              style: const TextStyle(
                color: Colors.orange,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            
            // Fila con subtítulo e ícono de filtros
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _getSeasonText(),
                  style: const TextStyle(
                    color: Colors.orange,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                // Ícono de filtros
                IconButton(
                  icon: const Icon(Icons.filter_alt, color: Colors.orange, size: 24),
                  onPressed: () {
                    _showFilterOptions(context);
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Lista de episodios
            ..._buildEpisodeList(context),
            
            const SizedBox(height: 24),
            _buildIconRow(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  String _getSeasonText() {
    switch (animeTitle) {
      case 'Frieren':
        return '- Frieren Season 2:';
      case 'Gachiakuta':
        return '- Gachiakuta Season 1:';
      case 'One Piece':
        return '- One Piece Saga Actual:';
      case 'Fire Force':
        return '- Fire Force Season 3:';
      case 'Jujutsu Kaisen':
        return '- Jujutsu Kaisen Season 2:';
      case 'Chainsaw Man':
        return '- Chainsaw Man Season 1:';
      case 'Spy x Family':
        return '- Spy x Family Season 2:';
      case 'Demon Slayer':
        return '- Demon Slayer Season 4:';
      default:
        return '- $animeTitle:';
    }
  }

  // Mostrar opciones de filtro
  void _showFilterOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey.shade900,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Filtrar episodios',
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.sort, color: Colors.orange),
                title: const Text('Más recientes', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Ordenando por más recientes'),
                      backgroundColor: Colors.orange,
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.access_time, color: Colors.orange),
                title: const Text('Más antiguos', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Ordenando por más antiguos'),
                      backgroundColor: Colors.orange,
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.visibility, color: Colors.orange),
                title: const Text('Solo disponibles', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Mostrando solo episodios disponibles'),
                      backgroundColor: Colors.orange,
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _buildEpisodeList(BuildContext context) {
    int episodeCount = _getEpisodeCount();
    List<Widget> episodes = [];
    
    for (int i = 1; i <= episodeCount; i++) {
      episodes.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: _buildEpisodeItem(context, i),
        ),
      );
    }
    
    return episodes;
  }

  Widget _buildEpisodeItem(BuildContext context, int episodeNumber) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange.withOpacity(0.3), width: 1),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
            child: Container(
              width: 100,
              height: 80,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(_getEpisodeImage(episodeNumber)),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.orange.withOpacity(0.2),
                    BlendMode.darken,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Episodio $episodeNumber',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _getEpisodeStatus(episodeNumber),
                          style: TextStyle(
                            color: _getEpisodeStatus(episodeNumber) == 'Disponible' 
                                ? Colors.green 
                                : Colors.orange,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      if (_getEpisodeStatus(episodeNumber) == 'Disponible')
                        Container(
                          margin: const EdgeInsets.only(right: 8),
                          child: IconButton(
                            icon: Icon(Icons.download, color: Colors.orange.shade400, size: 22),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Descargando Episodio $episodeNumber de $animeTitle'),
                                  backgroundColor: Colors.orange,
                                  duration: const Duration(seconds: 1),
                                ),
                              );
                            },
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ),
                      IconButton(
                        icon: Icon(Icons.more_vert, color: Colors.orange.shade400, size: 22),
                        onPressed: () {
                          _showEpisodeOptions(context, episodeNumber);
                        },
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getEpisodeImage(int episodeNumber) {
    String baseColor;
    if (animeTitle == 'Frieren') {
      baseColor = 'FF8C00';
    } else if (animeTitle == 'One Piece') {
      baseColor = 'FFA500';
    } else if (animeTitle == 'Jujutsu Kaisen') {
      baseColor = 'FF4500';
    } else {
      baseColor = 'FF6347';
    }
    
    return 'https://via.placeholder.com/150x120/$baseColor/FFFFFF?text=${animeTitle.replaceAll(' ', '+')}+Ep$episodeNumber';
  }

  int _getEpisodeCount() {
    switch (animeTitle) {
      case 'Frieren':
        return 6;
      case 'Gachiakuta':
        return 8;
      case 'One Piece':
        return 12;
      case 'Fire Force':
        return 10;
      case 'Jujutsu Kaisen':
        return 8;
      case 'Chainsaw Man':
        return 6;
      case 'Spy x Family':
        return 8;
      case 'Demon Slayer':
        return 9;
      default:
        return 5;
    }
  }

  String _getEpisodeStatus(int episodeNumber) {
    if (animeTitle == 'One Piece' && episodeNumber > 8) {
      return 'Próximamente';
    } else if (animeTitle == 'Fire Force' && episodeNumber > 7) {
      return 'Próximamente';
    } else if (animeTitle == 'Jujutsu Kaisen' && episodeNumber > 6) {
      return 'Próximamente';
    }
    return 'Disponible';
  }

  void _showEpisodeOptions(BuildContext context, int episodeNumber) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey.shade900,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.info, color: Colors.orange),
                title: const Text('Detalles', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Detalles de Episodio $episodeNumber de $animeTitle'),
                      backgroundColor: Colors.orange,
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.share, color: Colors.orange),
                title: const Text('Compartir', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Compartiendo Episodio $episodeNumber de $animeTitle'),
                      backgroundColor: Colors.orange,
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.favorite_border, color: Colors.orange),
                title: const Text('Añadir a favoritos', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Episodio $episodeNumber añadido a favoritos'),
                      backgroundColor: Colors.orange,
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildIconRow() {
    if (animeTitle == 'Frieren') {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.arrow_upward, color: Colors.orange.shade400, size: 28),
          const SizedBox(width: 8),
          _buildFishIcon(),
          _buildFishIcon(),
          _buildFishIcon(),
        ],
      );
    } else if (animeTitle == 'One Piece') {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('🏴‍☠️', style: TextStyle(fontSize: 28)),
          const SizedBox(width: 8),
          const Text('⚓', style: TextStyle(fontSize: 28)),
          const SizedBox(width: 8),
          const Text('🏝️', style: TextStyle(fontSize: 28)),
        ],
      );
    } else if (animeTitle == 'Jujutsu Kaisen') {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('👺', style: TextStyle(fontSize: 28)),
          const SizedBox(width: 8),
          const Text('⚡', style: TextStyle(fontSize: 28)),
          const SizedBox(width: 8),
          const Text('🔮', style: TextStyle(fontSize: 28)),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.star, color: Colors.orange.shade400, size: 28),
          const SizedBox(width: 8),
          Icon(Icons.play_arrow, color: Colors.orange.shade400, size: 28),
          const SizedBox(width: 8),
          Icon(Icons.new_releases, color: Colors.orange.shade400, size: 28),
        ],
      );
    }
  }

  Widget _buildFishIcon() {
    return const Text(
      '🐟',
      style: TextStyle(fontSize: 28),
    );
  }
}