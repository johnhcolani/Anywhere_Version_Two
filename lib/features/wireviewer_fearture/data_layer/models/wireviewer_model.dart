class WireViewerCharacter {
  final String name;
  final String text;
  final String firstUrl;
  final String imageUrl;
  final String description;

  WireViewerCharacter( {
    required this.name,
    required this.firstUrl,
    required this.text,
    required this.imageUrl,
    required this.description,
  });

  factory WireViewerCharacter.fromJson(Map<String, dynamic> json) {
    String text = json['Text'] ?? "";
    List<String> parts = text.split(" - ");
    String name = parts.isNotEmpty ? parts.first : "Unknown";

    return WireViewerCharacter(
      text: text,
      name: name,
      imageUrl: json['Icon']?['URL'] != null
          ? 'https://duckduckgo.com${json['Icon']['URL']}'
          : 'your_placeholder_image_url_here',
      description: json['Result'] ?? "",
      firstUrl: json["FirstURL"] ?? "",
    );
  }
}

