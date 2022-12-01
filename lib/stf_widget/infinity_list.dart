import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InfinityList extends StatelessWidget {
  final Widget Function(int) child;
  final int length;

  // final List<Object> data;
  final bool isLoadMore;
  final Function loadMoreItem;

  const InfinityList(
      {super.key,
      required this.child,
      required this.length,
      required this.isLoadMore,
      required this.loadMoreItem});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      scrollDirection: Axis.horizontal,
      itemCount: length + 1,
      itemBuilder: (context, index) {
        if (length == index) {
          return const SizedBox();
        }
        if (length == index - 1 && isLoadMore) {
          return Container(
            color: Colors.grey.shade100,
            height: context.isPhone ? 250 : 400,
            width: 240,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return child(index);
        }
      },
    );
  }
}

class ItemList extends StatelessWidget {
  final int index;
  final Widget child;

  const ItemList({super.key, required this.index, required this.child});

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
