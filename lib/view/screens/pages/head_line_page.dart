import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// data
import 'package:news_feed/view_models/head_line_view_model.dart';

class HeadLinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HeadLineViewModel>(context, listen: false);

    if (!viewModel.isLoading && viewModel.articles.isEmpty) {
      // 非同期処理でエラーを回避。
      Future(() => viewModel.getHeadLines());
    }
    return SafeArea(
      child: Scaffold(
        // TODO:
        body: Container(
          child: Center(
            child: Text('HeadLinePage'),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh),
          onPressed: () => onRefresh(context),
        ),
      ),
    );
  }

  // TODO: 更新処理
  onRefresh(BuildContext context) async {
    final viewModel = context.read<HeadLineViewModel>();
    await viewModel.getHeadLines();
  }
}
