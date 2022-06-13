import 'package:flutter/material.dart';
import 'package:wuzzuf_pwd/constants/constants.dart';
import 'package:wuzzuf_pwd/models/api_jop.dart';

class DetailHeader extends StatelessWidget {
  const DetailHeader(this.data, {Key key}) : super(key: key);

  final JobsResult data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 30,
      ),
      child: Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back_ios_rounded)),
            Text(
              data.companyName,
              style: kSubTitleTextStyle.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 30),
          ],
        ),
      ),
    );
  }
}
