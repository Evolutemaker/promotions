import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'database_config.g.dart';

class Promotions extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  TextColumn get shortDesc => text().named('short_desc')();
  TextColumn get imageUrl => text().named('image_url')();
  DateTimeColumn get startDate => dateTime().named('start_date')();
  DateTimeColumn get endDate => dateTime().named('end_date')();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [Promotions])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'promotions_database',
      native: const DriftNativeOptions(
        shareAcrossIsolates: true,
      ),
    );
  }
}