// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_page_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppPageStore on _AppPageStoreBase, Store {
  late final _$appPageModelAtom =
      Atom(name: '_AppPageStoreBase.appPageModel', context: context);

  @override
  AppPageModel get appPageModel {
    _$appPageModelAtom.reportRead();
    return super.appPageModel;
  }

  @override
  set appPageModel(AppPageModel value) {
    _$appPageModelAtom.reportWrite(value, super.appPageModel, () {
      super.appPageModel = value;
    });
  }

  late final _$getPageModelsAsyncAction =
      AsyncAction('_AppPageStoreBase.getPageModels', context: context);

  @override
  Future<void> getPageModels() {
    return _$getPageModelsAsyncAction.run(() => super.getPageModels());
  }

  late final _$_AppPageStoreBaseActionController =
      ActionController(name: '_AppPageStoreBase', context: context);

  @override
  void setAppPageModel(AppPageModel appPage) {
    final _$actionInfo = _$_AppPageStoreBaseActionController.startAction(
        name: '_AppPageStoreBase.setAppPageModel');
    try {
      return super.setAppPageModel(appPage);
    } finally {
      _$_AppPageStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
appPageModel: ${appPageModel}
    ''';
  }
}
