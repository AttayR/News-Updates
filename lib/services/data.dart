import 'package:news_updates/models/category_models.dart';

List<CategoryModels> getCategories(){
  List<CategoryModels> category =   [];
  CategoryModels categoryModels = new CategoryModels();
  categoryModels.categoryName="Business";
  categoryModels.image="images/bussiness.jpg";
  category.add(categoryModels);
  categoryModels = new CategoryModels();

  categoryModels.categoryName="General";
  categoryModels.image="images/general.jpg";
  category.add(categoryModels);
  categoryModels = new CategoryModels();

  categoryModels.categoryName="Entertainment";
  categoryModels.image="images/entertainment.jpg";
  category.add(categoryModels);
  categoryModels = new CategoryModels();

  categoryModels.categoryName="Health";
  categoryModels.image="images/health.jpg";
  category.add(categoryModels);
  categoryModels = new CategoryModels();

  categoryModels.categoryName="Sport";
  categoryModels.image="images/sports.jpg";
  category.add(categoryModels);
  categoryModels = new CategoryModels();

  return category;
}