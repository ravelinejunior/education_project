import 'package:education_project/core/common/app/providers/tab_navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersistentView extends StatefulWidget {
  const PersistentView({super.key, this.body});

  final Widget? body;

  @override
  State<PersistentView> createState() => _PersistentViewState();
}

/// A state class that manages the state of a [PersistentView] widget.
///
/// This class extends [State<PersistentView>] and mixes in 
/// [AutomaticKeepAliveClientMixin],
/// which allows it to keep the widget alive even when it's not visible.
///   /// Builds the widget tree for the [PersistentView] widget.
///
/// ignore: comment_references
/// Returns either the [body] widget passed to [PersistentView] or the current
/// page's child widget from the [TabNavigator].
class _PersistentViewState extends State<PersistentView> 
with AutomaticKeepAliveClientMixin {

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.body ?? context.watch<TabNavigator>().currentPage.child;
  }

  /// Returns a boolean indicating whether the widget should be kept alive.
  ///
  /// In this case, it always returns `true`, which means the widget will not be
  /// garbage collected even when it's not visible.
  @override
  bool get wantKeepAlive => true;
}
