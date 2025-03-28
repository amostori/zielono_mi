
import 'package:hive_ce/hive.dart';

class TeaTime  extends HiveObject{
  final int timeInSec;

  TeaTime({required this.timeInSec});
}