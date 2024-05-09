import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MenuItem{

  final String title;
  final IconData icon;
  final String route;

  MenuItem({
    required this.title, 
    required this.icon, 
    required this.route
    });
}

final menuItems = <MenuItem>[
  MenuItem(title: 'Giroscopio', icon: Icons.downloading, route: '/gyroscope'),
  MenuItem(title: 'Acelerometro', icon: Icons.speed, route: '/accelerometer'),
  MenuItem(title: 'Giroscopio', icon: Icons.explore_outlined, route: '/magnetometer'),

  MenuItem(title: 'Giroscopio', icon: Icons.sports_baseball, route: '/gyroscope-ball'),
  MenuItem(title: 'Giroscopio', icon: Icons.explore, route: '/compass'),
];


class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.count(
      crossAxisCount: 3,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: [
        ...menuItems.map((item) => HomeMenuItem(title: item.title, route: item.route, icon: item.icon))
      ],);
  }
}



class HomeMenuItem extends StatelessWidget {
  final String title;
  final String route;
  final IconData icon;
  final List<Color> bgColors;
  const HomeMenuItem({super.key,
   required this.title, 
   required this.route, 
   required this.icon, 
    this.bgColors = const [ Colors.lightBlue, Colors.blue ]
   });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(route),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(colors: bgColors),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,color: Colors.white,size: 40,),
            const SizedBox(height: 10,),
            Text(title,
            style: const TextStyle(color: Colors.white),)
          ],
        ),
      ),
    );
  }
}