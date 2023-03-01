//
//  ViewController.swift
//  ReadEmbeddedJson
//
//  Created by Shein Thu Lwin on 01/03/2023.
//

import UIKit

struct Person : Decodable {
    var name: String
    var age: String
    var employed: String
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .gray
        
        if let pserson = readJsonModel(filename: "MyJson") {
            print("Person >> \(pserson.name), \(pserson.age), \(pserson.employed)")
        }
        
        if let dic = readJsonDic(filename: "MyJson") {
            print("Person(dictionary) >> \(dic["name"]), \(dic["age"]), \(dic["employed"])")
        }
    }
    
    func readJsonModel(filename fileName: String) -> Person? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Person.self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
    
    func readJsonDic(filename fileName: String) -> [String: AnyObject]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let object = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                if let dictionary = object as? [String: AnyObject] {
                    return dictionary
                }
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}

