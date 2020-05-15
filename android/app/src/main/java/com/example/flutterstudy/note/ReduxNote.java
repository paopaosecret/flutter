package com.example.flutterstudy.note;

/**
 * Redux设计思想：
 * 1.应用是一个状态机， 视图与状态是一一对应的
 * 2.所有的状态，保存在一个对象里面
 *
 * 基本概念
 * Store:保存数据的容器，整个应用只有一个Store
 *
 * State:一个state对应一个View.只要state相同，View就相同。你知道State,就知道View长什么样，反之亦然
 *
 * Action:State的变化，会导致View的变化，但是用户接触不到State,只能接触到View.所以，State的变化必须是View导致的。
 *    Action就是View发出去的通知，表示State应该要发生变化了。
 *    Action 描述当前发生的事情，改变State的唯一方法就是使用Action,将数据运送到Store。
 *
 * StoreProvider：是一个基础 Widget ，一般在应用的入口处作为父布局使得，用于传递 Store
 *            View发出Action的唯一方法
 *
 * Reducer：Store收到Action之后必须给出一个新的State,这样View才会发生变化。这种State的处理过程就叫做Reducer
 *      Reducer是一个函数，它接收Action和State作为参数，并返回一个新的State
 *
 * StoreConnector:一个可以获取 Store 的 Widget ，作用是响应 Store 发出的状态改变事件来重建 UI。
 *      当Reducer产生新的State，StoreConnector会接收到新的State并根据State去刷新UI
 *
 * Middleware:当Action发出之后，Reducer立即计算出State,这就是同步，Action发出之后，过一段时间再执行就是异步，如何让Reducer在异步结束之后再执行，这就是新的工具：中间件
 *
 * 为什么不在Reducer中处理异步？
 * （1）Reducer：纯函数，只承担计算 State 的功能，不合适承担其他功能，也承担不了，因为理论上，纯函数不能进行读写操作。
 * （2）View：与 State 一一对应，可以看作 State 的视觉层，也不合适承担其他功能。
 * （3）Action：存放数据的对象，即消息的载体，只能被别人操作，自己不能进行任何操作。
 */
public class ReduxNote {
}
