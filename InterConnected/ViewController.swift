//
//  ViewController.swift
//  InterConnected
//
//  Created by Jasmee Sengupta on 15/03/18.
//  Copyright © 2018 Jasmee Sengupta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let stackOverFlowURL = "https://api.stackexchange.com/2.2/questions?order=desc&sort=votes&site=stackoverflow"
    let smallJSONURL = "https://api.randomuser.me/"
    let blogURL = "https://swift.mrgott.pro/blog.json"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        loadQuestions(withCompletion: { questions in
//            print(questions)
//        })
        //simpleGETJSONData()
        let q = Question()
        q.callme()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func simpleGETJSONData(){// without any completion
        let session = URLSession(configuration: .ephemeral, delegate: nil, delegateQueue: OperationQueue.main)
        //let sharedSession = URLSession.shared //for simple tasks
        guard let url = URL(string: stackOverFlowURL) else { return }
        let task = session.dataTask(with: url) { (data, response, error) in
            
            self.printResponseHeader(response: response)
            
            if let error = error {
                print(error)
                return
            }
            guard let data = data else {
                print("No data received")
                return
            }
            guard let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) else {
                print("Could not convert data into JSON Object")
                return
            }
            guard let jsonDict = json as? NSDictionary else {// Dictionary<String, String> not able to cast
                print("Could not convert JSON Object into dictionary")
                return
            }
            print(jsonDict)
        }
        task.resume()
    }
    
    func printResponseHeader(response: URLResponse?) {
        guard let header = response as? HTTPURLResponse else {
            return
        }
        print("-------HTTP Header-----")
        if let url = header.url {
            print("URL is \(url)")
        }
        print("Status Code is \(header.statusCode)")
        let headerFields = header.allHeaderFields// Dictionary
        for (key, value) in headerFields {// key AnyHashable
            print("\(key) : \(value)")
        }
        print("-------HTTP Header ends-----")
    }
    
    func loadQuestions(withCompletion completion: @escaping (Any?) -> Void) {//([Question]?)
        let session = URLSession(configuration: .ephemeral, delegate: nil, delegateQueue: OperationQueue.main)
        let url = URL(string: stackOverFlowURL)!
        let task = session.dataTask(with: url, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            guard let data = data else {
                completion(nil)
                return
            }
            guard let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) else {
                completion(nil)
                return
            }
            //let questions: [Question] = [] // Transform JSON into Question values
            completion(json)
        })
        task.resume()
    }


}
class Question {// not possible to pass nil in swift, only of that optional type
    var b: Int!
    var c: String!
    func callme() {
        strange(a: "me")
        strange(a: 6)
        strange(a: b)
        strange(a: c)
    }
    func strange(a: String?) {
        print(a)
    }
    func strange(a: Int?) {
        print(a)
    }
    
}
