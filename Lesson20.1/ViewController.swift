//
//  ViewController.swift
//  Lesson20.1
//
//  Created by Владислав Пуцыкович on 1.01.22.
//

import UIKit

fileprivate struct Constants {
    static let identificator = "MyCell"
    static let names = ["vlad","sasah","kirrila","voca","oleg"]
    static let females = ["puts","ijke","some","dame","cole"]
    static let rowHeight: CGFloat = 50
    static let perfectGrade = "Отличники"
    static let goodGrade = "Хорошисты"
    static let threeGrade = "Троечники"
    static let twoGrade = "Двоечники"
}

class ViewController: UIViewController {
    var tableView = UITableView()
    
    var students: [Student] = []
    var studentSections: [StudentSection] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createStudents()
        createTable()
    }
    
    func createTable() {
        tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
    
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.identificator)
        
        self.view.addSubview(tableView)
    }
    
    func createStudents() {
        (0..<20).forEach { number in
            let student = Student(
                name: Constants.names.randomElement() ?? "name",
                female: Constants.females.randomElement() ?? "female",
                grade: Double.random(in: 2...5)
            )
            students.append(student)
        }
        studentSections.append(
            StudentSection(
                title: Constants.perfectGrade,
                students: students.filter{ $0.grade >= 4.5 }
            )
        )
        studentSections.append(
            StudentSection(
                title: Constants.goodGrade,
                students: students.filter{ $0.grade >= 4 && $0.grade < 4.5 }
            )
        )
        studentSections.append(
            StudentSection(
                title: Constants.threeGrade,
                students: students.filter{ $0.grade >= 3 && $0.grade < 4 }
            )
        )
        studentSections.append(
            StudentSection(
                title: Constants.twoGrade,
                students: students.filter{ $0.grade < 3 }
            )
        )
        (0..<studentSections.count).forEach { number in
            studentSections[number].students.sort { $0.name < $1.name }
        }
    }
}
// MARK: UITableViewDelegate
extension ViewController: UITableViewDelegate {
    
}

// MARK: UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//       let cell = tableView.dequeueReusableCell(withIdentifier: identificator, for: indexPath)
//        let color = UIColor().random()
//        cell.backgroundColor = color
//        cell.textLabel?.text = "R:\(Int(round(color.redValue * 255))) G:\(Int(round(color.greenValue * 255))) B:\(Int(round(color.blueValue * 255))) A:\(Int(round(color.alphaValue * 255)))"
//        return cell
        
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: Constants.identificator)
        cell.textLabel?.text = "\(studentSections[indexPath.section].students[indexPath.row].name) \(studentSections[indexPath.section].students[indexPath.row].female)"
        cell.detailTextLabel?.text = "\(studentSections[indexPath.section].students[indexPath.row].grade)"
        
        if studentSections[indexPath.section].students[indexPath.row].grade < 3 {
            cell.backgroundColor = .red
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentSections[section].students.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.rowHeight
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return studentSections[section].title
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return studentSections.count
    }
}
