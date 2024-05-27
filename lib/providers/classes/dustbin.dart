class Location {
  String building;
  String floor;
  String room;
  String description;

  Location({
    required this.building,
    required this.floor,
    required this.room,
    required this.description,
  });
}

class Dustbin {
  String communityId;
  Location location;
  String lastCleanedDate;
  String lastCleanedTime;
  String filledStatus;
  String cleanerId;

  Dustbin({
    required this.communityId,
    required this.location,
    required this.lastCleanedDate,
    required this.lastCleanedTime,
    required this.filledStatus,
    required this.cleanerId,
  });
}
