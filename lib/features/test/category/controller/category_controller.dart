import 'package:democrud/features/test/home/repository/test_repository.dart';
import 'package:democrud/model/riverpod_category_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/category_repository.dart';


final CategoryControllerProvider = StateNotifierProvider<CategoryController,bool>((ref) {
  return CategoryController(repository: ref.read(categoryRepositoryProvider));
});

final viewCategoryProvider = StreamProvider.autoDispose((ref) {
  return ref.watch(CategoryControllerProvider.notifier).viewCategory();
});


class CategoryController extends StateNotifier<bool>{
  CategoryRepository _repository;
  CategoryController({required CategoryRepository repository}):_repository=repository,super(false);


  addCategory({required String gender}){
    _repository.addCategory(gender:gender);
  }

  Stream<List<CategoryModelRiverpod>> viewCategory(){
    return _repository.viewCategory();
}

  updateCategory({required CategoryModelRiverpod categoryModelRiverpod,required String gender}){
    return _repository.updateCategory(categoryModelRiverpod: categoryModelRiverpod, gender: gender);
  }

}