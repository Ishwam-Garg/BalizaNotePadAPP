import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'TodoStore.g.dart';

class TodoPosts = TodoStore with _$TodoPosts;

abstract class TodoStore with Store{

  @observable
  ObservableList<Map<String,String>> posts = ObservableList();

  @action
  void set(Map<String,String> data){
    posts.add(data);
    //_data = data;
  }

  @action
  void delete(Map<String,String> data){
    posts.remove(data);
  }

  @action
  void update(Map<String,String> data,int docId)
  {
    List<Map<String,String>> newData = [data];

    posts[docId] = data;

    //posts.replaceRange(docId, docId+1, newData);
  }





}