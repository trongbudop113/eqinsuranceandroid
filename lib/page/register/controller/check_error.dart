class CheckError{
  static bool isSuccess(String response){//only for EQ Insurance XML
    if(response == "-1" || response == "0"){
      return false;
    }
    return true;
  }
}