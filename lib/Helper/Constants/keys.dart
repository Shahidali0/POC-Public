class MyKeys {
  MyKeys._();

  static MyKeys get instance => MyKeys._();

  //* Stripe publishableKey
  String get stripePublishableKey =>
      "pk_test_51R4q97FqRnaxJowltyiHWqExe8RQJ4Wdi99NSNlWtViK8mv1AS1AxQu9oYlnmNjkVz2kyKHjzjij0pJOiOfxXWQ500jjjtf6vU";

  //* Base Api URL'S
  String baseUrl(bool isAuthUrl) => isAuthUrl
      ? "https://44lsjdxksc.execute-api.ap-southeast-2.amazonaws.com/staging/"
      : "https://otbkcau8k5.execute-api.ap-southeast-2.amazonaws.com/";
}
