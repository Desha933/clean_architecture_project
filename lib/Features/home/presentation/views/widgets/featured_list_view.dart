import 'package:bookly/Features/home/domain/entities/book_entity.dart';
import 'package:bookly/Features/home/presentation/manager/fetch_featured_book_cubit/fetch_featured_book_cubit.dart';
import 'package:bookly/core/shared_widgets/custom_fading_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'custom_book_item.dart';

class FeaturedBooksListView extends StatefulWidget {
  const FeaturedBooksListView({Key? key, required this.books})
      : super(key: key);
  final List<BookEntity> books;

  @override
  State<FeaturedBooksListView> createState() => _FeaturedBooksListViewState();
}

class _FeaturedBooksListViewState extends State<FeaturedBooksListView> {
  late ScrollController _scrollcontroller;
  int nextpage = 1;
  bool isloading = false;
  @override
  void initState() {
    _scrollcontroller = ScrollController();
    _scrollcontroller.addListener(_scrollListener);
  }

  void _scrollListener() {
    var currentPosition = _scrollcontroller.position.pixels;
    var maxScrollLength = _scrollcontroller.position.maxScrollExtent;
    if (currentPosition >= .7 * maxScrollLength) {
      if (isloading == false) {
        isloading = true;
        BlocProvider.of<FetchFeaturedBookCubit>(context)
            .fetchFeaturedBook(pageNumber: nextpage++);
        isloading = false;
      }
    }
  }

  void dispose() {
    _scrollcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .3,
      child: ListView.builder(
          controller: _scrollcontroller,
          itemCount: widget.books.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: CustomBookImage(
                bookEntity: widget.books[index],
              ),
            );
          }),
    );
  }
}

class FeaturedListViewLoadingIndicator extends StatelessWidget {
  const FeaturedListViewLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomFadingAnimation(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * .3,
        child: ListView.builder(
            itemCount: 10,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: AspectRatio(
                  aspectRatio: 2.6 / 4,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.grey,
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
