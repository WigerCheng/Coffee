import 'package:coffee/model/result.dart';
import 'package:coffee/model/user.dart';
import 'package:coffee/util/dio_app.dart';
import 'package:dio/dio.dart';

Future<Result<User>> login(
    String account, String password, int userType) async {
  Response response = await appDio.post("/user/login", queryParameters: {
    "account": account,
    "password": password,
    "type": userType
  });
  Result<User> result =
      Result<User>.fromJson(response.data, (user) => User.fromJson(user));
  return result;
}

Future<Result<User>> addUser(User user) async =>
    await appDio.post("/user/addUser", data: user).then(
        (response) => Result.fromJson(response.data, (s) => User.fromJson(s)));

Future<Result<String>> deleteUser(int userId) async {
  Response response = await appDio
      .post("/user/deleteUser", queryParameters: {"userId": userId});
  Result<String> result =
      Result<String>.fromJson(response.data, (data) => data);
  return result;
}

Future<Result<List<User>>> getUserList() async {
  Response response = await appDio.get("/user/userList");
  Result<List<User>> result = Result.fromJson(response.data,
      (users) => (users as List).map((e) => User.fromJson(e)).toList());
  return result;
}

Future<Result<String>> updateUser(User user) async {
  Response response = await appDio.post("/user/updateUser", data: user);
  Result<String> result = Result.fromJson(response.data, (s) => s);
  return result;
}

Future<Result<User>> getUserById(int userId) async {
  Response response =
      await appDio.get("/user/getUser", queryParameters: {"userId": userId});
  Result<User> result = Result.fromJson(response.data, (s) => User.fromJson(s));
  return result;
}
