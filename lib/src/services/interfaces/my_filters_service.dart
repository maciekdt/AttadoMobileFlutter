import 'package:attado_mobile/src/models/data_models/filters/my_filter.dart';

abstract class MyFiltersService {
  Future<List<MyFilter>> getMyFilters();
}
