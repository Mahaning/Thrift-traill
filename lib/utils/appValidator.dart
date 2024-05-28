class AppValidator{
  String? validateUserName(value){
    if (value!.isEmpty) {
      return "Please enter a valid UserName ";
    }

    return null;
  }
  String? validatePassword(value){
    if (value!.isEmpty) {
      return "Please enter a valid UserName ";
    }

    return null;
  }
  String? validateEmail(value) {
    if (value!.isEmpty) {
      return "Please enter a valid email address";
    }
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return "Please enter a valid email address";
    }
    return null;
  }
  String? validatePhoneNumber(value){
    if(value!.isEmpty){
      return "Plese Enter 10 digit valid Number";
    }else if(value.length!=10){
      return "Plese Enter 10 digit valid Number";
    }
    return null;
  }

  String? isEmptyCheck(value){
    if (value!.isEmpty) {
      return "Please enter a valid details ";
    }

    return null;
  }

}