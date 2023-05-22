//
//  Helper.swift
//  Sports2
//
//  Created by Mac on 20/05/2023.
//

import Foundation

//format = 2024-01-18
func getCurrentDate() -> String{
    
    let date = Date()
    let dateFormatter = DateFormatter()
     
    dateFormatter.dateFormat = "yyyy-MM-dd"
     
    let result = dateFormatter.string(from: date)
    
    return result
}


func getFutureDate() -> String{
    
    let date = Date()
    
    var dateComponent = DateComponents()
    dateComponent.year = 1
    let futureDate = Calendar.current.date(byAdding: dateComponent, to: date)!
    
    let dateFormatter = DateFormatter()
     
    dateFormatter.dateFormat = "yyyy-MM-dd"
     
    let result = dateFormatter.string(from: futureDate)
    
    return result
}

func getPastDate() -> String{
    
    let date = Date()
    
    var dateComponent = DateComponents()
    dateComponent.year = -1
    
    let pastDate = Calendar.current.date(byAdding: dateComponent, to: date)!
    
    let dateFormatter = DateFormatter()
     
    dateFormatter.dateFormat = "yyyy-MM-dd"
     
    let result = dateFormatter.string(from: pastDate)
    
    return result
}
