import 'package:bookly/Features/home/domain/entities/book_entity.dart';
import 'package:bookly/constants.dart';
import 'package:hive_flutter/adapters.dart';

abstract class HomeLocalDataSource {
  List<BookEntity> fetchFeaturedBooks({int pageNumber = 0});
  List<BookEntity> fetchNewestBooks();
}

class HomeLocalDataSourceImplement extends HomeLocalDataSource {
  @override
  List<BookEntity> fetchFeaturedBooks({int pageNumber = 0}) {
    var startIndex = pageNumber * 10;
    var endIndex = (pageNumber + 1) * 10;

    var box = Hive.box<BookEntity>(kFeaturedBox);
    int lenght = box.values.length;
    if (startIndex >= lenght || endIndex > lenght) {
      return [];
    }
    return box.values.toList().sublist(startIndex, endIndex);
  }

  @override
  List<BookEntity> fetchNewestBooks() {
    var box = Hive.box<BookEntity>(kFeaturedBox);
    return box.values.toList();
  }
}
