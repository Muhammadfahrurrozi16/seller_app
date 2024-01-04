import 'dart:convert';

class ImageRespon {
  final String imagePath;
  final String baseUrl;
  ImageRespon({
    required this.imagePath,
    required this.baseUrl,
  });

  ImageRespon copyWith({
    String? imagePath,
    String? baseUrl,
  }) {
    return ImageRespon(
      imagePath: imagePath ?? this.imagePath,
      baseUrl: baseUrl ?? this.baseUrl,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'imagePath': imagePath});
    result.addAll({'baseUrl': baseUrl});
  
    return result;
  }

  factory ImageRespon.fromMap(Map<String, dynamic> map) {
    return ImageRespon(
      imagePath: map['image_Path'] ?? '',
      baseUrl: map['base_Url'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageRespon.fromJson(String source) => ImageRespon.fromMap(json.decode(source));

  @override
  String toString() => 'ImageRespon(imagePath: $imagePath, baseUrl: $baseUrl)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ImageRespon &&
      other.imagePath == imagePath &&
      other.baseUrl == baseUrl;
  }

  @override
  int get hashCode => imagePath.hashCode ^ baseUrl.hashCode;
}
