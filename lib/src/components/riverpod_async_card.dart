import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:hugeicons/hugeicons.dart';

class RiverpodAsyncCard<T> extends ConsumerWidget {
  const RiverpodAsyncCard({
    super.key,
    required this.provider,
    required this.builder,
    this.skipLoadingOnRefresh = false,
    String? subject,
    String loadingTitleText = 'Loading...',
    String errorTitleText = 'Failed to load data',
  }) : loadingTitleText = subject == null
           ? loadingTitleText
           : 'Loading $subject...',
       errorTitleText = subject == null
           ? errorTitleText
           : 'Failed to load $subject...';

  final ProviderBase<AsyncValue<T>> provider;
  final Widget Function(T entity) builder;
  final bool skipLoadingOnRefresh;
  final String loadingTitleText;
  final String errorTitleText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<T> asyncThing = ref.watch(provider);

    return switch (asyncThing) {
      AsyncLoading() => _buildLoading(),
      AsyncError(:final error) => _buildError(context, ref, error: error),
      AsyncData(:final value) => builder(value),
    };
  }

  Widget _buildLoading() {
    return Card(
      child: ListTile(
        title: Text(loadingTitleText),
        trailing: SizedBox(
          width: 30,
          height: 30,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget _buildError(
    BuildContext context,
    WidgetRef ref, {
    required Object error,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card.outlined(
      color: colorScheme.error,
      child: Column(
        children: [
          ListTile(
            iconColor: colorScheme.onError,
            textColor: colorScheme.onError,
            title: Text(errorTitleText),
            subtitle: Text('Tap to reload'),
            leading: HugeIcon(
              icon: HugeIcons.strokeRoundedAlertSquare,
              size: 30,
            ),
            trailing: IconButton(
              onPressed: () => ref.invalidate(provider),
              icon: Icon(Icons.refresh_rounded, size: 30),
            ),
          ),
        ],
      ),
    );
  }
}
