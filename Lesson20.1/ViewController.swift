//
//  ViewController.swift
//  Lesson20.1
//
//  Created by Владислав Пуцыкович on 1.01.22.
//

import UIKit

extension UIColor {
    func random() -> UIColor {
        return UIColor(
            red: CGFloat.random(in: 0...1),
            green: CGFloat.random(in: 0...1),
            blue: CGFloat.random(in: 0...1),
            alpha: CGFloat.random(in: 0...1)
        )
    }
    
    var redValue: CGFloat{ return CIColor(color: self).red }
    var greenValue: CGFloat{ return CIColor(color: self).green }
    var blueValue: CGFloat{ return CIColor(color: self).blue }
    var alphaValue: CGFloat{ return CIColor(color: self).alpha }
}

struct StudentSection {
    var title: String
    var students: [Student]
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var tableView = UITableView()
    
    var students: [Student] = []
    
    var studentSections: [StudentSection] = []
    
    let identificator = "MyCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createStudents()
        createTable()
    }
    
    func createTable() {
        tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
    
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identificator)
        
        self.view.addSubview(tableView)
    }
    
    func createStudents() {
        let names = ["vlad","sasah","kirrila","voca","oleg"]
        let females = ["puts","ijke","some","dame","cole"]
        (0..<20).forEach { number in
            let student = Student(names.randomElement() ?? "name", females.randomElement() ?? "female", Double.random(in: 2...5))
            students.append(student)
        }
        studentSections.append(StudentSection(title: "Отличники", students: students.filter{$0.grade >= 4.5}))
        studentSections.append(StudentSection(title: "Хорошисты", students: students.filter{$0.grade >= 4 && $0.grade < 4.5}))
        studentSections.append(StudentSection(title: "Троечники", students: students.filter{$0.grade >= 3 && $0.grade < 4}))
        studentSections.append(StudentSection(title: "Двоечники", students: students.filter{$0.grade < 3}))
        (0..<studentSections.count).forEach { number in
            studentSections[number].students.sort {$0.name < $1.name}
        }
    }
    
    // MARK: DataSource
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//       let cell = tableView.dequeueReusableCell(withIdentifier: identificator, for: indexPath)
//        let color = UIColor().random()
//        cell.backgroundColor = color
//        cell.textLabel?.text = "R:\(Int(round(color.redValue * 255))) G:\(Int(round(color.greenValue * 255))) B:\(Int(round(color.blueValue * 255))) A:\(Int(round(color.alphaValue * 255)))"
//        return cell
        
        
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: identificator)
        cell.textLabel?.text = "\(studentSections[indexPath.section].students[indexPath.row].name) \(studentSections[indexPath.section].students[indexPath.row].female)"
        cell.detailTextLabel?.text = "\(studentSections[indexPath.section].students[indexPath.row].grade)"
        
        if studentSections[indexPath.section].students[indexPath.row].grade < 3 {
            cell.backgroundColor = .red
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            switch section {
            case 0 :
                return studentSections[0].students.count
            case 1 :
                return studentSections[1].students.count
            case 2 :
                return studentSections[2].students.count
            case 3 :
                return studentSections[3].students.count
            default :
                return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return studentSections[section].title
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return studentSections.count
    }
}

