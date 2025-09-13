import 'package:bookly/Features/home/data/repos_impl/home_repos_impl.dart';
import 'package:bookly/Features/home/domain/entities/book_entity.dart';
import 'package:bookly/Features/home/domain/use_case/fetch_newest_books_use_case.dart';
import 'package:bookly/Features/home/presentation/manager/fetch_featured_book_cubit/fetch_featured_book_cubit.dart';
import 'package:bookly/Features/home/presentation/manager/fetch_newest_book_cubit/fetch_newest_book_cubit.dart';
import 'package:bookly/constants.dart';
import 'package:bookly/core/functions/register_singleton_locator.dart';
import 'package:bookly/core/utils/app_router.dart';
import 'package:bookly/core/utils/simple_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(BookEntityAdapter());
  registerSingletonLocator();
  await Hive.openBox<BookEntity>(kFeaturedBox);
  await Hive.openBox<BookEntity>(kNewestBox);
  Bloc.observer = SimpleBlocObserver();
  runApp(const Bookly());
}

class Bookly extends StatelessWidget {
  const Bookly({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FetchFeaturedBookCubit>(
          create: (context) => FetchFeaturedBookCubit(
            FetchNewestBooksUseCase(
              getIt.get<HomeReposImpl>(),
            ),
          ),
        ),
        BlocProvider<FetchNewestBookCubit>(
          create: (context) => FetchNewestBookCubit(
            FetchNewestBooksUseCase(
              getIt.get<HomeReposImpl>(),
            ),
          ),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: kPrimaryColor,
          textTheme:
              GoogleFonts.montserratTextTheme(ThemeData.dark().textTheme),
        ),
      ),
    );
  }
}
