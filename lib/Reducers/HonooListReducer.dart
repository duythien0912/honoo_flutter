
import 'package:honoo/Model/Honoo.dart';
import 'package:honoo/Reducers/Actions/HonooListActions.dart';

List<Honoo> honooListReducer(List<Honoo> currentList, action) {

  if (action is SaveHonoo) {

    currentList.add(action.honoo);

    return new List.from(currentList);

  } else if (action is RemoveHonoo) {

    currentList.removeWhere((item) => item == action.honoo);

    return new List.from(currentList);

  } else {

    return currentList;

  }
}
