import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos_apps/core/components/buttons.dart';
import 'package:flutter_pos_apps/core/components/spaces.dart';
import 'package:flutter_pos_apps/core/constants/colors.dart';
import 'package:flutter_pos_apps/core/constants/variables.dart';
import 'package:flutter_pos_apps/data/models/response/product_response_model.dart';

class MenuProductItem extends StatelessWidget {
  final Product data;
  const MenuProductItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: AppColors.blueLight),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            child: CachedNetworkImage(
              imageUrl: '${Variables.imageBaseUrl}${data.image}',
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
              width: 80,
              height: 80,
              errorWidget: (context, url, error) => const Icon(
                Icons.food_bank_outlined,
                size: 80,
              ),
            ),
          ),
          const SpaceWidth(22.0),
          Flexible(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.name,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              const SpaceHeight(5.0),
              Text(
                data.category,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
              const SpaceHeight(10.0),
              Row(
                children: [
                  Flexible(
                    child: Button.outlined(
                      onPressed: () {
                        showDialog(
                          context: context,
                          //backgroundColor: AppColors.white,
                          builder: (context) {
                            //container for product detail
                            return AlertDialog(
                              contentPadding: const EdgeInsets.all(16.0),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        data.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: const Icon(Icons.close),
                                      ),
                                    ],
                                  ),
                                  const SpaceHeight(10.0),
                                  ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10.0)),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          '${Variables.imageBaseUrl}${data.image}',
                                      placeholder: (context, url) =>
                                          const CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          const Icon(
                                        Icons.food_bank_outlined,
                                        size: 250,
                                      ),
                                      width: 250,
                                    ),
                                  ),
                                  const SpaceHeight(10.0),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Kategori :'),
                                      Text(
                                        data.category,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SpaceHeight(10.0),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Harga :'),
                                      Text(
                                        data.price.toString(),
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SpaceHeight(10.0),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Stok :'),
                                      Text(
                                        data.stock.toString(),
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SpaceHeight(10.0),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      label: 'Detail',
                      fontSize: 11.0,
                      height: 31,
                    ),
                  ),
                  const SpaceWidth(6.0),
                  Flexible(
                    child: Button.outlined(
                      onPressed: () {
                        // context.push(EditProductPage(data: data));
                      },
                      label: 'Ubah Produk',
                      fontSize: 11.0,
                      height: 31,
                    ),
                  )
                ],
              )
            ],
          ))
        ],
      ),
    );
  }
}
