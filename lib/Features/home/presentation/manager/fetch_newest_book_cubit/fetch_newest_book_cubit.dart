import 'package:bloc/bloc.dart';
import 'package:bookly/Features/home/domain/entities/book_entity.dart';
import 'package:bookly/Features/home/domain/use_case/fetch_newest_books_use_case.dart';
part 'fetch_newest_book_state.dart';

class FetchNewestBookCubit extends Cubit<FetchNewestBookState> {
  FetchNewestBookCubit(this.fetchNewestBooksUseCase)
      : super(FetchNewestBookInitial());
  final FetchNewestBooksUseCase fetchNewestBooksUseCase;

  Future<void> fetchNewestBooks() async {
    emit(FetchNewestBookLoading());
    var result = await fetchNewestBooksUseCase.call();
    result.fold((failure) => emit(FetchNewestBookFailure(failure.message)),
        (books) => emit(FetchNewestBookSuccess(books)));
  }
}
