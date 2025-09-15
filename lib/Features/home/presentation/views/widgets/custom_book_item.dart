import 'package:bookly/Features/home/domain/entities/book_entity.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/assets.dart';

class CustomBookImage extends StatelessWidget {
  const CustomBookImage({Key? key, this.bookEntity}) : super(key: key);
  final BookEntity? bookEntity;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.6 / 4,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.red,
            image: DecorationImage(
                fit: BoxFit.fill,
                image:
                    NetworkImage(bookEntity?.image ?? AssetsData.testImage))),
      ),
    );
  }
}
