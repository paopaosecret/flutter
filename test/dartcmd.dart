import 'dart:io';


main(){
  //exeCmd();
  final buffer = StringBuffer();
  buffer.write("@echo off\n");
  buffer.write("mvn -version");
  buffer.write(" && ");
  buffer.write("mvn -version");
  buffer.write(" && ");

  print(buffer.toString());
}

Future<void> exeCmd() async{
  print("process strat:-----------------------------------------");
  //当前系统的命令行，例如Windoes命令行Nslookup www.baidu.com
  ProcessResult result = await Process.run('mvn', ['-version'], runInShell: true).then((ProcessResult results) {
    print(results.stdout);
  });

  print("result:" + result.stdout);
  print("result:" + result.stderr);

  print("process end:---------------------------------------------");
}