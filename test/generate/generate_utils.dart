import 'dart:io';

class GenerateUtils{

  /**
   * 通过文件名转换为类名
   */
  static String getClassNameByFileName(String fileName){
    if(fileName != null && fileName.length > 0){
      if(fileName.contains("_")){
        StringBuffer sb = new StringBuffer("");
        List<String> list = fileName.split("_");
        list.forEach((item) {
          if(item != null && item.length > 0){
            sb.write(convertFristCharToUpper(item));
          }
        });
        return sb.toString();
      }else{
        return convertFristCharToUpper(fileName);
      }
    }else{
      print("文件名为空");
      return "";
    }
  }
  
  static String convertFristCharToUpper(String str){
    return str.replaceFirst(str[0], str[0].toUpperCase());
  }

  static String getActionFileName(String fileName){
    StringBuffer sb = new StringBuffer("");
    sb.write(fileName);
    sb.write("_action");
    return sb.toString();
  }

  static String getStateFileName(String fileName){
    StringBuffer sb = new StringBuffer("");
    sb.write(fileName);
    sb.write("_state");
    return sb.toString();
  }

  static String getMiddlewareFileName(String fileName){
    StringBuffer sb = new StringBuffer("");
    sb.write(fileName);
    sb.write("_middleware");
    return sb.toString();
  }

  static String getReduceFileName(String fileName){
    StringBuffer sb = new StringBuffer("");
    sb.write(fileName);
    sb.write("_reduce");
    return sb.toString();
  }

  static String getReduceDirectory(String fileName){
    return fileName.replaceAll("_", "");
  }

}