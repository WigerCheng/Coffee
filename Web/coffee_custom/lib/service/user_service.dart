import 'package:coffee_custom/pojo/result.dart';
import 'package:coffee_custom/pojo/user.dart';
import 'package:coffee_custom/util/dio_app.dart';

Future<Result<User>> login(
        String account, String password, int userType) async =>
    await appDio.post("/user/login", queryParameters: {
      "account": account,
      "password": password,
      "type": userType
    }).then((response) =>
        Result<User>.fromJson(response.data, (user) => User.fromJson(user)));

Future<Result<User>> addUser(User user) async =>
    await appDio.post("/user/addUser", data: user).then(
        (response) => Result.fromJson(response.data, (s) => User.fromJson(s)));

Future<Result<String>> updateUser(User user) async => await appDio
    .post("/user/updateUser", data: user)
    .then((response) => Result.fromJson(response.data, (s) => s));

Future<Result<User>> loginHelper(User user) async =>
    await login(user.account, user.password, user.type);

Future<Result<User>> getUserById(int userId) async =>
    await appDio.get("/user/getUser", queryParameters: {"userId": userId}).then(
        (response) => Result<User>.fromJson(
            response.data, (user) => User.fromJson(user)));