import 'package:moor_ffi/moor_ffi.dart';
import 'package:news_feed/models/db/dao.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:moor/moor.dart';
import 'dart:io';
part 'database.g.dart';

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'news.db'));
    return VmDatabase(file);
  });
}

class ArticleRecords extends Table {
  TextColumn get title => text()();
  TextColumn get description => text()();
  TextColumn get url => text()();
  TextColumn get urlToImage => text()();
  TextColumn get publishDate => text()();
  TextColumn get content => text()();

  @override
  Set<Column> get primaryKey => {url};
}

@UseMoor(tables: [ArticleRecords], daos: [NewsDao])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}
