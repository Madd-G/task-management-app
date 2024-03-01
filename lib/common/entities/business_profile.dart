class BusinessProfile {
  String? businessLogo;
  String? businessName;
  List<String>? businessSector;
  String? businessValue;

  BusinessProfile({
    this.businessLogo,
    this.businessName,
    this.businessSector,
    this.businessValue,
  });

  factory BusinessProfile.fromJson(Map<String, dynamic> json) {
    return BusinessProfile(
      businessLogo: json['business_logo'] ?? '',
      businessName: json['business_name'] ?? '',
      businessSector: List<String>.from(json['business_sector'] ?? []),
      businessValue: json['business_value'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'business_logo': businessLogo,
      'business_name': businessName,
      'business_sector': businessSector,
      'business_value': businessValue,
    };
  }

  Map<String, dynamic> toJsonUpdateName() {
    return {
      'business_name': businessName,
    };
  }
}
