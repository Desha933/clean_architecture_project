import 'package:bookly/Features/home/domain/entities/book_entity.dart';
import 'package:bookly/Features/home/presentation/manager/fetch_featured_book_cubit/fetch_featured_book_cubit.dart';
import 'package:bookly/Features/home/presentation/manager/fetch_featured_book_cubit/fetch_featured_book_state.dart';
import 'package:bookly/Features/home/presentation/views/widgets/featured_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocBuilderFeaturedBooks extends StatefulWidget {
  const BlocBuilderFeaturedBooks({
    super.key,
  });

  @override
  State<BlocBuilderFeaturedBooks> createState() =>
      _BlocBuilderFeaturedBooksState();
}

class _BlocBuilderFeaturedBooksState extends State<BlocBuilderFeaturedBooks> {
  List<BookEntity> books = [];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FetchFeaturedBookCubit, FetchFeaturedBookState>(
      listener: (context, state) {
        if (state is FetchFeaturedBookSuccess) {
          books.addAll(state.books);
        }

        if (state is FetchFeaturedBookPaginationFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errMessage)));
        }
      },
      builder: (context, state) {
        if (state is FetchFeaturedBookSuccess ||
            state is FetchFeaturedBookPaginationFailure ||
            state is FetchFeaturedBookPaginationLoading) {
          return FeaturedBooksListView(
            books: books,
          );
        } else if (state is FetchFeaturedBookFailure) {
          return Text('${state.errMessage}');
        } else {
          return const FeaturedListViewLoadingIndicator();
        }
      },
    );
  }
}
