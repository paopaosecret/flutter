/**
 * 定义操作该State的全部Action
 * 这里只有增加count一个动作
 */
class AddAction{
  AddAction(int num){
    increment = num;
  }
  int increment;
}