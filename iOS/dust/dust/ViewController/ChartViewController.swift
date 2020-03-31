//
//  FirstViewController.swift
//  dust
//
//  Created by 신한섭 on 2020/03/30.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class ChartViewController: UIViewController {
    
    @IBOutlet weak var gradationView: GradationView!
    @IBOutlet weak var chartTableView: UITableView!
    @IBOutlet weak var emoticonLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var numericLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var stationLabel: UILabel!
    
    private var modelManager = DustInfoModelManager()
    private var dataSource = ChartTableViewDatasource()
    private var delegate = ChartTableViewDelegate()
    private let emoticonUnicode = ["Good" : "\u{1F600}", "Normal" : "\u{1F642}", "Bad" : "\u{1F637}", "Terrible" : "\u{1F631}"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupDelegate()
        setupDatasource()
        
        self.emoticonLabel.font = UIFont(name: "TimesNewRomanPSMT", size: self.gradationView.frame.height * 0.35)
        
        changeGradationViewUI(model: modelManager.index(of: 0))
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(changeSummaryViewUI(_:)),
                                               name: .FirstCellOnTalbeView,
                                               object: nil)
    }
    
    func setupDelegate() {
        delegate.modelManager = modelManager
        self.chartTableView.delegate = delegate
    }
    
    func setupDatasource() {
        dataSource.modelManger = modelManager
        self.chartTableView.dataSource = dataSource
    }
    
    func changeGradationViewUI(model: DustInfoModel) {
        DispatchQueue.main.async {
            self.gradationView.setGradientColor(state: "\(model.grade)")
            self.numericLabel.text = String(model.numeric)
            self.stationLabel.text = String(model.station)
            self.timeLabel.text = String(model.time)
            self.gradeLabel.text = "\(model.grade)"
            self.emoticonLabel.text = self.emoticonUnicode["\(model.grade)"]
        }
    }
    
    @objc func changeSummaryViewUI(_ notification: Notification) {
        guard let model = notification.userInfo?["model"] as? DustInfoModel else {return}
        changeGradationViewUI(model: model)
    }
}

