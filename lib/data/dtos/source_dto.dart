class SourceDto {
  final String? id;
  final String? name;

  const SourceDto({this.id, this.name});

  factory SourceDto.fromJson(Map<String, dynamic> json) => SourceDto(
        id: json['id'] as String?,
        name: json['name'] as String?,
      );
}
