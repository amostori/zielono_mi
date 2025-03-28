import 'package:zielone_japko/hive/hive_registrar.g.dart';
import 'package:zielone_japko/src/features/home/hive_helper/tea_time.dart';
import 'package:hive_ce_flutter/adapters.dart';


import '../../../utils/constants.dart';

class TeaTimeBox{

  Future<void> initTeaTimeBox() async {
    await Hive.initFlutter();
    Hive.registerAdapters();
    await Hive.openBox<TeaTime>(BoxNames.timeBox);
  }
}