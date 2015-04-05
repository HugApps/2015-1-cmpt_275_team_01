    //
//  BreakMatchController.swift
//  SFU_App
//
//  Created by Nethaniel Yuen on 2015-03-20.
//  Copyright (c) 2015 Hugo Cheng. All rights reserved.
//
    class courses{
        var department: String = String();
        var section: String = String();
        var number: String = String();
    }
    
    class courseLists{
        var name: String = String("NaN");
        var instructor: String = String("NaN");
        var times: String = String("NaN");
        var days: String = String();
        var desc: String = String();
        var location: String = String();
        
    }
    
    
    
    
    func checkArrayForCourse(var x : courses) -> Bool{
        for y in arr{
            if x.department == y.department &&
                x.section == y.section &&
                x.number == y.number{
                    return true
            }
        }
        return false
        
    }

// Final List of names to display
   

func CreateMatrix() ->String {
    
    
    if (courseList.isEmpty ){return "000000000000000000000000000000000000000000000000000000000000"}
    for course in courseList {
        //println(course.times)
        var daymult = 0
        var intstring : [String] = course.times.componentsSeparatedByCharactersInSet(NSCharacterSet(charactersInString: ": -"))
        
        var daystring = course.days.componentsSeparatedByCharactersInSet(NSCharacterSet(charactersInString: ", "))
        
        var startime = intstring[0].toInt()
        var endtime = intstring[5].toInt()
        
        
        
        
        for day in daystring {
            
            
            switch day {
                
                
            case "Mo" :
                
                daymult = 0
                break;
                
            case "Tu":
                daymult = 1
                break;
                
            case "We":
                daymult = 2
                break;
                
            case "Th":
                daymult = 3
                break;
                
            case "Fr":
                daymult = 4
                break;
                
            default :
                break;
            }
            
            //Do some computation here
            var start = startime! - 8
            var end = endtime! - 8
            var hourOfClass = endtime! - startime!
            for (var i = 0; i < hourOfClass ; i++)
            {
                matrix[daymult*12 + start + i] = "1"
            }
            
            // Convert the array back to the string that used to stored in database
            // let scheduleDB  = "" + self.matrix
            
            
            
            
            
            
            
        }
        
        
        
    }
    let schedule  = "" + matrix
    //println(schedule)
    
   // println(schedule)
    return schedule
    
}

import UIKit
import CoreData
 var matrix = Array("000000000000000000000000000000000000000000000000000000000000")
class BreakMatchController: UIViewController {
   
    var DisplayList : [String] = []
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext

    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkBreak()
        
        
}
    
    
    override func viewDidAppear(animated: Bool) {
        let fetchRequest  = NSFetchRequest(entityName:"Friend")
         let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest,error: nil )
        for  result in fetchResults as [Friend] {
            //println(result.userid)
            //println(result.sch)
            
            
        }
        self.checkBreak ()
    }
    // Runs through the list
    func checkBreak (){
        
        
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute, fromDate: date)
        let hour = components.hour
        let minutes = components.minute
        let day = components.day
        var currentTime = hour*100 + minutes
        var timeSlot = 0

        let fetchRequest  = NSFetchRequest(entityName:"Friend")
        let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest,error: nil )
        // iterate each friendslist and check//
        for  result in fetchResults as [Friend] {
            var Usermatrix = Array(result.sch)
            
        

        
                switch currentTime
        {
        case 830...929:
            timeSlot = 0;
        case 930...1029:
            timeSlot = 1;
        case 1030...1129:
            timeSlot = 2;
        case 1130...1229:
            timeSlot = 3;
        case 1230...1329:
            timeSlot = 4;
        case 1330...1429:
            timeSlot = 5;
        case 1430...1529:
            timeSlot = 6;
        case 1530...1629:
            timeSlot = 7;
        case 1630...1729:
            timeSlot = 8;
        case 1730...1829:
            timeSlot = 9;
        case 1830...1929:
            timeSlot = 10;
        case 1930...2329:
            timeSlot = 11;
        default :
            break
        }
        let dayTimeFormatter = NSDateFormatter()
        dayTimeFormatter.dateFormat = "EEEEEE"
        let dayString = dayTimeFormatter.stringFromDate(date)
        
        
        var daymult = 0
        switch dayString {
        case "Mo" :
            
            daymult = 0
            break;
            
        case "Tu":
            daymult = 1
            break;
            
        case "We":
            daymult = 2
            break;
            
        case "Th":
            daymult = 3
            break;
            
        case "Fr":
            daymult = 4
            break;
            
        default :
            break;
        }
        
        if(Usermatrix[daymult*12 + timeSlot] == "0")
        {
            println(Usermatrix)
            println("Yes, he is free now")
            self.DisplayList.append(result.userid)
        }
        else
        {
            println("No, he is not free now")
            
        }
        }
        
        
        
        for name in DisplayList {
            println(name);
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func toggleSideMenu(sender: AnyObject) {
        toggleSideMenuView()
    }
}


