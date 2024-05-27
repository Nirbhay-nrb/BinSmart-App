class Address {
  String street;
  String city;
  String state;
  String pincode;

  Address({
    required this.street,
    required this.city,
    required this.state,
    required this.pincode,
  });
}

class Community {
  String communityId;
  Address address;
  String name;

  Community({
    required this.communityId,
    required this.address,
    required this.name,
  });
}
