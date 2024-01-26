import UIKit


struct HomeCellItems {
    var id: Int
    var taskType: Int                       // 0：任务，1：子任务
    var taskTitle: String
    var isDone: Bool
    var isReminded: Bool
    var isTimeSet: Int?
    var nextReminderTime: Int?
    var isRepeating: Bool
    var isProgressing: Bool
    var color: Int                          // 0:蓝色 | 1:紫 | 2:品红 | 3:红 | 4:橙 | 5:绿
    var priority: Int                       // 0:无 | 1:低 | 2:中 | 3:高
    var subtaskIdList: [Int]?               // ⚠️可能应该把List转一种表达
    var creationTime: Int
    var updateTime: Int
    var manualSorting: Int
    var progressPercentage: Int?             // 还需要：进度值、
}


class ViewController: UIViewController {
    var itemTable = ItemTable()
    
    // MARK: - 初始化与生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
}


// MARK: - 私有方法
extension ViewController {
    private func setupUI() {
        view.setBackgroundColor(color: cBgGray)

        if let count: Int = DB.shared.fetchScalar("SELECT COUNT(*) FROM project") {
            print("行数: \(count)")
        }
        
    }
    
}


struct AllTaskItems {
    var id: Int
    var taskType: Int                       // 0：任务，1：子任务
    var taskTitle: String
    var taskContent: String?
    var isDone: Bool
    var isReminded: Bool
    var isTimeSet: Bool?
    var nextReminderTime: Int?
    var reminderOccasions: [Int]?           // 时间
    var isRepeating: Bool
    var repeatCycle: Int?                   // 0:天 | 1:周 | 2:月 | 3:年
    var repeatInterval: Int?                // 如：每n天提醒一次，间隔就是这里的n
    var repeatDays: [Int]?                  // 0:周日 | 1:周一 | …(周二~周五依次) | 6:周六 (7个枚举值)
    var repeatType: Int?                    // 0:按日期 | 1:按星期
    var repeatDates: [Int]?                 // 数据范围：1-31
    var whichWeek: Int?                     // 0:第一个星期 | …(依次) | 4:第五个星期 | 5:最后一个星期
    var dayOfWeek: Int?                     // 0:周日 | 1:周一 | …(周二~周五依次) | 6:周六 | 7:自然日 | 8:工作日 | 9:周末
    var months: Int?                    // 1:1月 | (2月-11月依次) | 12:12月
    var endRepeatTime: Int?
    var isProgressing: Bool
    var progressType: Int?                  // 0:手动进度 | 1:时长进度 | 2:计时进度
    var totalProgress: Int?
    var color: Int                          // 0:蓝色 | 1:紫 | 2:品红 | 3:红 | 4:橙 | 5:绿
    var priority: Int                       // 0:无 | 1:低 | 2:中 | 3:高
    var subtaskIds: [Int]?
    var creationTime: Int
    var updateTime: Int
    var groupId: Int
    var isProgressDescriptionHidden: Bool
    var manualSorting: Int
    var isInTrash: Bool
}

