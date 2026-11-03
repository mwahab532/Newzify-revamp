abstract class AppConstants {
  static const String baseUrl = "https://newsapi.org/v2";
  static const String apiKey = "051884902ed54c8184366495aa3d6eb3";

  static const String defaultChannel = 'bbc-news';
  static const String defaultCategory = 'General';

  static const List<String> categoryList = [
    "General",
    "Business",
    "Sports",
    "Entertainment",
    "Health",
    "Technology",
  ];
}

/// News source channels available in the filter menu.
enum NewsChannel {
  bbcNews,
  cnn,
  abcNews,
  associatedPress,
  bloomberg,
  aljazeeraEnglish,
  businessInsider,
}

extension NewsChannelX on NewsChannel {
  String get apiValue {
    switch (this) {
      case NewsChannel.bbcNews:
        return 'bbc-news';
      case NewsChannel.cnn:
        return 'cnn';
      case NewsChannel.abcNews:
        return 'abc-news';
      case NewsChannel.associatedPress:
        return 'associated-press';
      case NewsChannel.bloomberg:
        return 'bloomberg';
      case NewsChannel.aljazeeraEnglish:
        return 'al-jazeera-english';
      case NewsChannel.businessInsider:
        return 'business-insider';
    }
  }

  String get label {
    switch (this) {
      case NewsChannel.bbcNews:
        return 'BBC News';
      case NewsChannel.cnn:
        return 'CNN';
      case NewsChannel.abcNews:
        return 'ABC News';
      case NewsChannel.associatedPress:
        return 'Associated Press';
      case NewsChannel.bloomberg:
        return 'Bloomberg';
      case NewsChannel.aljazeeraEnglish:
        return 'Al Jazeera';
      case NewsChannel.businessInsider:
        return 'Business Insider';
    }
  }
}
