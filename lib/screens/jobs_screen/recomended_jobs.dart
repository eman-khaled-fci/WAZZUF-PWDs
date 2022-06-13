import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:wuzzuf_pwd/models/api_jop.dart';

import 'job_card.dart';

class RecomendedJobs extends StatefulWidget {
  List<JobsResult> data;
  int fireListSize;
  Map<String, bool> applied;
  Map<String, bool> fireApi;
  final String userId;

  RecomendedJobs(
      this.data, this.fireListSize, this.applied, this.fireApi, this.userId,
      {Key key})
      : super(key: key);

  @override
  _RecomendedJobsState createState() => _RecomendedJobsState();
}

class _RecomendedJobsState extends State<RecomendedJobs> {
  int _cardIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Align(
      child: CarouselSlider.builder(
        options: CarouselOptions(
          height: 200,
          viewportFraction: 0.8,
          initialPage: _cardIndex,
          enlargeCenterPage: true,
          onPageChanged: (index, reason) {
            if (mounted) {
              setState(() {
                _cardIndex = index;
              });
            }
          },
        ),
        itemCount: widget.data.length,
        itemBuilder: (BuildContext context, int index) => SizedBox(
          width: double.infinity,
          child: JobCard(widget.data[index], index, widget.fireListSize,
              widget.applied, widget.fireApi, widget.userId),
        ),
      ),
    );
  }
}
