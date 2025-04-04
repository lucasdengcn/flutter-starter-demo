import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/service/snackbar_service.dart';
import '../../features/product/viewmodel/product_viewmodel.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    final productViewModel = context.read<ProductViewModel>();
    Future.microtask(
      () => productViewModel.loadProductDetails(widget.productId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => context.pushNamed('cart'),
          ),
        ],
      ),
      body: Consumer<ProductViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.errorMessage != null) {
            return Center(
              child: Text(
                'Error: ${viewModel.errorMessage}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          final product = viewModel.selectedProduct;
          if (product == null) {
            return const Center(child: Text('Product not found'));
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  product.imageUrl,
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        viewModel.formattedPrice,
                        style: Theme.of(
                          context,
                        ).textTheme.headlineSmall?.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Description',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(product.description),
                      const SizedBox(height: 16),
                      if (product.attributes != null) ...[
                        Text(
                          'Specifications',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        ...product.attributes!.entries.map(
                          (entry) => Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: Row(
                              children: [
                                Text(
                                  '${entry.key}:',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(entry.value.toString()),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () => viewModel.decrementQuantity(),
                          ),
                          Text(
                            viewModel.quantity.toString(),
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () => viewModel.incrementQuantity(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Consumer<ProductViewModel>(
        builder: (context, viewModel, child) {
          final product = viewModel.selectedProduct;
          if (product == null) return const SizedBox.shrink();

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _handleAddToCart,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(viewModel.stockStatus),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _handleAddToCart() async {
    final viewModel = context.read<ProductViewModel>();
    if (!viewModel.isInStock) return;
    await viewModel.addToCart();
    if (!mounted) return;
    if (viewModel.hasError) {
      SnackBarService.showError(context, viewModel.errorMessage!);
    } else if (viewModel.successMessage != null) {
      SnackBarService.showSuccess(context, viewModel.successMessage!);
    }
    viewModel.clearMessages();
  }
}
