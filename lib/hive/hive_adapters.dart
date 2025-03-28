import 'package:hive_ce/hive.dart';
import 'package:zielone_japko/src/features/home/hive_helper/tea_time.dart';


part 'hive_adapters.g.dart';

@GenerateAdapters([
  AdapterSpec<TeaTime>(),
])

class HiveAdapters {}