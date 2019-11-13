import 'dart:convert';

import 'package:redux/redux.dart';
import 'package:machinesetting_app/common/local/local_storage.dart';
import 'package:machinesetting_app/common/config/config.dart';
import 'package:machinesetting_app/models/user.dart';
import 'package:machinesetting_app/common/dao/dao_result.dart';
import 'package:machinesetting_app/redux/user_redux.dart';
import 'package:machinesetting_app/redux/locale_redux.dart';
import 'package:machinesetting_app/common/utils/common_utils.dart';
import 'package:machinesetting_app/common/net/result_data.dart';

class UserDao {
  static login(userName, password, store) async {
    String type = userName + ":" + password;
    var bytes = utf8.encode(type);
    var base64Str = base64.encode(bytes);
    if (Config.DEBUG) {
      print("base64Str login " + base64Str);
    }
    await LocalStorage.save(Config.USER_NAME_KEY, userName);
    await LocalStorage.save(Config.USER_BASIC_CODE, base64Str);
    var res =  new ResultData(
        "test",
        true,
        101);
    var resultData = null;
    if (res != null && res.result) {
      await LocalStorage.save(Config.PW_KEY, password);
//      store.dispatch(new UpdateUserAction(resultData.data));
    }
    return new DataResult(resultData, res.result);
  }
  static getUserInfoLocal() async {
    var userText = await LocalStorage.get(Config.USER_INFO);
    print(userText);
    if (userText != null) {
      var userMap = json.decode(userText);
      User user = User.fromJson(userMap);
      return new DataResult(user, true);
    } else {
      return new DataResult(null, false);
    }
  }

  static initUserInfo(Store store) async {

    var token = await LocalStorage.get(Config.TOKEN_KEY);
    var res = await getUserInfoLocal();
    if (res != null && res.result && token != null) {
      store.dispatch(UpdateUserAction(res.data));
    }
    ///读取主题
    String themeIndex = await LocalStorage.get(Config.THEME_COLOR);
    if (themeIndex != null && themeIndex.length != 0) {
      CommonUtils.pushTheme(store, int.parse(themeIndex));
    }

    ///切换语言
    String localeIndex = await LocalStorage.get(Config.LOCALE);
    if (localeIndex != null && localeIndex.length != 0) {
      CommonUtils.changeLocale(store, int.parse(localeIndex));
    } else {
      CommonUtils.curLocale = store.state.platformLocale;
      store.dispatch(RefreshLocaleAction(store.state.platformLocale));
    }

    return new DataResult(res.data, (res.result && (token != null)));
  }

}