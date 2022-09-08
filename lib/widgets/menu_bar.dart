import 'package:flutter/material.dart';

class MenuBarWidget extends StatelessWidget {
  const MenuBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 45,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Stack(
              children: [
                const Positioned(
                  right: 135,
                  top: 5,
                  child: CircleAvatar(
                    radius: 15,
                    foregroundImage: AssetImage('assets/icons/vidic.png'),
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 1,
                  child: Row(
                    children: const [
                      Text(
                        'Francis Otworo',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Icon(Icons.arrow_drop_down)
                    ],
                  ),
                ),
                const Positioned(
                  right: 101,
                  top: 25,
                  child: Text(
                    'Admin',
                    style: TextStyle(fontSize: 10),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
