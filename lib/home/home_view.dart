import 'package:flutter/material.dart';
import 'package:primal_the_awakening/common/mvvm/view.dart';

abstract interface class HomeViewModel implements BaseViewModel {
  void openCampaigns();
  void openExpeditions();
  void openSettings();
  void chooseLanguage();
}

final class HomeView extends BaseView<HomeViewModel> {
  const HomeView({required super.viewModel, super.key});

  @override
  BaseViewState<HomeViewModel> createState() => _HomeViewState();
}

final class _HomeViewState extends BaseViewState<HomeViewModel> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
