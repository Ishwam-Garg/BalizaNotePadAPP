// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TodoStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TodoPosts on TodoStore, Store {
  final _$postsAtom = Atom(name: 'TodoStore.posts');

  @override
  ObservableList<Map<String, String>> get posts {
    _$postsAtom.reportRead();
    return super.posts;
  }

  @override
  set posts(ObservableList<Map<String, String>> value) {
    _$postsAtom.reportWrite(value, super.posts, () {
      super.posts = value;
    });
  }

  final _$TodoStoreActionController = ActionController(name: 'TodoStore');

  @override
  void set(Map<String, String> data) {
    final _$actionInfo =
        _$TodoStoreActionController.startAction(name: 'TodoStore.set');
    try {
      return super.set(data);
    } finally {
      _$TodoStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void delete(Map<String, String> data) {
    final _$actionInfo =
        _$TodoStoreActionController.startAction(name: 'TodoStore.delete');
    try {
      return super.delete(data);
    } finally {
      _$TodoStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void update(Map<String, String> data, int docId) {
    final _$actionInfo =
        _$TodoStoreActionController.startAction(name: 'TodoStore.update');
    try {
      return super.update(data, docId);
    } finally {
      _$TodoStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
posts: ${posts}
    ''';
  }
}
