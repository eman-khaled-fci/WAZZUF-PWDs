import 'package:flutter/material.dart';
import 'package:wuzzuf_pwd/constants/constants.dart';

class DetailItem extends StatelessWidget {
  final String data;

  const DetailItem(this.data, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: kSpacingUnit * 2),
      child: Text(
        data,
        style: kCaptionTextStyle.copyWith(
          color: kPrimaryTextColor,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
