import '../models/category_model.dart';

List<CategoryModel> getCategories(){
  List<CategoryModel> category= [];
  CategoryModel categoryModel= CategoryModel();

  categoryModel.categoryName='Business';
  categoryModel.image='images/business.jpg';
  category.add(categoryModel);
  categoryModel= CategoryModel();

  categoryModel.categoryName='Entertainment';
  categoryModel.image='images/entertainment.jpg';
  category.add(categoryModel);
  categoryModel= CategoryModel();

  categoryModel.categoryName='General';
  categoryModel.image='images/general.jpg';
  category.add(categoryModel);
  categoryModel= CategoryModel();

  categoryModel.categoryName='Health';
  categoryModel.image='images/health.jpg';
  category.add(categoryModel);
  categoryModel= CategoryModel();

  categoryModel.categoryName='Sport';
  categoryModel.image='images/sport.jpg';
  category.add(categoryModel);
  categoryModel= CategoryModel();

  // categoryModel.categoryName='Science';
  // categoryModel.image='images/science.jpg';
  // category.add(categoryModel);
  // categoryModel= CategoryModel();
  //
  // categoryModel.categoryName='Building';
  // categoryModel.image='images/building.jpg';
  // category.add(categoryModel);
  // categoryModel= CategoryModel();


  return category;
}