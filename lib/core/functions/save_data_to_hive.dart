import 'package:bookly/Features/home/domain/entities/book_entity.dart';
import 'package:hive/hive.dart';

void saveDataToHiveBox(List<BookEntity> books, String boxName) {
  var box = Hive.box<BookEntity>(boxName);
  box.addAll(books);
}
