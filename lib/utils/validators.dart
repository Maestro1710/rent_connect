//cac validator cho TextFormField

class Validators {
  static String? validateEmail (String? value) {
    if(value == null || value.isEmpty) {
      return 'Vui lòng nhập email !';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if(!emailRegex.hasMatch(value)) {
      return 'Email không hợp lệ';
    }
    return null;// hop le
  }

  static String? validatePassword (String? value) {
    if(value == null || value.isEmpty) {
      return 'Vui lòng nhập mật khẩu';
    }
    if(value.length < 6) {
      return 'Mật khẩu phải có ít nhất 6 ký tự';
    }
    return null;
  }

  static String? validateConfirmPassword(
      String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập lại mật khẩu';
    }
    if (value != password) {
      return 'Mật khẩu không khớp';
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập họ tên';
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập số điện thoại';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Số điện thoại chỉ được chứa ký tự số';
    }
    if (value.length < 9) {
      return 'Số điện thoại không hợp lệ';
    }
    return null;
  }

  static String? validateCommune(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập xã/phường';
    }
    return null;
  }

  static String? validateDistrict(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập quận/huyện';
    }
    return null;
  }

  static String? validateCity(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập thành phố';
    }
    return null;
  }
//Post validator
  static String? validatePost(String? value, String message) {
    if(value==null||value.trim().isEmpty) {
      return message;
    }
    return null;
  }

  static String? validateNumber(String? value, String message) {
    if (value == null || value.trim().isEmpty) {
      return message;
    }
    if (double.tryParse(value.trim()) == null) {
      return "Phải là số hợp lệ";
    }
    return null;
  }
}












