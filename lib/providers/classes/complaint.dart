Set<String> complaintStatus = {'pending', 'resolved'};

class Complaint {
  String title;
  String communityId;
  String status;
  String description;
  String dateOfComplaint;
  String timeOfComplaint;
  String userId;
  String dustbinId;

  Complaint({
    required this.title,
    required this.communityId,
    required this.status,
    required this.description,
    required this.dateOfComplaint,
    required this.timeOfComplaint,
    required this.userId,
    required this.dustbinId,
  });
}
