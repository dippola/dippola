import 'package:flutter/material.dart';

class NavItem extends StatelessWidget {
  const NavItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      color: Colors.white,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 20.0),
              NavItems(title: 'Home', tapEvent: () {
                if (ModalRoute.of(context)!.settings.name != '/') {
                  Navigator.pushNamed(context, '/');
                }
              }),
              SizedBox(height: 20.0),
              NavItems(title: 'About', tapEvent: () {
                if (ModalRoute.of(context)!.settings.name != '/about') {
                  Navigator.pushNamed(context, '/about');
                }
              }),
              SizedBox(height: 20.0),
              NavItems(title: 'Projects', tapEvent: () {
                if (ModalRoute.of(context)!.settings.name != '/projects') {
                  Navigator.pushNamed(context, '/projects');
                }
              }),
              SizedBox(height: 20.0),
              NavItems(title: 'Contact', tapEvent: () {
                if (ModalRoute.of(context)!.settings.name != '/contact') {
                  Navigator.pushNamed(context, '/contact');
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}

class NavItems extends StatelessWidget {
  const NavItems({Key? key, required this.title, required this.tapEvent})
      : super(key: key);

  final String title;
  final GestureTapCallback tapEvent;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tapEvent,
      hoverColor: Colors.blueGrey, //transparent
      child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w300),
      ),
    );
  }
}
