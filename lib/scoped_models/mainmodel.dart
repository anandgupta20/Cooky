import 'package:scoped_model/scoped_model.dart';

//import './products.dart';
import './usermodel.dart';

class MainModel extends Model with ConnectedProductsModel, UserModel, UtilityModel, RecipeModel {
}