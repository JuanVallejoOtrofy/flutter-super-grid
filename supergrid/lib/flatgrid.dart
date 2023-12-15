library supergrid;

import 'package:flutter/material.dart';

enum TitleAlignment {
  start,
  center,
  end,
}

/// A widget that displays a grid of sections.
class FlatGridView extends StatefulWidget {
  /// Creates a `FlatGridView`.
  const FlatGridView({
    super.key,
    required this.color,
    required this.itemWidth,
    required this.itemHeight,
    this.verticalSpacing = 10,
    this.horizontalSpacing = 10,
    required this.padding,
    required this.data,
    required this.renderItem,
    required this.itemCount,
    this.boxDecoration = const BoxDecoration(),
    required this.onPressed,
    this.gridViewPadding = const EdgeInsets.all(8.0),
    this.titleAlignment = TitleAlignment.start,
    this.titleBackgroundColor = Colors.transparent,
    this.titlePadding = const EdgeInsets.all(8.0),
    this.titleTextStyle = const TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 16,
      color: Colors.black,
    ),
    this.invertedRow = false,
    this.horizontal = false,
  });

  /// The background color of the grid container.
  final Color color;

  /// The width of each grid item.
  final double itemWidth;

  /// The height of each grid item.
  final double itemHeight;

  /// The spacing between grid items vertically.
  final double verticalSpacing;

  /// The spacing between grid items horizontally.
  final double horizontalSpacing;

  /// The padding around the grid view.
  final EdgeInsets gridViewPadding;

  /// The padding around each section.
  final EdgeInsets padding;

  /// The sections to display in the grid.
  final List data;

  /// The function that renders each item in the grid.
  final Widget Function(Object data) renderItem;

  /// The total number of items in the grid.
  final int itemCount;

  /// The decoration for each grid item.
  final BoxDecoration boxDecoration;

  /// The callback function when an item is pressed.
  final void Function(int index)? onPressed;

  /// The padding around the title.
  final EdgeInsets titlePadding;

  /// The alignment of the title.
  final TitleAlignment titleAlignment;

  /// The background color of the title container.
  final Color titleBackgroundColor;

  /// The style of the title.
  final TextStyle titleTextStyle;

  /// Whether to invert the row.
  final bool invertedRow;

  /// Whether the grid view is horizontal.
  final bool horizontal;

  @override
  State<FlatGridView> createState() => _FlatGridViewState();
}

class _FlatGridViewState extends State<FlatGridView> {
  List<bool> likedStates = [];

  @override
  void initState() {
    super.initState();
    likedStates = List<bool>.filled(widget.itemCount, false);
  }

  Widget getTitleWidget(String title) {
    return Container(
      color: widget.titleBackgroundColor,
      width: double.infinity, // Full width
      padding: widget.titlePadding,
      child: Align(
        alignment: {
          TitleAlignment.start: Alignment.centerLeft,
          TitleAlignment.center: Alignment.center,
          TitleAlignment.end: Alignment.centerRight,
        }[widget.titleAlignment]!,
        child: Text(
          title,
          style: widget.titleTextStyle,
        ),
      ),
    );
  }

  final data = section['data'] as List;
  final dataInverted = data.reversed.toList();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: Container(
        color: widget.color,
        child: Stack(
          children: [
            Visibility(
              visible: widget.sections.isEmpty,
              child: const Center(child: Text('No items')),
            ),
            Visibility(
              visible: widget.sections.isNotEmpty,
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: widget.itemWidth,
                  childAspectRatio: widget.itemWidth / widget.itemHeight,
                  crossAxisSpacing: widget.horizontalSpacing,
                  mainAxisSpacing: widget.verticalSpacing,
                ),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final itemData =
                      widget.invertedRow ? dataInverted[index] : data[index];
                  return InkWell(
                    onTap: () {
                      if (widget.onPressed != null) {
                        widget.onPressed!(index);
                      }
                    },
                    child: widget.renderItem(itemData),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
