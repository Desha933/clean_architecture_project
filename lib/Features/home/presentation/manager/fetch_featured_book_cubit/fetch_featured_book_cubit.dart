import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:bookly/Features/home/domain/use_case/fetch_newest_books_use_case.dart';
import 'package:bookly/Features/home/presentation/manager/fetch_featured_book_cubit/fetch_featured_book_state.dart';

class FetchFeaturedBookCubit extends Cubit<FetchFeaturedBookState> {
  FetchFeaturedBookCubit(this.fetchNewestBooksUseCase)
      : super(FetchFeaturedBookInitial());
  FetchNewestBooksUseCase fetchNewestBooksUseCase;

  Future<void> fetchFeaturedBook({int pageNumber = 0}) async {
    if (pageNumber == 0) {
      emit(FetchFeaturedBookLoading());
    } else {
      emit(FetchFeaturedBookPaginationLoading());
    }

    var result = await fetchNewestBooksUseCase.call(pageNumber);

    result.fold((failure) {
      if (pageNumber == 0) {
        emit(FetchFeaturedBookFailure(failure.message));
      }
      emit(FetchFeaturedBookPaginationFailure(failure.message));
    }, (books) => emit(FetchFeaturedBookSuccess(books)));
  }
}
