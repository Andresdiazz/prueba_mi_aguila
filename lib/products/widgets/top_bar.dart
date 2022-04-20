import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TopBar extends StatelessWidget {
  const TopBar({Key? key, this.image, this.title}) : super(key: key);

  final String? image;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title == null
          ? SvgPicture.asset(
              image!,
              color: Colors.white,
            )
          : Text(title!),
      actions: [
        IconButton(
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
            icon: const Icon(Icons.shopping_cart))
      ],
    );
  }
}
