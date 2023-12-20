import 'package:example/data.dart';
import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter_super_grid/flutter_super_grid.dart';

class SecondTab extends StatelessWidget {
  const SecondTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 200,
      child: FlatGridView(
        data: data,
        renderItem: (itemData) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(
                15.0), // Ajusta el radio según sea necesario
            child: CachedNetworkImage(
              imageUrl: itemData,
              placeholder: (context, url) =>
                  const CircularProgressIndicator(), // Puedes personalizar el indicador de carga
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit
                  .cover, // Ajusta el modo de ajuste de la imagen según sea necesario
            ),
          );
        },
        itemSize: 100.0,
        itemsPerRow: 3,
        gridViewWidth: 150,
        gridViewHeight: 300,
        style: const FlatGridViewStyle(
          color: Colors.green,
          padding: EdgeInsets.all(16.0),
          gridViewPadding: EdgeInsets.all(8.0),
        ),
        footerWidget: Container(
          height: 100,
          width: 420,
          color: Colors.red,
          child: const Row(
            children: [
              Icon(
                Icons.abc,
                color: Colors.white,
              ),
              Text(
                "Foot Render Widget",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
        verticalSpacing: 10.0,
        horizontalSpacing: 10.0,
        horizontal: true,
        invertedRow: false,
        onPressed: (index) {
          // Handle item tap
        },
      ),
    );
  }
}
