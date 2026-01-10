/*theme, router*/
class AppRouter {
  static const home = '/';
  static const managePost = '/manage_post';
  static const chat = '/chat';
  static const profile = '/profile';
  static const addPost = '/add_post';
  static const login = '/login';
  static const register = '/register';
  static const detailsPost = '/details_post';
  static const manageDetailPost = '/manage_detail_post';
  static const updatePost = '/update_post';
  static const search = '/search';
  //nhung screen yeu cau dang nhap
  static const protected = [chat, profile, addPost, managePost];
}
