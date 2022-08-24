import 'package:firebase_analytics/firebase_analytics.dart';

class AnalytsicsManager {
  static AnalytsicsManager? _instance;
  factory AnalytsicsManager() => _instance ??= AnalytsicsManager._init();
  AnalytsicsManager._init();

  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  FirebaseAnalyticsObserver appAnalyticsObserver() =>
      FirebaseAnalyticsObserver(analytics: _analytics);

  Future<void> logBeginCheckOut() async {
    await _analytics.logBeginCheckout(
        value: 10.0,
        currency: 'USD',
        items: [
          AnalyticsEventItem(
              itemName: 'Socks', itemId: 'xjw73ndnw', price: 10.0),
        ],
        coupon: '10PERCENTOFF');
  }

  Future<void> logEvent() async {
    await _analytics.logEvent(
        name: "denemeIsim",
        parameters: {"name": "heyyooo"},
        callOptions: AnalyticsCallOptions(global: true));
  }

  Future<void> reserAnalyticsData() async {
    await _analytics.resetAnalyticsData();
       
  }
}
