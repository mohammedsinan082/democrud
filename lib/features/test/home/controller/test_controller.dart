import 'package:democrud/features/test/home/repository/test_repository.dart';
import 'package:democrud/model/riverpod_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../model/riverpod_category_model.dart';

final testControllerProvider = StateNotifierProvider<TestController,bool>((ref) {
  return TestController(repository:ref.read(testRepositoryProvider));
});

final viewUserProvider = StreamProvider.autoDispose((ref) {
  return ref.watch(testControllerProvider.notifier).viewUser();
});

final viewCategoryProvider= StreamProvider.autoDispose((ref) {
  return ref.watch(testControllerProvider.notifier).getRiverpodCategory();
});


class TestController extends StateNotifier<bool>{
  TestRepository _repository;    //same as String name
  TestController({required TestRepository repository}):_repository=repository,super(false);

  addUser({required String name,required String age,required String image,required CategoryModelRiverpod category}){
    _repository.addUser(name: name,image: image,age: age,category: category);
  }

  Stream<List<RiverpodModel>> viewUser(){
    return _repository.viewUser();
  }


  updateUser({required RiverpodModel riverpodModel,required String name,required String age,required String image,required String category}){
    _repository.updateUser(riverpodModel: riverpodModel, name: name, age: age, image: image,category: category);
  }

  Stream<List<CategoryModelRiverpod>> getRiverpodCategory() {
    return _repository.getRiverpodCategory();
  }
}