import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:primal_the_awakening/common/context_bridge.dart';

abstract mixin class BaseViewModel = Object with ContextBridge;

abstract base class BaseView<VM extends BaseViewModel> extends StatefulWidget {
  const BaseView({
    required this.viewModel,
    super.key,
  });

  final VM viewModel;

  @override
  BaseViewState<VM> createState();
}

abstract base class BaseViewState<VM extends BaseViewModel>
    extends State<BaseView<VM>> with ContextBridgeStateMixin<BaseView<VM>> {
  @protected
  @override
  @nonVirtual
  Iterable<ContextBridge> get bridges => [viewModel];

  @protected
  @nonVirtual
  VM get viewModel => widget.viewModel;
}
