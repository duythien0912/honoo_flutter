import 'package:honoo/Model/AppState.dart';
import 'package:honoo/Reducers/Actions/UserActions.dart';

User userReducer(User user, action) {

  if (action is ChangeProfilePic) {
    return User(
      name: user.name,
      contacts: user.contacts,
      profilePic: action.pic,
      profilePicURL: user.profilePicURL
    );
  } else

  if (action is ChangeContact) {
    var contacts = user.contacts;
    contacts[action.contact.item1] = action.contact.item2;

    return User(
        name: user.name,
        contacts: contacts,
        profilePic: user.profilePic,
        profilePicURL: user.profilePicURL
    );
  } else

  if (action is ChangeName) {
    return User(
        name: action.name,
        contacts: user.contacts,
        profilePic: user.profilePic,
        profilePicURL: user.profilePicURL
    );
  } else {
    return user;
  }

}