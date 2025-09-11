import 'package:bookly/Features/home/domain/entities/book_entity.dart';
import 'package:bookly/Features/home/domain/repos/home_repo.dart';
import 'package:bookly/core/errors/failure.dart';
import 'package:bookly/core/use_case/use_case.dart';
import 'package:dartz/dartz.dart';

class FetchFeaturedBooksUseCase extends UseCase<List<BookEntity>, NoParameter> {
  final HomeRepo homeRepo;

  FetchFeaturedBooksUseCase(this.homeRepo);

  @override
  Future<Either<Failure, List<BookEntity>>> call([NoParameter? param]) async {
    // TODO: implement call
    return await homeRepo.fetchFeaturedBooks();
  }

  // Future<Either<Failure, List<BookEntity>>> call() {
  //   // check permission
  //   return homeRepo.fetchFeaturedBooks();
  // }
}
