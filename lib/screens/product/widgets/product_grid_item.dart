import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/network_image_with_error.dart';
import '../../../features/product/model/product_model.dart';
import '../../../features/product/viewmodel/product_viewmodel.dart';

class ProductGridItem extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductGridItem({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: NetworkImageWithError(
                imageUrl: product.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        product.name,
                        style: Theme.of(context).textTheme.titleMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Consumer<ProductViewModel>(
                      builder:
                          (context, viewModel, _) => Text(
                            viewModel.formatPrice(product.price),
                            style: Theme.of(
                              context,
                            ).textTheme.titleLarge?.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                    ),
                    const SizedBox(height: 4),
                    Consumer<ProductViewModel>(
                      builder:
                          (context, viewModel, _) => Text(
                            viewModel.getStockStatusText(product.stockQuantity),
                            style: TextStyle(
                              color: viewModel.getStockStatusColor(
                                product.stockQuantity,
                              ),
                              fontSize: 12,
                            ),
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
