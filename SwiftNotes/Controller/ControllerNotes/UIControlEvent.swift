//
//  ControllerNote.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/1/10.
//  Copyright © 2020 GinsMac. All rights reserved.
//


/*
 
 UIControl.Event 交互事件：
 触摸事件：
 TouchDown    表示控件边界内任何地方发生的按下（手指触到屏幕）事件。
 TouchUpInside    表示控件便捷内任何地方发生抬起来（手指离开屏幕）事件
 TouchUpOutside    表示手指完全落在控件的边界外的事件
 TouchDragEnter    表示拖拽进入控件边界内的事件
 TouchDragExit    表示拖拽移出控件边界内的事件
 TouchCancel    表示取消当前的一个触摸的系统事件
 AllTouchEvents    表示用于捕捉一切触摸事件
 
 值事件：
 ValueChanged    表示控件的值发生变化后出发的事件，如UITextField的text发生变化。
 
 编辑事件：
 EditingDidBegin    表示TextField控件内部的触摸开始事件，表示TextField开始编辑状态（获得焦点）
 EditingDidEnd    表示TextField控件外部的触摸结束事件，表示TextField结束编辑状态（失去焦点）
 EditingChanged    表示TextField的内容编辑修改时触发的事件
 EditingDidEndOnExit    表示结束编辑会话事件，但不一定是控件的外边界触摸事件
 AllEditingEvents    表示用于捕捉任意编辑事件
 ApplicationReserved    表示应用程序的特定事件
 SystemReserved    表示系统（内部的框架）特定事件
 PrimaryActionTriggered    表示semantic action
 AllEnvnts    表示用于捕捉任何触摸、值、编辑、应用程序、系统事件
 
 */
