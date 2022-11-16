import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../localization/language_constrants.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/custom_themes.dart';
import '../../../../utill/dimensions.dart';

class PreferenceDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
              child: Text(getTranslated('preference', context), style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE)),
            ),
            Text ('Location',style: TextStyle(fontSize: 20),),
            Text( 'Storage',style: TextStyle(fontSize: 20),),
            Text( 'Push Notification',style: TextStyle(fontSize: 20),),
            Divider(height: Dimensions.PADDING_SIZE_EXTRA_SMALL, color: ColorResources.HINT_TEXT_COLOR),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(getTranslated('CANCEL', context), style: robotoRegular.copyWith(color: ColorResources.YELLOW)),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}

class SwitchTile extends StatelessWidget {
  final String title;
  final bool value;
  SwitchTile({@required this.title, @required this.value});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: CupertinoSwitch(
        value: value,
        activeColor: ColorResources.GREEN,
        trackColor: ColorResources.RED,
        onChanged: (isChecked) {},
      ),
      onTap: () {},
    );
  }
}

