class LocalStorage {
  // final String _kSignInData = "SignedInData";

  // final FlutterSecureStorage _storage = const FlutterSecureStorage(
  //   aOptions: AndroidOptions(encryptedSharedPreferences: true),
  // );

  ///
  //* Login Details
  // Future setLoginDetails(SignInJson signInData) async {
  //   await deleteLoginDetails();
  //   await _storage.write(key: _kSignInData, value: jsonEncode(signInData.data));
  //   debugPrint('Saved Vendor Login Details');
  // }

  //* Get JWT Token
  Future<String?> getJwtToken() async {
    // String? details = await _storage.read(key: _kSignInData);
    // if (details == null || details == "null") return null;
    // final data = SignedInData.fromRawJson(details);

    // return data.jwtToken;
    return '';
  }

  //* Get SignedIn Data
  // Future<SignedInData?> getSignedInData() async {
  //   String? details = await _storage.read(key: _kSignInData);
  //   if (details == null || details == "null") return null;

  //   return SignedInData.fromRawJson(details);
  // }

  //! Delete Login Details
  // Future deleteLoginDetails() async {
  //   await _storage.delete(key: _kSignInData);
  //   debugPrint('Deleted Login Details and Token');
  // }

  // //! Clear all data
  // Future deleteAll() async {
  //   await _storage.deleteAll();
  //   debugPrint('Deleted all');
  // }
}
