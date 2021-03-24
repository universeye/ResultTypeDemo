//
//  ViewController.swift
//  ResultTypeDemo
//
//  Created by Terry Kuo on 2021/3/24.
//

import UIKit


struct Course: Codable {
    let id: Int
    let name: String
    let imageUrl: String
    let number_of_lessons: Int
}


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        fetchCoursesJSON { (res) in
            switch res {
            case .success(let courses):
                courses.forEach { (courses) in
                    print(courses.name)
                }
            case .failure(let error):
                print("fail to fetch", error)
            }
        }
        
//        fetchCoursesJSON { (courseaa, err) in
//            if let err = err {
//                print("fail to fetch", err)
//            } else {
//                courseaa?.forEach({ (course) in
//                    print(course.name)
//                })
//            }
//        }
    }
    
    
    fileprivate func fetchCoursesJSON(completion: @escaping (Result<[Course], Error>) -> () ) {
        
        let urlString = "https://api.letsbuildthatapp.com/jsondecodable/courses"
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            //check error first
            if let err = error {
                completion(.failure(err))
                return
            }
            
            
            //success
            
            do {
                let courses = try JSONDecoder().decode([Course].self, from: data!)
                completion(.success(courses))
            } catch let JSONError{
                completion(.failure(JSONError))
               // completion(nil, JSONError)
            }
            
            
            
        }.resume()
    }

}

