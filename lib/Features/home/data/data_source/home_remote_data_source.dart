import 'package:bookly/Features/home/data/models/book_model/book_model.dart';
import 'package:bookly/Features/home/domain/entities/book_entity.dart';
import 'package:bookly/constants.dart';
import 'package:bookly/core/functions/save_data_to_hive.dart';
import 'package:bookly/core/utils/api_service.dart';
import 'package:dartz/dartz_unsafe.dart';
import 'package:hive_flutter/adapters.dart';

abstract class HomeRemoteDataSource {
  Future<List<BookEntity>> fetchFeaturedBooks({int pageNumber = 0});
  Future<List<BookEntity>> fetchNewestBooks();
}

class HomeRemoteDataSourceImplement extends HomeRemoteDataSource {
  final ApiService apiService;

  HomeRemoteDataSourceImplement(this.apiService);

  @override
  Future<List<BookEntity>> fetchFeaturedBooks({int pageNumber = 0}) async {
    var data = await apiService.get(
        endpoint:
            'volumes?Filtering=free-ebooks&q=programming&startIndex=${pageNumber * 10}');
    List<BookEntity> books = convertBookModelToBookEntity(data);

    saveDataToHiveBox(books, kFeaturedBox);
    return books;
  }

  @override
  Future<List<BookEntity>> fetchNewestBooks() async {
    var data = await apiService.get(
        endpoint: 'volumes?Filtering=free-ebooks&Sorting=newest&q=programming');
    List<BookEntity> books = convertBookModelToBookEntity(data);
    saveDataToHiveBox(books, kNewestBox);
    return books;
  }

  // methods

  List<BookEntity> convertBookModelToBookEntity(Map<String, dynamic> data) {
    List<BookEntity> books = [];
    for (var bookMap in data['items']) {
      books.add(BookModel.fromJson(bookMap));
    }
    return books;
  }
}
