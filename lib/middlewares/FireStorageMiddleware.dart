import 'package:honoo/Model/AppState.dart';
import 'package:honoo/Reducers/Actions/HonooActions.dart';
import 'package:honoo/Reducers/Actions/HonooListActions.dart';
import 'package:honoo/Reducers/Actions/UserActions.dart';
import 'package:redux/redux.dart';
import 'package:firebase_storage/firebase_storage.dart';


Middleware<AppState> createFireStorageMiddleware() {

  FirebaseStorage storage = FirebaseStorage.instance;

  return (Store<AppState> store, action, NextDispatcher next ){

    if (action is SaveHonoo) {
      String imageName =  action.honoo.photoURL ?? DateTime.now().millisecondsSinceEpoch.toString() + ".png";
      var reference = storage.ref().child('honoo').child(imageName);
      if (action.honoo.photoURL == null) action.honoo.photoURL = imageName;
      reference.putFile(action.honoo.photo);

    } else if (action is ChangeProfilePic) {
      String imageName =  store.state.userData.profilePicURL ?? DateTime.now().millisecondsSinceEpoch.toString() + ".png";
      var reference = storage.ref().child('profilePics').child(imageName);
      if ( store.state.userData.profilePicURL == null ) store.state.userData.profilePicURL = imageName;
      reference.putFile(action.pic);
    }
    next(action);
  };


}
