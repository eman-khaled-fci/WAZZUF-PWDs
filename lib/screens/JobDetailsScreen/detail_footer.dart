import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wuzzuf_pwd/constants/constants.dart';
import 'package:wuzzuf_pwd/models/api_jop.dart';
import 'package:wuzzuf_pwd/models/firebase_application_model.dart';
import 'package:wuzzuf_pwd/service/firebase_job_service.dart';
import 'package:wuzzuf_pwd/utils/utils.dart';

class DetailFooter extends StatefulWidget {
  final JobsResult data;
  final int index;
  final int fireListSize;
  final Map<String, bool> applied;
  final Map<String, bool> fireApi;
  final String userId;

  const DetailFooter(this.data, this.index, this.fireListSize, this.applied,
      this.fireApi, this.userId,
      {Key key})
      : super(key: key);

  @override
  _DetailFooterState createState() => _DetailFooterState();
}

class _DetailFooterState extends State<DetailFooter> {
  @override
  Widget build(BuildContext context) {
    String applyText;
    Color color;
    if (widget.applied[widget.data.jobId] == false) {
      applyText = 'Apply Now';
      color = Colors.blue;
    } else {
      applyText = 'Applied';
      color = Colors.grey;
    }
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: const EdgeInsets.all(kSpacingUnit * 2),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [kFooterShadow],
        ),
        child: Row(
          children: [
            Container(
              height: kSpacingUnit * 6,
              width: kSpacingUnit * 8,
              decoration: BoxDecoration(
                color: kSilverColor,
                borderRadius: BorderRadius.circular(kSpacingUnit * 3),
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/company.svg',
                  height: 20,
                  width: 20,
                  color: Colors.blue,
                ),
              ),
            ),
            const SizedBox(width: kSpacingUnit * 2),
            Expanded(
              child: InkWell(
                onTap: () {
                  if (widget.applied[widget.data.jobId] == false) {
                    if (!widget.fireApi[widget.data.jobId]) {
                      FirebaseJobService().upLoad(
                          Utils().convertObjectApiToFirebase(widget.data));
                    }
                    FirebaseApplicationModel model = FirebaseApplicationModel(
                        cvLink: "CV_link.com",
                        jobId: widget.data.jobId,
                        status: "pending",
                        userId: widget.userId);
                    FirebaseJobService().upLoadApplication(model);
                    if (mounted) {
                      setState(() {
                        widget.applied[widget.data.jobId] = true;
                      });
                    }
                  }
                },
                child: Container(
                  height: kSpacingUnit * 6,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(kSpacingUnit * 3),
                  ),
                  child: Center(
                    child: Text(
                      applyText,
                      style: kTitleTextStyle.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
