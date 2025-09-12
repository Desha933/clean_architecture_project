part of 'fetch_newest_book_cubit.dart';

abstract class FetchNewestBookState {}

class FetchNewestBookInitial extends FetchNewestBookState {}

class FetchNewestBookLoading extends FetchNewestBookState {}

class FetchNewestBookSuccess extends FetchNewestBookState {
  final List<BookEntity> books;

  FetchNewestBookSuccess(this.books);
}

class FetchNewestBookFailure extends FetchNewestBookState {
  final String errMessage;

  FetchNewestBookFailure(this.errMessage);
}
