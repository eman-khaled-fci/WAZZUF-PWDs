import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:wuzzuf_pwd/constants/constants.dart';
import 'package:wuzzuf_pwd/models/api_jop.dart';
import 'package:wuzzuf_pwd/screens/JobDetailsScreen/detail_screen.dart';

class JobCard extends StatelessWidget {
  final JobsResult data;
  final int index;
  final int fireListSize;
  final Map<String, bool> applied;
  final Map<String, bool> fireApi;
  final String userId;

  const JobCard(this.data, this.index, this.fireListSize, this.applied,
      this.fireApi, this.userId,
      {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [kCardShadow],
      ),
      child: OpenContainer(
        transitionType: ContainerTransitionType.fade,
        transitionDuration: const Duration(milliseconds: 500),
        openColor: kSilverColor,
        openElevation: 0,
        openBuilder: (context, action) {
          return DetailScreen(
              data, index, fireListSize, applied, fireApi, userId);
        },
        closedColor: Colors.transparent,
        closedElevation: 0,
        closedBuilder: (context, action) {
          return Container(
            padding: const EdgeInsets.all(kSpacingUnit * 2),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadiusDirectional.circular(kSpacingUnit * 3),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.network(
                      data.thumbnail ??
                          "https://th.bing.com/th/id/R.301257298931ca32d333bcde5d523c85?rik=z9n1A0HDB1r8Vw&pid=ImgRaw&r=0",
                      height: 40,
                      width: 40,
                    ),
                    const SizedBox(width: kSpacingUnit),
                    Expanded(
                      child: Text(
                        data.companyName,
                        style: kCardTitleTextStyle,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  data.title,
                  style: kSubTitleTextStyle,
                ),
                const SizedBox(height: kSpacingUnit * 0.5),
                Text(
                  data.location,
                  style: kCaptionTextStyle,
                ),
                Text(data.detectedExtensions.postedAt, style: kCaptionTextStyle)
              ],
            ),
          );
        },
      ),
    );
  }
}
