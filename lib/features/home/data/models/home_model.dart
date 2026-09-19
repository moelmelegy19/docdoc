/// Model for the VCare Home Page API response.
/// GET /home/index
class HomeModel {
  final List<SpecializationModel> specializations;
  final List<DoctorModel> doctors;

  const HomeModel({
    required this.specializations,
    required this.doctors,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];

    // data could be a Map or a List — handle both defensively
    List<dynamic> specializationsList = [];
    List<dynamic> doctorsList = [];

    if (data is Map<String, dynamic>) {
      final rawSpec = data['specializations'];
      final rawDoc = data['doctors'];

      // API may return a List or a Map with string keys
      if (rawSpec is List) {
        specializationsList = rawSpec;
      } else if (rawSpec is Map) {
        specializationsList = rawSpec.values.toList();
      }

      if (rawDoc is List) {
        doctorsList = rawDoc;
      } else if (rawDoc is Map) {
        doctorsList = rawDoc.values.toList();
      }
    } else if (data is List) {
      // flat list — skip specializations
      doctorsList = data;
    }

    return HomeModel(
      specializations: specializationsList
          .whereType<Map>()
          .map((e) => SpecializationModel.fromJson(Map<String, dynamic>.from(e)))
          .toList(),
      doctors: doctorsList
          .whereType<Map>()
          .map((e) => DoctorModel.fromJson(Map<String, dynamic>.from(e)))
          .toList(),
    );
  }
}

class SpecializationModel {
  final int id;
  final String name;
  final String? image;

  const SpecializationModel({
    required this.id,
    required this.name,
    this.image,
  });

  factory SpecializationModel.fromJson(Map<String, dynamic> json) {
    return SpecializationModel(
      // API may return id as String ("5") or int (5) — handle both
      id: int.tryParse(json['id'].toString()) ?? 0,
      name: json['name']?.toString() ?? '',
      image: json['image']?.toString(),
    );
  }
}

class DoctorModel {
  final int id;
  final String name;
  final String? image;
  final String? specialization;
  final String? hospital;
  final double? rating;
  final int? reviewsCount;

  const DoctorModel({
    required this.id,
    required this.name,
    this.image,
    this.specialization,
    this.hospital,
    this.rating,
    this.reviewsCount,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    // Resolve specialization name from nested object or plain string
    String? specName;
    final rawSpec = json['specialization'];
    if (rawSpec is Map) {
      specName = rawSpec['name']?.toString();
    } else if (rawSpec is String) {
      specName = rawSpec;
    }

    // Resolve hospital from 'hospital', 'city.name', or 'governrate'
    String? hospitalName;
    final rawCity = json['city'];
    if (json['hospital'] != null) {
      hospitalName = json['hospital'].toString();
    } else if (rawCity is Map) {
      hospitalName = rawCity['name']?.toString();
    } else if (rawCity is String) {
      hospitalName = rawCity;
    }

    return DoctorModel(
      // id may come as String or int from the API
      id: int.tryParse(json['id'].toString()) ?? 0,
      name: json['name']?.toString() ?? '',
      image: json['image']?.toString(),
      specialization: specName,
      hospital: hospitalName,
      rating: double.tryParse(json['rating']?.toString() ?? ''),
      reviewsCount: int.tryParse(json['reviews_count']?.toString() ?? ''),
    );
  }
}
