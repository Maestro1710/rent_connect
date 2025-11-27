/*theme, router*/
class AppRouter {
  static const home = '/';
  static const managePost = '/manage_post';
  static const chat = '/chat';
  static const profile = '/profile';
  static const addPost = '/addPost';
  static const login = '/login';
  static const register = '/register';
  //nhung screen yeu cau dang nhap
  static const protected = [chat, profile, addPost, managePost];
}