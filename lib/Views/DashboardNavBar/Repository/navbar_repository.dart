import 'dart:io';

import 'package:cricket_poc/lib_exports.dart';
import 'package:flutter/foundation.dart';

final navbarRepositoryPr = Provider<NavBarRepository>(
  (ref) => NavBarRepository(
    homeServices: ref.read(homeServicesPr),
    profileServices: ref.read(profileServicesPr),
  ),
);

class NavBarRepository {
  final HomeServices _homeServices;
  final ProfileServices _profileServices;

  NavBarRepository(
      {required HomeServices homeServices,
      required ProfileServices profileServices})
      : _homeServices = homeServices,
        _profileServices = profileServices;

  ///Get All Categories List
  Future<List<CategoryJson>> getAllCategories() async {
    try {
      List<CategoryJson> getAllCategories = [];

      final response = await _homeServices.getAllCategories();

      if (response != null) {
        getAllCategories = await compute(CategoryJson.fromRawJson, response);
      }

      return getAllCategories;
    } on SocketException catch (_) {
      throw AppExceptions.instance.handleSocketException();
    } on MyHttpClientException catch (error) {
      throw AppExceptions.instance.handleMyHTTPClientException(error);
    } catch (e) {
      throw AppExceptions.instance.handleException(error: e.toString());
    }
  }

  ///Get User Details
  Future<UsersJson?> getUser() async {
    try {
      UsersJson? usersJson;

      final response = await _profileServices.getUser(
        userId: "592e1478-f071-70e2-c2e2-a92acc58cc5f",
      );

      if (response != null) {
        usersJson = await compute(UsersJson.fromRawJson, response);
      }

      return usersJson;
    } on SocketException catch (_) {
      throw AppExceptions.instance.handleSocketException();
    } on MyHttpClientException catch (error) {
      throw AppExceptions.instance.handleMyHTTPClientException(error);
    } catch (e) {
      throw AppExceptions.instance.handleException(error: e.toString());
    }
  }
}
