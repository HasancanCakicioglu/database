
import 'package:firebase/performanceMonitoring/performansManager.dart';
import 'package:flutter/material.dart';

class performanceView extends StatefulWidget {
  performanceView({Key? key}) : super(key: key);

  @override
  State<performanceView> createState() => _performanceViewState();
}

class _performanceViewState extends State<performanceView> {
  late PerformansManager performanceManager;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    performanceManager = PerformansManager();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              
              ElevatedButton(
                  onPressed: () {
                    performanceManager.isEnabled();
                  },
                  child: Text("isPerformanceEnable ?")),
                  ElevatedButton(
                  onPressed: () {
                    performanceManager.toggleEnablePerformance();
                  },
                  child: Text("toggle Enable")),
                  ElevatedButton(
                  onPressed: () {
                    performanceManager.startTrace();
                  },
                  child: Text("startTrace")),
                  ElevatedButton(
                  onPressed: () {
                    performanceManager.stopTrace();
                  },
                  child: Text("stopTrace")),
                  ElevatedButton(
                  onPressed: () {
                    performanceManager.setMetric();
                  },
                  child: Text("setMetric")),
                  ElevatedButton(
                  onPressed: () {
                    performanceManager.incrementMetrics();
                  },
                  child: Text("incrementMetrics")),
                  ElevatedButton(
                  onPressed: () {
                    performanceManager.traceApiRequest();
                  },
                  child: Text("traceApiRequest")),
                  ElevatedButton(
                  onPressed: () {
                    performanceManager.putAttribute();
                  },
                  child: Text("putAttribute")),
                  ElevatedButton(
                  onPressed: () {
                    performanceManager.removeAttribute();
                  },
                  child: Text("removeAttribute")),

              
            ],
          ),
        ),
      ),
    );
  }
}
