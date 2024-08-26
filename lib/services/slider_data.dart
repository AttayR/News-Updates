import 'package:news_updates/models/slider_modal.dart';

List<sliderModal> getSlider(){
  List<sliderModal> slider =   [];
  sliderModal categoryModels = new sliderModal();
  categoryModels.name="Business";
  categoryModels.image="images/bussiness.jpg";
  slider.add(categoryModels);
  categoryModels = new sliderModal();

  categoryModels.name="General";
  categoryModels.image="images/general.jpg";
  slider.add(categoryModels);
  categoryModels = new sliderModal();

  categoryModels.name="Entertainment";
  categoryModels.image="images/entertainment.jpg";
  slider.add(categoryModels);
  categoryModels = new sliderModal();

  return slider;
}