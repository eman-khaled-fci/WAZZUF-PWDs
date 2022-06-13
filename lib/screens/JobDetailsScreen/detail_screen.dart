import 'package:flutter/material.dart';
import 'package:wuzzuf_pwd/constants/constants.dart';
import 'package:wuzzuf_pwd/models/api_jop.dart';
import 'package:wuzzuf_pwd/screens/JobDetailsScreen/detail_content.dart';
import 'package:wuzzuf_pwd/screens/JobDetailsScreen/detail_footer.dart';
import 'package:wuzzuf_pwd/screens/JobDetailsScreen/detail_header.dart';

class DetailScreen extends StatelessWidget {
  final JobsResult data;
  final int index;
  final int fireListSize;
  final Map<String, bool> applied;
  final Map<String, bool> fireApi;
  final String userId;

  const DetailScreen(this.data, this.index, this.fireListSize, this.applied,
      this.fireApi, this.userId,
      {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSilverColor,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                DetailHeader(data),
                DetailContent(data),
              ],
            ),
            DetailFooter(data, index, fireListSize, applied, fireApi, userId),
          ],
        ),
      ),
    );
  }
}
