import 'package:drift/drift.dart';
import 'dart:io';

import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';
// assuming that your file is called filename.dart. This will give an error at
// first, but it's needed for drift to know about the generated code
part 'database.g.dart';

// this will generate a table called "todos" for us. The rows of that table will
// be represented by a class called "Todo".
final _uuid = Uuid();


class Todos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 6, max: 32)();
  TextColumn get content => text().named('body')(); //named column adını değiştriyor
  IntColumn get category => integer().nullable()();
  IntColumn get uniqDeneme => integer().unique()();
  TextColumn get rastgeleTextUuid => text().clientDefault(() => _uuid.v4())();
}

// This will make drift generate a class called "Category" to represent a row in
// this table. By default, "Categorie" would have been used because it only
//strips away the trailing "s" in the table name.
@DataClassName('Category')
class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get description => text()();

  @override
  Set<Column> get primaryKey =>{id};
}


// @DriftDatabase(
//   // relative import for the drift file. Drift also supports `package:`
//   // imports
//   include: {'tables.drift'},
// )
@DriftDatabase(tables: [Todos, Categories])
class MyDatabase extends _$MyDatabase {
  // we tell the database where to store the data with this constructor
  MyDatabase() : super(_openConnection());

  // you should bump this number whenever you change or add a table definition.
  // Migrations are covered later in the documentation.
  @override
  int get schemaVersion => 1;

  Future<List<Todo>> get allTodoEntries => select(todos).get();

  // watches all todo entries in a given category. The stream will automatically
  // emit new items whenever the underlying data changes.
  Stream<List<Todo>> watchEntriesInCategory(Category c) {
    return (select(todos)..where((t) => t.category.equals(c.id))).watch();
  }

  Future<List<Todo>> limitTodos(int limit, {int? offset}) {
  return (select(todos)..limit(limit, offset: offset)).get();
  //tekbir row getir
   }

  Future<List<Todo>> sortEntriesAlphabetically() {
  return (select(todos)..orderBy([(t) => OrderingTerm(expression: t.title,mode: OrderingMode.desc)])).get();
      //itemleri sırala
   }

   Stream<Todo> entryById(int id) {
      return (select(todos)..where((t) => t.id.equals(id))).watchSingle();
      //tek bir rowu izle
   }


   Stream<List<String>> contentWithLongTitles() {
     //isBigger 
  final query = select(todos)
    ..where((t) => t.title.length.isBiggerOrEqualValue(16));

  return query
    .map((row) => row.content)
    .watch();
    }



    Future moveImportantTasksIntoCategory(Category target) {
  // for updates, we use the "companion" version of a generated class. This wraps the
  // fields in a "Value" type which can be set to be absent using "Value.absent()". This
  // allows us to separate between "SET category = NULL" (`category: Value(null)`) and not
  // updating the category at all: `category: Value.absent()`.

  //TodosCompanion zaten olan değerleri değiştirmez yeni eklenen yeri günceller sadece
  return (update(todos)
      ..where((t) => t.title.like('%Important%'))
    ).write(TodosCompanion(
      category: Value(target.id),
    ),
  );
}

Future updateTodo(Todo entry) {
  // using replace will update all fields from the entry that are not marked as a primary key.
  // it will also make sure that only the entry with the same primary key will be updated.
  // Here, this means that the row that has the same id as entry will be updated to reflect
  // the entry's title, content and category. As its where clause is set automatically, it
  // cannot be used together with where.
  return update(todos).replace(entry);
}

  Future feelingLazy() {
  // delete the oldest nine tasks
    return (delete(todos)..where((t) => t.id.isSmallerThanValue(10))).go();
 }


  Future<int> addTodo(TodosCompanion entry) {
    return into(todos).insert(entry);
 }



  Future<void> insertMultipleEntries() async{
  await batch((batch) {
    // functions in a batch don't have to be awaited - just
    // await the whole batch afterwards.
    batch.insertAll(todos, [
      TodosCompanion.insert(
        title: 'First entry',
        content: 'My content',
      ),
      TodosCompanion.insert(
        title: 'Another entry',
        content: 'More content',
        // columns that aren't required for inserts are still wrapped in a Value:
        category: Value(3),
      ),
      // ...
    ]);
  });
}

  Future<int> createOrUpdate(Todo todo){
    //todo gibi birşey varsa onu günceller yoksa yeni oluşturur
    return into(todos).insertOnConflictUpdate(todo);
  }


  Future<void> trackWord(String word) {
  return into(todos).insert(
    TodosCompanion.insert(title: "heyyo",content: "yeniContent"),
    onConflict: DoUpdate((old) => TodosCompanion.custom(title: old.title+const Constant("222"))),
  );
}


  Future<Todo> insertReturning()async{
    final row = await into(todos).insertReturning(TodosCompanion.insert(
         title: 'A todo entry',
         content: 'A description',
     ));

     return row;
  }



}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}