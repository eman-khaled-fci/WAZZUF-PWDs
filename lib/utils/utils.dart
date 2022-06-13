import 'package:wuzzuf_pwd/models/api_jop.dart';
import 'package:wuzzuf_pwd/models/firebase_job_model.dart';

class Utils {
  List<JobsResult> convertLitsFireToApi(List<FirebaseJobModel> fireList) {
    List<JobsResult> apiList = [];
    for (var element in fireList) {
      apiList.add(JobsResult(
          jobId: element.id,
          title: element.title,
          companyName: element.organization,
          location: element.address,
          description: element.description,
          detectedExtensions: DetectedExtensions(postedAt: "1 day")));
    }
    return apiList;
  }

  FirebaseJobModel convertObjectApiToFirebase(JobsResult jobsResult) {
    FirebaseJobModel object = FirebaseJobModel(
        id: jobsResult.jobId,
        address: jobsResult.location,
        department: jobsResult.title,
        description: jobsResult.description,
        disability: "Locomotor Disability",
        organization: jobsResult.companyName,
        title: jobsResult.title);
    return object;
  }
}
