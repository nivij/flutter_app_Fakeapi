import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constant/text_font.dart';

class ListTileWidget extends StatelessWidget {
  String leading;
  String Trail;
  ListTileWidget({
    Key? key,
    required this.leading,
    required this.Trail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(leading, style: AppStyles.subTitle),
      trailing: Text(Trail,
          style: AppStyles.subTitle.copyWith(color: Colors.orange)),
    );
  }
}
