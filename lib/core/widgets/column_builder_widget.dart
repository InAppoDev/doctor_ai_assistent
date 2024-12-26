import 'package:flutter/material.dart';

class ColumnBuilder extends StatelessWidget {
  final IndexedWidgetBuilder itemBuilder;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final VerticalDirection verticalDirection;
  final int itemCount;
  final bool? isReverse;

  const ColumnBuilder({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.verticalDirection = VerticalDirection.down,
    this.isReverse = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      mainAxisAlignment: mainAxisAlignment,
      verticalDirection: verticalDirection,
      children: isReverse!
          ? List.generate(
              itemCount,
              (index) => itemBuilder(context, index),
              growable: false,
            ).toList().reversed.toList()
          : List.generate(
              itemCount,
              (index) => itemBuilder(context, index),
              growable: false,
            ).toList(),
    );
  }
}