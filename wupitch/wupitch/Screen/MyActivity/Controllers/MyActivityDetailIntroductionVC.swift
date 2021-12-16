//
//  MyActivityDetailIntroductionVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/12/16.
//

import UIKit
import XLPagerTabStrip

// 내 활동 크루디테일 소개 탭
class MyActivityDetailIntroductionVC: UIViewController, IndicatorInfoProvider {
    
    // MARK: - IBOutlet
    @IBOutlet weak var tabTV: UITableView!
    lazy var crewDetailDataManager = MyActivityCrewDetailService()
    var detailInfo : CrewDetailResult?
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        setDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        crewDetailDataManager.getMyActivityCrewDetail(delegate: self)
    }
    
    // MARK: - IndicatorSetting
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "소개")
    }
    
    // MARK: - Function
    // 스타일
    private func setStyle() {
        // 테이블 뷰 경계션 없애기
        tabTV.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
    }
    // Delegate & DataSource & Register
    private func setDelegate() {
        tabTV.delegate = self
        tabTV.dataSource = self
        self.tabTV.register(DetailCrewImgTVCell.nib(), forCellReuseIdentifier: DetailCrewImgTVCell.identifier)
        self.tabTV.register(DetailCrewTitleTVCell.nib(), forCellReuseIdentifier: DetailCrewTitleTVCell.identifier)
        self.tabTV.register(DetailCrewIntroduceTVCell.nib(), forCellReuseIdentifier: DetailCrewIntroduceTVCell.identifier)
        self.tabTV.register(DtailCrewContentTVCell.nib(), forCellReuseIdentifier: DtailCrewContentTVCell.identifier)
        self.tabTV.register(DetailCrewFooterTVCell.nib(), forCellReuseIdentifier: DetailCrewFooterTVCell.identifier)
        self.tabTV.register(DetailCrewInquireCVCell.nib(), forCellReuseIdentifier: DetailCrewInquireCVCell.identifier)
    }
    func stringDate(doubleDate: Double) -> String {
        let doubleToString = String(format: "%.2f", doubleDate)
        let stringChange = doubleToString.split(separator: ".")
        let stringDate = String(stringChange.first!) + ":" + String(stringChange.last!)
        return stringDate
        //"%02d"
    }
}

// MARK: - TableView Extension
extension MyActivityDetailIntroductionVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    // 섹션
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    // 사이즈 자동 조정에 기준이 되는 값
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 600
    }
    // 셀 높이 값
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 211
        } else {
            return UITableView.automaticDimension
        }
    }
    // 각 셀 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailCrewImgTVCell.identifier) as? DetailCrewImgTVCell else{
                return UITableViewCell()
            }
            // 셀 눌렀을 때 색상 없애주기
            cell.selectionStyle = .none
            // 핀버튼은 없애주자!
            cell.pinBtn.isHidden = true
            switch detailInfo?.sportsID {
            case 1:
                if detailInfo?.crewImage == nil {
                    cell.mainImgView.image = UIImage(named: "imgFootThumb")
                }
                else {
                    cell.mainImgView.sd_setImage(with: URL(string: detailInfo?.crewImage ?? ""))
                }
            case 2:
                if detailInfo?.crewImage == nil {
                    cell.mainImgView.image = UIImage(named: "imgBadThumb")
                }
                else {
                    cell.mainImgView.sd_setImage(with: URL(string: detailInfo?.crewImage ?? ""))
                }
            case 3:
                if detailInfo?.crewImage == nil {
                    cell.mainImgView.image = UIImage(named: "imgVollThumb")
                }
                else {
                    cell.mainImgView.sd_setImage(with: URL(string: detailInfo?.crewImage ?? ""))
                }
            case 4:
                if detailInfo?.crewImage == nil {
                    cell.mainImgView.image = UIImage(named: "imgBaskThumb")
                }
                else {
                    cell.mainImgView.sd_setImage(with: URL(string: detailInfo?.crewImage ?? ""))
                }
            case 5:
                if detailInfo?.crewImage == nil {
                    cell.mainImgView.image = UIImage(named: "imgHikeThumb")
                }
                else {
                    cell.mainImgView.sd_setImage(with: URL(string: detailInfo?.crewImage ?? ""))
                }
            case 6:
                if detailInfo?.crewImage == nil {
                    cell.mainImgView.image = UIImage(named: "imgRunThumb")
                }
                else {
                    cell.mainImgView.sd_setImage(with: URL(string: detailInfo?.crewImage ?? ""))
                }
            default:
                break
            }
            return cell
        }
        if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailCrewTitleTVCell.identifier) as? DetailCrewTitleTVCell else{
                return UITableViewCell()
            }
            // 셀 눌렀을 때 색상 없애주기
            cell.selectionStyle = .none
            // 스포츠 아이디 라벨에 맞게
            switch detailInfo?.sportsID {
            case 1:
                cell.tagLabel.text = "축구/풋살"
                cell.tagView.backgroundColor = .sub04
            case 2:
                cell.tagLabel.text = "배드민턴"
                cell.tagView.backgroundColor = .sub03
            case 3:
                cell.tagLabel.text = "배구"
                cell.tagView.backgroundColor = .sub01
            case 4:
                cell.tagLabel.text = "농구"
                cell.tagView.backgroundColor = .sub02
            case 5:
                cell.tagLabel.text = "등산"
                cell.tagView.backgroundColor = .sub06
            case 6:
                cell.tagLabel.text = "런닝"
                cell.tagView.backgroundColor = .sub05
            default:
                break
            }
            
            // 무조건 있는 값들
            cell.titleLabel.text = detailInfo?.clubTitle
            cell.tagLabel.textColor = .wht
            
            // 지역이 없을 때
            if detailInfo?.areaName == nil {
                cell.locationLabel.text = "장소미정"
            } else {
                cell.locationLabel.text = detailInfo?.areaName
            }
            
            // 정기회비랑 손님비가 없을 때
            if detailInfo?.dues == nil && detailInfo?.guestDues == nil {
                cell.moneyLabel[0].isHidden = true
                cell.moneyLabel[1].isHidden = true
                cell.moneyIcon.isHidden = true
            // 정기회비는 있고 손님비가 없을 때
            } else if detailInfo?.dues != nil && detailInfo?.guestDues == nil {
                cell.moneyLabel[0].isHidden = false
                cell.moneyIcon.isHidden = true
                cell.moneyLabel[1].isHidden = false
                cell.moneyLabel[0].text = "정기회비" + " " + String(detailInfo?.dues ?? 0) + "원"
            // 정기회비는 없고 손님비는 있을 때
            } else if detailInfo?.dues == nil && detailInfo?.guestDues != nil {
                cell.moneyLabel[0].isHidden = false
                cell.moneyLabel[1].isHidden = true
                cell.moneyIcon.isHidden = false
                cell.moneyLabel[0].text = "손님비" + " " + String(detailInfo?.guestDues ?? 0) + "원"
            } else {
                cell.moneyLabel[0].isHidden = false
                cell.moneyLabel[1].isHidden = false
                cell.moneyIcon.isHidden = false
                cell.moneyLabel[0].text = "정기회비" + " " + String(detailInfo?.dues ?? 0) + "원"
                cell.moneyLabel[1].text = "손님비" + " " + String(detailInfo?.guestDues ?? 0) + "원"
            }
            
            // 스케줄
            if detailInfo?.schedules.count ?? 0 <= 1 {
                cell.dayLabel[0].text = String(detailInfo?.schedules[0].day ?? "") + " " + stringDate(doubleDate: detailInfo?.schedules[0].startTime ?? 0) + " - " + stringDate(doubleDate: detailInfo?.schedules[0].endTime ?? 0)
                cell.dayLabel[1].isHidden = true
                cell.dayLabel[2].isHidden = true
            }
            else if detailInfo?.schedules.count ?? 0 <= 2 {
                for i in 0...1 {
                    cell.dayLabel[i].text = String(detailInfo?.schedules[i].day ?? "") + " " + stringDate(doubleDate: detailInfo?.schedules[i].startTime ?? 0) + " - " + stringDate(doubleDate: detailInfo?.schedules[i].endTime ?? 0)
                }
                cell.dayLabel[1].isHidden = false
                cell.dayLabel[2].isHidden = true
            }
            else if detailInfo?.schedules.count ?? 0 <= 3 {
                for i in 0...2 {
                    cell.dayLabel[i].text = String(detailInfo?.schedules[i].day ?? "") + " " + stringDate(doubleDate: detailInfo?.schedules[i].startTime ?? 0) + " - " + stringDate(doubleDate: detailInfo?.schedules[i].endTime ?? 0)
                }
                cell.dayLabel[1].isHidden = false
                cell.dayLabel[2].isHidden = false
            }
            return cell
        } else if indexPath.section == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailCrewIntroduceTVCell.identifier) as? DetailCrewIntroduceTVCell else{
                return UITableViewCell()
            }
            // 셀 눌렀을 때 색상 없애주기
            cell.selectionStyle = .none
            cell.titleLabel.text = "소개"
            // 인원이 없을 때
            if detailInfo?.memberCount == nil {
                cell.peopleLabel.isHidden = true
            }
            else {
                cell.peopleLabel.isHidden = false
                cell.peopleLabel.text = "인원:" + " " + String(detailInfo?.memberCount ?? 0) + "명"
            }
            // 연령대가 있을 때
            print("연령대",detailInfo?.ageTable.count)
            
            if var age = detailInfo?.ageTable {
                cell.ageLabel.isHidden = false
                cell.ageLabel.text = "연령:" + " " + age.joined(separator: ", ")
            }
            else {
                cell.ageLabel.isHidden = true
            }
            cell.contentLabel.text = detailInfo?.introduction
            return cell
        } else if indexPath.section == 3 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DtailCrewContentTVCell.identifier) as? DtailCrewContentTVCell else{
                return UITableViewCell()
            }
            // 셀 눌렀을 때 색상 없애주기
            cell.selectionStyle = .none
            cell.titleLabel.text = "준비물"
            if detailInfo?.materials == nil {
                cell.contentLabel.text = "준비물이 없어요."
            }
            else {
                cell.contentLabel.text = detailInfo?.materials
            }
            return cell
        } else if indexPath.section == 4 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailCrewFooterTVCell.identifier) as? DetailCrewFooterTVCell else{
                return UITableViewCell()
            }
            // 셀 눌렀을 때 색상 없애주기
            cell.selectionStyle = .none
            return cell
        } else if indexPath.section == 5 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DtailCrewContentTVCell.identifier) as? DtailCrewContentTVCell else{
                return UITableViewCell()
            }
            // 셀 눌렀을 때 색상 없애주기
            cell.selectionStyle = .none
            cell.titleLabel.text = "문의"
            cell.contentLabel.text = detailInfo?.inquiries
            return cell
        } else if indexPath.section == 6 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailCrewInquireCVCell.identifier) as? DetailCrewInquireCVCell else{
                return UITableViewCell()
            }
            // 셀 눌렀을 때 색상 없애주기
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
}

extension MyActivityDetailIntroductionVC {
    func didSuccessMyActivityCrewDetail(result: CrewDetailResult) {
        print("크루 디테일 조회 데이터가 성공적으로 들어왔습니다.")
        self.detailInfo = result
        tabTV.reloadData()
    }
    func failedToRequest(message: String) {
        print("데이터가 들어오지 않았습니다.")
    
    }
}
