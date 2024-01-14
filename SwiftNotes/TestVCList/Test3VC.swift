//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        var rightMargin: CGFloat = 0

//        let cell = UITableViewCell()
//        cell.setBackgroundColor(color: cF2F3F6)
//        cell.setFrame(left: 0, top: 0, width: kScreenWidth, height: 48)

//        let bgView = UIView()
//        bgView.setup(superview: cell, backgroundColor: cFFF)
//        bgView.setFrame(left: 10, top: 0, right: 10, height: 48)
//        bgView.setCellCornerRadius(radius: 10, index: indexPath.row, maxIndex: titleArray.count - 1)
//        bgView.setSeparator(left: 42, right: 12)

//        let checkboxButton = UIButton()
//        checkboxButton.setup(superview: bgView, target: self, action: #selector(check))
//        checkboxButton.setStyleIconButton(imageName: "oval")
//        checkboxButton.setFrame(left: 12, centerY: bgView.centerY, width: 20, height: 20)

//        let priorityIcon = UIImageView()
//        switch priorityArray[indexPath.row] {
//        case 3:
//            priorityIcon.setup(superview: bgView, imageName: "priority3")
//            priorityIcon.setFrame(left: 42, centerY: bgView.centerY, width: 16, height: 24)
//        case 2:
//            priorityIcon.setup(superview: bgView, imageName: "priority2")
//            priorityIcon.setFrame(left: 42, centerY: bgView.centerY, width: 11, height: 24)
//        case 1:
//            priorityIcon.setup(superview: bgView, imageName: "priority1")
//            priorityIcon.setFrame(left: 42, centerY: bgView.centerY, width: 6, height: 24)
//        default: // case 0
//            priorityIcon.setup(superview: bgView)
//            priorityIcon.setFrame(left: 42, centerY: bgView.centerY, width: 0, height: 24)
//        }

//        let timerButton = UIButton()
//        timerButton.setup(superview: bgView, target: self, action: #selector(check))
//        timerButton.setStyleIconButton(imageName: "task_timer")
//        timerButton.setFrame(right: 12, centerY: bgView.centerY, width: 20, height: 26)
//
//        let dateAndTimeButton = UIButton(type: .custom)
//        dateAndTimeButton.setup(superview: bgView)
//
//        if hasRemindArray[indexPath.row] == 1 { // 有提醒(至少有日期)
//            if remindTimeArray[indexPath.row] != 0  {
//                // 有时间 & 无重复
//                dateAndTimeButton.setStyleWordButton(title: "11:00\n12月30日", titleSize: 12, titleColor: c888)
//                dateAndTimeButton.titleLabel?.numberOfLines = 2
//                dateAndTimeButton.titleLabel?.setLineHeight(multiple: 15/12)
//                dateAndTimeButton.setFrame(right: 44, centerY: bgView.centerY, width: dateAndTimeButton.titleLabel?.getLabelWidth() ?? 100, height: 48)
//
//
//                if isRepeatingArray[indexPath.row] == 1 {
//                    // 有时间 & 有重复
//                    let repeatIcon = UIImageView()
//                    repeatIcon.setup(superview: dateAndTimeButton, imageName: "task_repeat_future")
//                    repeatIcon.setFrame(right: 2, top: 11.5, width: 10, height: 10)
//                }
//            }
//            else if remindTimeArray[indexPath.row] == 0 && isRepeatingArray[indexPath.row] == 1 {
//                // 无时间 & 有重复
//                dateAndTimeButton.setStyleWordIconButton(title: "12月30日", titleSize: 12, titleColor: c888, imageName: "task_repeat_future", imageLocation: .right, interval: 1)
//                let labelWidth = dateAndTimeButton.titleLabel?.getLabelWidth() ?? 0
//                dateAndTimeButton.setFrame(right: 44, centerY: bgView.centerY, width: labelWidth + 12, height: 48)
//            }
//            else if remindTimeArray[indexPath.row] == 0 && isRepeatingArray[indexPath.row] == 0 {
//                // 无时间 & 无重复
//                dateAndTimeButton.setStyleWordButton(title: "12月30日", titleSize: 12, titleColor: c888)
//                dateAndTimeButton.setFrame(right: 44, centerY: bgView.centerY, width: dateAndTimeButton.titleLabel?.getLabelWidth() ?? 100, height: 48)
//            }
//            rightMargin = CGFloat(dateAndTimeButton.width) + 44 + 8
//
//        } else { // hasRemindArray == 0, 即无提醒
//            rightMargin = 44
//        }
//

//        if hasProgressArray[indexPath.row] == 1 {
//            let progressBg = UIImageView()
//            progressBg.setup(superview: bgView, imageName: "progressBg")
//            progressBg.setFrame(right: rightMargin, centerY: bgView.centerY, width: 24, height: 24)
//            rightMargin = rightMargin + 24 + 4
//
//            let progressLabel = UILabel()
//            progressLabel.setup(superview: progressBg, text: "0")
//            progressLabel.setStyle12pt999MedCent()
//            progressLabel.setFrame(center: progressBg)
//        }
//
//
//        let cellTitle = UILabel()
//        cellTitle.setup(superview: bgView, text: titleArray[indexPath.row])
//        cellTitle.setFrame(left: priorityIcon.right, centerY: cell.centerY, right: rightMargin)
//        // kScreenWidth - 20 得到cell全长。 (progressBg.left - 4)为标题的right坐标。前后相减，得到标题右边距
//        cellTitle.setStyle17pt222Med()
//
//        return cell
//
//    }
