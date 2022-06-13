import 'package:flutter/material.dart';
import 'package:wuzzuf_pwd/constants/constants.dart';
import 'package:wuzzuf_pwd/models/api_jop.dart';
import 'package:wuzzuf_pwd/models/firebase_job_model.dart';
import 'package:wuzzuf_pwd/screens/jobs_screen/recomended_jobs.dart';
import 'package:wuzzuf_pwd/service/applications_service.dart';
import 'package:wuzzuf_pwd/service/firebase_job_service.dart';
import 'package:wuzzuf_pwd/service/job_service.dart';
import 'package:wuzzuf_pwd/utils/utils.dart';

import 'job_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<JobsResult> jobsList = [],
      jobsListForDisplay = [],
      recomendedJobsList = [];
  Map<String, bool> applied = {};
  Map<String, bool> fireApi = {};
  bool isLoading = true;
  int fireListSize;
  String userId = "";
  ApplicationsService applicationsService = ApplicationsService();

  getjobList() async {
    await applicationsService.getApplications();
    userId = applicationsService.userId;
    recomendedJobsList = await JobService().getJobRecom();
    if (recomendedJobsList != null) {
      recomendedJobsList = applicationsService.filterList(recomendedJobsList);
    }
    List<FirebaseJobModel> firelis =
        await FirebaseJobService(fireApi: fireApi).getData();
    if (firelis != null) {
      jobsList.addAll(applicationsService.filterList(
          Utils().convertLitsFireToApi(firelis)));
      fireListSize = jobsList.length;
    }
    List<JobsResult> apiJobs = await JobService().getJob();
    if (apiJobs != null) {
      apiJobs = applicationsService.filterList(apiJobs);
      for (int i = 0; i < apiJobs.length; i++) {
        if (fireApi[apiJobs[i].jobId] == null) jobsList.add(apiJobs[i]);
      }
    }
    if (recomendedJobsList != null) {
      recomendedJobsList = applicationsService.filterList(recomendedJobsList);
      for (int i = 0; i < recomendedJobsList.length; i++) {
        if (fireApi[recomendedJobsList[i].jobId] == null) {
          jobsList.add(recomendedJobsList[i]);
        }
      }
    }
    for (int i = 0; i < jobsList.length; i++) {
      applied[jobsList[i].jobId] = false;
      if (i < fireListSize) {
        fireApi[jobsList[i].jobId] = true;
      } else {
        fireApi[jobsList[i].jobId] = false;
      }
    }
    jobsListForDisplay = jobsList;
    if(mounted){
    setState(() {
      isLoading = false;
    });
    }
  }

  @override
  void initState() {
    super.initState();
    getjobList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: kSpacingUnit * 3),
                  Flexible(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: kSilverColor,
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
                            const SizedBox(height: kSpacingUnit * 5),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kSpacingUnit * 3),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                                kSpacingUnit * 3),
                                          ),
                                          margin: const EdgeInsets.all(10.0),
                                          child: TextField(
                                            decoration: InputDecoration(
                                              hintText: "Search Job",
                                              border: InputBorder.none,
                                              hintStyle:
                                                  kBodyTextStyle.copyWith(
                                                color: kSecondaryTextColor,
                                              ),
                                              prefixIcon: const Icon(
                                                Icons.search,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            keyboardType: TextInputType.text,
                                            onChanged: (text) {
                                              text = text.toLowerCase();
                                              if(mounted){
                                              setState(() {
                                                jobsListForDisplay =
                                                    jobsList.where((element) {
                                                  var title = element.title
                                                      .toLowerCase();
                                                  return title.contains(text);
                                                }).toList();
                                              });
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: kSpacingUnit * 2),
                                    ],
                                  ),
                                  const SizedBox(height: kSpacingUnit * 2),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kSpacingUnit * 4),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Recomended For You',
                                    style: kSubTitleTextStyle.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            recomendedJobsList != null
                                ? RecomendedJobs(recomendedJobsList,
                                    fireListSize, applied, fireApi, userId)
                                : const Center(
                                    child: Text("Not Found"),
                                  ),
                            const SizedBox(height: kSpacingUnit * 2),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kSpacingUnit * 4),
                              child: Text(
                                '${jobsListForDisplay.length} Jop Found',
                                style: kSubTitleTextStyle.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Flexible(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: jobsListForDisplay
                                    .asMap()
                                    .entries
                                    .map(
                                      (item) => Container(
                                        margin: const EdgeInsets.symmetric(
                                                horizontal: kSpacingUnit * 3)
                                            .copyWith(
                                          top: item.key == 0
                                              ? kSpacingUnit * 2
                                              : 0,
                                          bottom: kSpacingUnit * 2,
                                        ),
                                        child: JobCard(
                                            item.value,
                                            item.key,
                                            fireListSize,
                                            applied,
                                            fireApi,
                                            userId),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
