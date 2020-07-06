import 'package:scoped_model/scoped_model.dart';
import 'ConnectedModel.dart';
import 'ConnectivityModel.dart';
import 'NutritionModel.dart';
import 'RecipeModel.dart';
import 'UserModel1.dart';
import 'UtilityModel.dart';
import 'authorModel.dart';

class MainModel extends Model
    with ConnectedModel,NutritionModel, UserModel, UtilityModel, RecipeModel, AuthorModel,ConnectivityModel{}
