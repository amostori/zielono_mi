import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:zielone_japko/src/features/home/hive_helper/tea_time.dart';
import 'package:zielone_japko/src/utils/constants.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> with TickerProviderStateMixin {
  late AudioPlayer player = AudioPlayer();
  late AnimationController _animationController;
  late Timer _timer;
  int baseTime = 180;
  late double screenWidth;
  late double screenHeight;

  String get timerString {
    Duration? duration =
        _animationController.duration! * _animationController.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  void setController(int time) {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: time),
    );
  }

  void startEverything(int time) {
    setController(time);
    _timer = Timer(Duration(seconds: time), () async {
      await player.play(AssetSource('sounds/clock.wav'));
    });
    _animationController.reverse(
        from: _animationController.value == 0.0
            ? 1.0
            : _animationController.value);
  }

  void cancelTimer() {
    _timer.cancel();
  }

  @override
  void initState() {
    super.initState();
    // Create the audio player.
    player = AudioPlayer();
    // Set the release mode to keep the source after playback has completed.
    player.setReleaseMode(ReleaseMode.stop);
    if (Hive.box<TeaTime>(BoxNames.timeBox).isNotEmpty) {
      baseTime = Hive.box<TeaTime>(BoxNames.timeBox).values.first.timeInSec;
    }
    setController(baseTime);
    startEverything(baseTime);
  }

  void controlEverything(int time) {
    if (_animationController.isAnimating) {
      _animationController.stop();
      _animationController.reset();
      cancelTimer();
      startEverything(time);
    }
  }

  @override
  void dispose() {
    cancelTimer();
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    final delay = ref.watch(delayProvider);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        floatingActionButton: ValueListenableBuilder(
          valueListenable: Hive.box<TeaTime>(BoxNames.timeBox).listenable(),
          builder: (BuildContext context, Box<TeaTime> box, Widget? child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton.large(
                  heroTag: 'add',
                  backgroundColor: Colors.transparent,
                  child: const Text(
                    '+',
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                  onPressed: () {
                    if (box.isEmpty) {
                      baseTime += 30;
                      box.add(TeaTime(timeInSec: baseTime));
                    } else {
                      baseTime += 30;
                      box.putAt(0, TeaTime(timeInSec: baseTime));
                    }
                    setState(() {});
                    controlEverything(baseTime);
                  },
                ),
                FloatingActionButton.large(
                  heroTag: 'minus',
                  backgroundColor: Colors.transparent,
                  child: const Text(
                    '-',
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                  onPressed: () {
                    if (box.isEmpty) {
                      if (baseTime > 0) {
                        baseTime -= 30;
                        box.add(TeaTime(timeInSec: baseTime));
                      }
                    } else {
                      if (baseTime > 0) {
                        baseTime -= 30;
                        box.putAt(0, TeaTime(timeInSec: baseTime));
                      }
                    }
                    // if (delay > 30) {
                    //   ref.read(delayProvider.notifier).state =
                    //       ref.read(delayProvider.notifier).state - 30;
                    // } else {
                    //   ref.read(delayProvider.notifier).state =
                    //       ref.read(delayProvider.notifier).state + 180;
                    // }
                    setState(() {});
                    controlEverything(baseTime);
                  },
                ),
              ],
            );
          },
        ),
        body: Stack(
          children: [
            buildCountdown(),
          ],
        ),
      ),
    );
  }

  Center buildCountdown() {
    return Center(
      child: AnimatedBuilder(
        builder: (BuildContext context, Widget? child) {
          return Stack(
            children: [
              SizedBox(
                width: screenWidth,
                height: screenHeight,
                child: Image.asset(
                  'assets/images/img.png',
                  fit: BoxFit.cover,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: _animationController.value * screenHeight,
                  child: Image.asset(
                    'assets/images/teaBack.png',
                    fit: BoxFit.cover,
                    width: screenWidth,
                    height: screenHeight,
                  ),
                ),
              ),
              Center(
                child: Text(
                  timerString,
                  style: const TextStyle(
                    fontSize: 100,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          );
        },
        animation: _animationController,
      ),
    );
  }
}

final delayProvider = StateProvider<int>((ref) {
  return 150;
});
