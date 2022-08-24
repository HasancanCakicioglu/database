
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class PerformansManager {
  FirebasePerformance performance = FirebasePerformance.instance;
  late Trace trace = performance.newTrace('custom-trace');

  Future<bool> isEnabled() async {
    performance.isPerformanceCollectionEnabled().then((value) {
      debugPrint("performance = " + value.toString());
    });
    return performance.isPerformanceCollectionEnabled();
  }

  Future<void> toggleEnablePerformance() async {
    if (await isEnabled()) {
      performance.setPerformanceCollectionEnabled(false);
    } else {
      performance.setPerformanceCollectionEnabled(true);
    }
  }

  Future<void> startTrace() async {
    await trace.start();
    
  }

  Future<void> stopTrace() async {
    await trace.stop();
  }

  Future<void> setMetric() async {
// Set metrics you wish to track
    trace.setMetric('sum', 200);
    trace.setMetric('time', 342340435);
  }

  Future<void> incrementMetrics() async {
    trace.incrementMetric('sum', 1);
  }

  Future<void> putAttribute() async {
    trace.putAttribute('userId', '1234');
  }

  Future<void> removeAttribute() async {
    trace.putAttribute('userId', '1234');
  }

  Future<void> traceApiRequest() async {
    String url = 'https://firebase.flutter.dev';
    HttpMetric metric = performance.newHttpMetric(url, HttpMethod.Get);

// You may also assign up to 5 attributes for each trace
    metric.putAttribute('foo', 'bar');

// Start the trace
    await metric.start();

// Make the request
    Uri uri = Uri.parse(url);
    var response = await http.get(uri);

// Set specific headers to be collated
    metric.responseContentType = response.headers['Content-Type'];
    metric.httpResponseCode = response.statusCode;
    metric.responsePayloadSize = response.contentLength;

// Stops the trace. This is when the data is sent to the Firebase server and it will appear in your Firebase console
    await metric.stop();
  }
}
