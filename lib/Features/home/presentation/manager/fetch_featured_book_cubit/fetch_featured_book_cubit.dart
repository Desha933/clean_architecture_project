import 'package:bloc/bloc.dart';
import 'package:bookly/Features/home/domain/use_case/fetch_newest_books_use_case.dart';
import 'package:bookly/Features/home/presentation/manager/fetch_featured_book_cubit/fetch_featured_book_state.dart';

class FetchFeaturedBookCubit extends Cubit<FetchFeaturedBookState> {
  FetchFeaturedBookCubit(this.fetchNewestBooksUseCase)
      : super(FetchFeaturedBookInitial());
  FetchNewestBooksUseCase fetchNewestBooksUseCase;

  Future<void> fetchFeaturedBook() async {
    emit(FetchFeaturedBookLoading());

    var result = await fetchNewestBooksUseCase.call();

    result.fold((failure) => emit(FetchFeaturedBookFailure(failure.message)),
        (books) => emit(FetchFeaturedBookSuccess(books)));
  }
}
