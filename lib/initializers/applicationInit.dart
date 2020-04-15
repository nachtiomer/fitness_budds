import 'package:fitnessbudds/DAL/applicationStorage.dart';

/// this is where all the initializers are called, migrations, configurations server  requests and more....
/// for now it returns a boolean which tells if the application can load or not;
Future<bool> initApplication() async {
  ApplicationStorage storage = ApplicationStorage();
  await storage.initStorage();

  return true;
}
