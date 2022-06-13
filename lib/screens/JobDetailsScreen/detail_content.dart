import 'package:flutter/material.dart';
import 'package:wuzzuf_pwd/constants/constants.dart';
import 'package:wuzzuf_pwd/models/api_jop.dart';

import 'detail_item.dart';

class DetailContent extends StatelessWidget {
  const DetailContent(this.data, {Key key}) : super(key: key);

  final JobsResult data;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: kSpacingUnit * 4,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(kSpacingUnit * 5),
            topRight: Radius.circular(kSpacingUnit * 5),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: kSpacingUnit * 5),
              Center(
                child: Column(
                  children: [
                    Image.network(
                      data.thumbnail ??
                          "https://th.bing.com/th/id/R.301257298931ca32d333bcde5d523c85?rik=z9n1A0HDB1r8Vw&pid=ImgRaw&r=0",
                      height: 50,
                      width: 50,
                    ),
                    const SizedBox(height: kSpacingUnit * 2),
                    Text(
                      data.title,
                      style: kTitleTextStyle,
                    ),
                    const SizedBox(height: kSpacingUnit),
                    Text(
                      data.location,
                      style: kCaptionTextStyle,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: kSpacingUnit * 5),
              const Text(
                'Description',
                style: kSubTitleTextStyle,
              ),
              const SizedBox(height: kSpacingUnit * 2),
              DetailItem(data.description),
              const SizedBox(height: kSpacingUnit * 15),
            ],
          ),
        ),
      ),
    );
  }
}
