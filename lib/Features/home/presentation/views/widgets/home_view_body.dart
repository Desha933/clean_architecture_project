import 'package:bookly/Features/home/presentation/manager/fetch_featured_book_cubit/fetch_featured_book_cubit.dart';
import 'package:bookly/Features/home/presentation/manager/fetch_featured_book_cubit/fetch_featured_book_state.dart';
import 'package:bookly/Features/home/presentation/views/widgets/bloc_builder_featured_books_list.dart';
import 'package:bookly/constants.dart';
import 'package:bookly/core/utils/assets.dart';
import 'package:bookly/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'best_seller_list_view.dart';
import 'best_seller_list_view_item.dart';
import 'custom_app_bar.dart';
import 'featured_list_view.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  child: CustomAppBar()),
              const BlocBuilderFeaturedBooks(),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Best Seller',
                  style: Styles.textStyle18,
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        const SliverFillRemaining(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: BestSellerListView(),
          ),
        ),
      ],
    );
  }
}
