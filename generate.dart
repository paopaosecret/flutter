import 'dart:io';

import 'test/generate/config/Constant.dart';
import 'test/generate/generate_utils.dart';


void main(List<String> args) {
  String fileName = "";
  /*TODO 验证传递的参数是否符合标准*/
  if(args != null && args.length > 0 && args[0] != null && args[0].length > 0){
    print("生成类名${args[0]}相关文件");
    fileName = args[0];
  }else{
    print("请传递需要生成页面的名称，例如：dart generate.dart my_page");
    return;
  }
  /*TODO 1、初始化生成类的文件目录 */
  initDirectory(fileName);
}

initDirectory(String fileName) {
  final deployDir = Directory(Constant.generateDirectory);
  deployDir.exists().then((result){
    if(result){
      print("删除临时文件夹");
      deployDir.deleteSync(recursive: true);
    }
    print("创建零时文件夹");
    deployDir.createSync(recursive: true);
    String str = "${Constant.generateDirectory}/${GenerateUtils.getReduceDirectory(fileName)}";
    print("reduceDir = ${str}");
    final reduceDir = Directory(str);
    reduceDir.createSync(recursive: true);

    /*TODO 2、生成page类*/
    createPageFile(fileName);

    /*TODO 3、生成action类*/
    createActionFile(fileName);

    /*TODO 4、生成middleware类*/
    createMiddlewareFile(fileName);

    /*TODO 5、生成reduce类*/
    createReduceFile(fileName);

    /*TODO 6、生成state类*/
    createStateFile(fileName);
  });
}

void createPageFile(String fileName) {
  final pageFile = File("${Constant.generateDirectory}/${fileName}.dart");
  pageFile.exists().then((onVlaue){
    if(onVlaue){
      print("重新创建Page文件${fileName}");
      pageFile.deleteSync(recursive: true);
      pageFile.createSync(recursive: true);
    }else{
      print("新创建Page文件${fileName}");
      pageFile.createSync(recursive: true);
    }
  });

  final pageTemplateFile = File( Constant.pageTemplateFilePath);
  pageTemplateFile.exists().then((onVlaue){
    if(onVlaue){
      print("根据模板创建文件${fileName}");
      pageTemplateFile.readAsString().then((onValue){
        String pageTemplateString = onValue.replaceAll(Constant.vmPageClassTemplate, GenerateUtils.getClassNameByFileName(fileName));
        pageFile.writeAsStringSync(pageTemplateString);
        sleep(Duration(milliseconds: 100));
        print("创建Page文件${fileName}成功");
      });

    }else{
      print("page模板文件丢失，创建失败");
    }
  });
}

void createActionFile(String pageName) {
  String fileName = GenerateUtils.getActionFileName(pageName);
  final actionFile = File("${Constant.generateDirectory}/${GenerateUtils.getReduceDirectory(pageName)}/${fileName}.dart");
  actionFile.exists().then((onVlaue){
    if(onVlaue){
      print("重新创建Action文件${fileName}");
      actionFile.deleteSync(recursive: true);
      actionFile.createSync(recursive: true);
    }else{
      print("新创建Action文件${fileName}");
      actionFile.createSync(recursive: true);
    }
  });

  final actionTemplateFile = File(Constant.actionTemplateFilePath);
  actionTemplateFile.exists().then((onVlaue){
    if(onVlaue){
      print("根据模板创建文件${fileName}");
      actionTemplateFile.readAsString().then((onValue){
        actionFile.writeAsStringSync(onValue);
        sleep(Duration(milliseconds: 100));
        print("创建Action文件${fileName}成功");
      });
    }else{
      print("page模板文件丢失，创建失败");
    }
  });
}

void createMiddlewareFile(String pageName) {
  String fileName = GenerateUtils.getMiddlewareFileName(pageName);
  final middlewareFile = File("${Constant.generateDirectory}/${GenerateUtils.getReduceDirectory(pageName)}/${fileName}.dart");
  middlewareFile.exists().then((onVlaue){
    if(onVlaue){
      print("重新创建Middleware文件${fileName}");
      middlewareFile.deleteSync(recursive: true);
      middlewareFile.createSync(recursive: true);
    }else{
      print("新创建Middleware文件${fileName}");
      middlewareFile.createSync(recursive: true);
    }
  });


  final pageTemplateFile = File( Constant.middlewareTemplateFilePath);
  pageTemplateFile.exists().then((onVlaue){
    if(onVlaue){
      print("根据模板创建文件${fileName}");
      pageTemplateFile.readAsString().then((onValue){
        String pageTemplateString = onValue.replaceAll(Constant.vmPageClassTemplate, GenerateUtils.getClassNameByFileName(fileName));
        middlewareFile.writeAsStringSync(pageTemplateString);
        sleep(Duration(milliseconds: 100));
        print("创建middleware文件${fileName}成功");
      });

    }else{
      print("middleware模板文件丢失，创建失败");
    }
  });
}

void createStateFile(String pageName) {
  String fileName = GenerateUtils.getStateFileName(pageName);
  final stateFile = File("${Constant.generateDirectory}/${GenerateUtils.getReduceDirectory(pageName)}/${fileName}.dart");
  stateFile.exists().then((onVlaue){
    if(onVlaue){
      print("重新创建State文件${fileName}");
      stateFile.deleteSync(recursive: true);
      stateFile.createSync(recursive: true);
    }else{
      print("新创建State文件${fileName}");
      stateFile.createSync(recursive: true);
    }
  });

  final pageTemplateFile = File( Constant.stateTemplateFilePath);
  pageTemplateFile.exists().then((onVlaue){
    if(onVlaue){
      print("根据模板创建文件${fileName}");
      pageTemplateFile.readAsString().then((onValue){
        String pageTemplateString = onValue.replaceAll(Constant.vmPageClassTemplate, GenerateUtils.getClassNameByFileName(fileName));
        stateFile.writeAsStringSync(pageTemplateString);
        sleep(Duration(milliseconds: 100));
        print("创建state文件${fileName}成功");
      });

    }else{
      print("state模板文件丢失，创建失败");
    }
  });
}


void createReduceFile(String pageName) {
  String fileName = GenerateUtils.getReduceFileName(pageName);
  final reduceFile = File("${Constant.generateDirectory}/${GenerateUtils.getReduceDirectory(pageName)}/${fileName}.dart");
  reduceFile.exists().then((onVlaue){
    if(onVlaue){
      print("重新创建Reduce文件${fileName}");
      reduceFile.deleteSync(recursive: true);
      reduceFile.createSync(recursive: true);
    }else{
      print("新创建Reduce文件${fileName}");
      reduceFile.createSync(recursive: true);
    }
  });

  final pageTemplateFile = File( Constant.reduceTemplateFilePath);
  pageTemplateFile.exists().then((onVlaue){
    if(onVlaue){
      print("根据模板创建文件${fileName}");
      pageTemplateFile.readAsString().then((onValue){
        String pageTemplateString = onValue.replaceAll(Constant.vmPageClassTemplate, GenerateUtils.getClassNameByFileName(fileName))
          .replaceAll(Constant.vmstateFileNameTemplate, GenerateUtils.getStateFileName(pageName))
          .replaceAll(Constant.vmActionFileNameTemplate, GenerateUtils.getActionFileName(pageName))
          .replaceAll(Constant.vmStateClassNameTemplate, GenerateUtils.getClassNameByFileName(GenerateUtils.getStateFileName(pageName)));
        reduceFile.writeAsStringSync(pageTemplateString);
        sleep(Duration(milliseconds: 100));
        print("创建state文件${fileName}成功");
      });

    }else{
      print("state模板文件丢失，创建失败");
    }
  });
}




