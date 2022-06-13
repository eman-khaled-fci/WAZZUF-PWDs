import 'package:dio/dio.dart';
import 'package:wuzzuf_pwd/models/api_jop.dart';

class JobService {
  String baseUrl =
      "https://serpapi.com/search.json?engine=google_jobs&q=freelancing&hl=en&api_key=5728845b0826a2285acab91c14d4838068ef5a8ba4ee5f0eca21d760aa99deba";

  String pwdsJops =
      "https://serpapi.com/search.json?engine=google_jobs&q=jobs&start=1&hl=en&api_key=5728845b0826a2285acab91c14d4838068ef5a8ba4ee5f0eca21d760aa99deba";

  String recomended =
      "https://serpapi.com/search.json?engine=google_jobs&q=pwd&hl=en&api_key=5728845b0826a2285acab91c14d4838068ef5a8ba4ee5f0eca21d760aa99deba";

  List<JobsResult> jobList = [];
  List<JobsResult> joblistRecom = [];
  List<JobsResult> pwds = [];
  Future<List<JobsResult>> getJob() async {
    try {
      Response response = await Dio().get(baseUrl);
      var data = response.data;
      jobList = Welcome.fromJson(data).jobsResults;
    } catch (e) {
      print(e);
    }
    List<JobsResult> l = await getpwdsJobs();
    if (l != null) {
      jobList.addAll(l);
    }
    return jobList;
  }

  Future<List<JobsResult>> getJobRecom() async {
    try {
      Response response = await Dio().get(recomended);
      var data = response.data;
      joblistRecom = Welcome.fromJson(data).jobsResults;
      print("++++++++++++++++++  ${joblistRecom.length}");
    } catch (e) {
      print(e);
    }

    return joblistRecom;
  }

  Future<List<JobsResult>> getpwdsJobs() async {
    try {
      Response response = await Dio().get(pwdsJops);
      var data = response.data;
      pwds = Welcome.fromJson(data).jobsResults;
    } catch (e) {
      print(e);
    }

    return pwds;
  }
}
