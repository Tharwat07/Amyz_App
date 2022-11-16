import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/theme_provider.dart';
import '../../utill/custom_themes.dart';
import '../../utill/dimensions.dart';
import '../../utill/images.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final isBackButtonExist;
  final IconData icon;
  final Function onActionPressed;
  final Function onBackPressed;

  CustomAppBar(
      {@required this.title,
      this.isBackButtonExist = true,
      this.icon,
      this.onActionPressed,
      this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ClipRRect(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5)),
        child: Image.asset(
          Images.toolbar_background,
          fit: BoxFit.fill,
          height: 50 + MediaQuery.of(context).padding.top,
          width: MediaQuery.of(context).size.width,
          color: Provider.of<ThemeProvider>(context).darkTheme
              ? Colors.black
              : Colors.white,
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        height: 50,
        alignment: Alignment.center,
        child: Row(children: [
          isBackButtonExist
              ? IconButton(
                  icon: Image.asset(
                    Images.arrow_back,
                    height: 35,
                    color: Provider.of<ThemeProvider>(context).darkTheme
                        ? Colors.white
                        : Colors.black,
                    fit: BoxFit.contain,
                  ),
                  onPressed: () {
                    onBackPressed != null
                        ? onBackPressed()
                        : Navigator.of(context).pop();
                  })
              : SizedBox.shrink(),
          SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
          Expanded(
            child: Text(
              title,
              style: titilliumRegular.copyWith(
                fontSize: 20,
                color: Provider.of<ThemeProvider>(context).darkTheme
                    ? Colors.white
                    : Colors.black,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          icon != null
              ? IconButton(
                  icon: Icon(icon,
                      size: Dimensions.ICON_SIZE_LARGE, color: Colors.white),
                  onPressed: onActionPressed,
                )
              : SizedBox.shrink(),
        ]),
      ),
    ]);
  }
}
