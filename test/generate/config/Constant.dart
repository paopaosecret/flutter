class Constant{

  //TODO 相关目录常量
  static String generateDirectory = "build/generate";
  static String pageTemplateFilePath = "test/generate/template/page.vm";
  static String actionTemplateFilePath = "test/generate/template/action.vm";
  static String stateTemplateFilePath = "test/generate/template/state.vm";
  static String middlewareTemplateFilePath = "test/generate/template/middleware.vm";
  static String reduceTemplateFilePath = "test/generate/template/reduce.vm";

  //TODO 模板中标记的文件名常量
  static String vmstateFileNameTemplate = "#stateFileName#";
  static String vmActionFileNameTemplate = "#actionFileName#";

  //TODO 模板中标记的类名常量
  static String vmPageClassTemplate = "#pageName#";
  static String vmStateClassNameTemplate = "#statClassName#";
}