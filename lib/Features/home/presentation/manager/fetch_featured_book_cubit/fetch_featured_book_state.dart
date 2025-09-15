import 'package:bookly/Features/home/domain/entities/book_entity.dart';

abstract class FetchFeaturedBookState {}

class FetchFeaturedBookInitial extends FetchFeaturedBookState {}

class FetchFeaturedBookLoading extends FetchFeaturedBookState {}

class FetchFeaturedBookPaginationLoading extends FetchFeaturedBookState {}

class FetchFeaturedBookSuccess extends FetchFeaturedBookState {
  final List<BookEntity> books;

  FetchFeaturedBookSuccess(this.books);
}

class FetchFeaturedBookFailure extends FetchFeaturedBookState {
  final String errMessage;

  FetchFeaturedBookFailure(this.errMessage);
}

class FetchFeaturedBookPaginationFailure extends FetchFeaturedBookState {
  final String errMessage;

  FetchFeaturedBookPaginationFailure(this.errMessage);
}
