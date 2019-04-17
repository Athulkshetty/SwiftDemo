//
//  DateTimeUtil.swift
//  SwiftDemo
//
//  Created by LCode Technologies on 29/11/18.
//  Copyright © 2018 Lcodetechnologies. All rights reserved.
//

import UIKit

class DateTimeUtil: NSObject {
    
    var DateTimeUtil_dateFormat_:NSString = "yyyyMMdd"
    var DateTimeUtil_timeFormat_:NSString = "HHmmss"
    var DateTimeUtil_dateTime_:NSString = "yyyyMMdd HHmmss"
    var DateTimeUtil_defaultDispFormat_:NSString = "dd-MM-yyyy"
    var DateTimeUtil_defaultDispFormatTime_:NSString = "dd-MM-yyyy HH:mm:ss"
    var DateTimeUtil_datePrint_:NSString = "dd MM yyyy / HH:mm:ss"
    
    var datetimeutil = DateTimeUtil()
    
    func dateFormat() -> NSString {
        return DateTimeUtil_dateFormat_;
    }
    func setDateFormat(dateFormat:NSString) -> Void
    {
        DateTimeUtil_dateFormat_ = dateFormat
    }
    
    func timeFormat() -> NSString {
        return DateTimeUtil_timeFormat_;
    }
    func setTimeFormat(timeFormat:NSString) -> Void
    {
        DateTimeUtil_timeFormat_ = timeFormat
    }
    
    func dateTime() -> NSString {
        return DateTimeUtil_dateTime_;
    }
    func setDateTime(dateTime:NSString) -> Void
    {
        DateTimeUtil_dateTime_ = dateTime
    }
    
    func defaultDispFormat() -> NSString {
        return DateTimeUtil_defaultDispFormat_;
    }
    func setDefaultDispFormat(defaultDispFormat:NSString) -> Void
    {
        DateTimeUtil_defaultDispFormat_ = defaultDispFormat
    }
    
    func defaultDispFormatTime() -> NSString {
        return DateTimeUtil_defaultDispFormatTime_;
    }
    func setDefaultDispFormatTime(defaultDispFormat:NSString) -> Void
    {
        DateTimeUtil_defaultDispFormatTime_ = defaultDispFormat
    }
    
    func datePrint() -> NSString {
        return DateTimeUtil_datePrint_;
    }
    func setDatePrint(datePrint:NSString) -> Void
    {
        DateTimeUtil_datePrint_ = datePrint
    }
    
    func getDeviceDateStr() -> String? {
        var retDate: String = ""
        do {
            let date = Date()
            let sdf = DateFormatter()
            sdf.dateFormat = DateTimeUtil_dateFormat_ as String?
                retDate = sdf.string(from: date)
        }
        return retDate
    }
    
    func getDeviceDateTimeStr() -> String? {
        var retDateTime: String = ""
        do {
            let dateTime = Date()
            let sdf = DateFormatter()
            sdf.dateFormat = DateTimeUtil_dateFormat_ as String?
            retDateTime = sdf.string(from: dateTime)
        }
        return retDateTime
    }
        
    func getDeviceTimeStr() -> String? {
       var retTime: String = ""
        do {
            let time = Date()
            let sdf = DateFormatter()
            sdf.dateFormat = DateTimeUtil_dateFormat_ as String?
            retTime = sdf.string(from: time)
    }
        return retTime
  }

    func getDeviceDate() -> Date? {
        var retDate: Date?
        do {
            let sdf = DateFormatter()
            sdf.dateFormat = DateTimeUtil_dateFormat_ as String?
            retDate = sdf.date(from: datetimeutil.getDeviceDateStr()!)
        }
        return retDate
  }

    func getDeviceDateTime() -> Date? {
        var retDateTime: Date?
        do {
            let sdf = DateFormatter()
            sdf.dateFormat = DateTimeUtil_dateTime_ as String?
            retDateTime = sdf.date(from: datetimeutil.getDeviceDateTimeStr()!)
        }
        return retDateTime
  }
    
    func getDeviceTime() -> Date? {
        var retTime: Date?
        do {
            let sdf = DateFormatter()
            sdf.dateFormat = DateTimeUtil_timeFormat_ as String?
            retTime = sdf.date(from: datetimeutil.getDeviceTimeStr()!)
        }
        return retTime
   }

    func getStrFromDate(dtp:NSDate?) -> NSString? {
        var retDate:NSString?
        if dtp != nil {
        let sdf = DateFormatter()
        sdf.dateFormat = DateTimeUtil_timeFormat_ as String?
            retDate = sdf.string(from: dtp! as Date) as NSString
        }
        return retDate
   }

    func getDateFromStr(dtp:NSString?) -> NSDate? {
        var retactDate:NSDate?
        if dtp != nil {
            let sdf = DateFormatter()
            sdf.dateFormat = DateTimeUtil_timeFormat_ as String?
            retactDate = sdf.date(from: (dtp! as String)) as NSDate?
        }
        return retactDate
    }
    func getDateFormat(actualval:NSString, withstring reqFormat:NSString) ->NSString
    {
        var retval:NSString = ""
        if !(actualval.isEqual(to: ""))
        {
            let format:DateFormatter = DateFormatter()
            format.date(from: DateTimeUtil_dateFormat_ as String)
            let reqdate:NSDate = format.date(from:actualval as String )! as NSDate
            let reqformat:DateFormatter = DateFormatter()
            reqformat.date(from: reqFormat as String)
            retval = reqformat.string(from: reqdate as Date) as NSString
        }
            return retval
        
    }
    
    func getDateTimeFormat(actualval:NSString, withstring reqFormat:NSString) ->NSString
    {
        var retval:NSString = ""
        if !(actualval.isEqual(to: ""))
        {
            let format:DateFormatter = DateFormatter()
            format.date(from: DateTimeUtil_dateTime_ as String)
            let reqdate:NSDate = format.date(from:actualval as String )! as NSDate
            let reqformat:DateFormatter = DateFormatter()
            reqformat.date(from: reqFormat as String)
            retval = reqformat.string(from: reqdate as Date) as NSString
        }
        return retval
        
    }
    
    func getDisplayFormatDate(actualval:NSString) ->NSString
    {
        var retval:NSString = ""
        if !(actualval.isEqual(to: ""))
        {
            let format:DateFormatter = DateFormatter()
            format.date(from: DateTimeUtil_dateFormat_ as String)
            let reqdate:NSDate = format.date(from:actualval as String )! as NSDate
            let reqformat:DateFormatter = DateFormatter()
            reqformat.date(from: DateTimeUtil_defaultDispFormat_ as String)
            retval = reqformat.string(from: reqdate as Date) as NSString
        }
        return retval
        
    }
    
    func getDisplayFormatDateTime(actualval:NSString) ->NSString
    {
        var retval:NSString = ""
        if !(actualval.isEqual(to: ""))
        {
            let format:DateFormatter = DateFormatter()
            format.date(from: DateTimeUtil_dateTime_ as String)
            let reqdate:NSDate = format.date(from:actualval as String )! as NSDate
            let reqformat:DateFormatter = DateFormatter()
            reqformat.date(from: DateTimeUtil_defaultDispFormatTime_ as String)
            retval = reqformat.string(from: reqdate as Date) as NSString
        }
        return retval
        
    }
    func getDeviceDateTimePrint() -> NSString {
        var retdate:NSString = ""
        do {
            let date:NSDate = NSDate()
            let sdf:DateFormatter = DateFormatter()
            sdf.date(from: DateTimeUtil_datePrint_ as String)
            retdate = sdf.string(from: date as Date) as NSString
        }
        return retdate
    }
    func getDeviceDateFmt(_format:NSString) -> NSString {
        var retdate:NSString = ""
        do {
            let date:NSDate = NSDate()
            let sdf:DateFormatter = DateFormatter()
            sdf.date(from: _format as String)
            retdate = sdf.string(from: date as Date) as NSString
        }
        return retdate
    }
    
    func getPrintDateFormat(_date:NSString) -> NSString {
        var retdate:NSString = ""
        do {
            retdate = _date.substring(with: NSRange(location: 6, length: 2)) + ("/") + (_date.substring(with: NSRange(location: 4, length: 2))) + ("/") + (_date.substring(with: NSRange(location: 0, length: 4))) as NSString

        }
        return retdate
    }
    
   /* func getPrintDateTimeFormat(_date:NSString) -> NSString {
       // var retdate:NSString = ""
    do {
       //sw Pending
        /*8retdate = _date.substring(with: NSRange(location: 6, length: 2)) + ("/") + (_date.substring(with: NSRange(location: 4, length: 2))) + ("/") + (_date.substring(with: NSRange(location: 0, length: 4))) + (" ") + (_date.substring(with: NSRange(location: 9, length: 2))) + (":") + (_date.substring(with: NSRange(location: 11, length: 2))) + (":") + (_date.substring(with: NSRange(location: 13, length: 2)))*/

        
       }
    
        }*/
    
    func formatadte(inpDate:NSString,withINT inpFmt:Int,withINT outamt:Int) -> NSString {
        var retdate:NSString = "";
        var fmtArray = ["yyyyMMdd", "ddMMyyyy", "dd-MM-yyyy", "dd/MM/yyyy", "yyyyMMdd HHmmss", "ddMMyyyy HHmmss", "dd-MM-yyyy HH:mm:ss", "dd/MM/yyyy HH:mm:ss"]
        do {
            if !("".isEqual(inpDate)) {
                let format = DateFormatter()
                format.date(from: fmtArray[inpFmt])
                let reqdate: Date? = format.date(from: inpDate as String as String)
                
                let reqformat = DateFormatter()
                format.date(from: fmtArray[outamt])

                if let aReqdate = reqdate {
                    retdate = reqformat.string(from: aReqdate) as NSString
                }
            }
            }
        return retdate
        }
    
func addDays(inpDateStr:NSString,withINT noofDays:Int)->NSString
{
   var retDate:NSString?
    
    do {
        let format:DateFormatter = DateFormatter()
   
        format.date(from: (DateTimeUtil_dateFormat_ as NSString) as String)
        let inpDate: Date? = format.date(from: inpDateStr as String)
        
        var dateComponents = DateComponents()
        dateComponents.day = noofDays
        
        var newDate: Date? = nil
        if let aDate = inpDate {
            newDate = Calendar.current.date(byAdding: dateComponents, to: aDate)
        }
        
        if let aDate = newDate {
            retDate = format.string(from: aDate) as NSString
        }
    }
    
    return retDate!
}
    
    func subDays(inpDateStr:NSString,withINT noofDays:Int) -> NSString {
        var retDate:NSString?
        
        do {
            let format:DateFormatter = DateFormatter()
            
            format.date(from: (DateTimeUtil_dateFormat_ as NSString) as String)
            let inpDate: Date? = format.date(from: inpDateStr as String)
            
            var dateComponents = DateComponents()
            dateComponents.day = noofDays * -1
            
            var newDate: Date? = nil
            if let aDate = inpDate {
                newDate = Calendar.current.date(byAdding: dateComponents, to: aDate)
            }
            
            if let aDate = newDate {
                retDate = format.string(from: aDate) as NSString
            }
        }
        return retDate!
        
        
    }
    
    func addmonths(inpDateStr:NSString, withINt noofMons:Int) -> NSString {
        var retDate:NSString?
        
        do {
            let format:DateFormatter = DateFormatter()
            
            format.date(from: (DateTimeUtil_dateFormat_ as NSString) as String)
            let inpDate: Date? = format.date(from: inpDateStr as String)
            
            var dateComponents = DateComponents()
            dateComponents.month = noofMons
            
            var newDate: Date? = nil
            if let aDate = inpDate {
                newDate = Calendar.current.date(byAdding: dateComponents, to: aDate)
            }
            
            if let aDate = newDate {
                retDate = format.string(from: aDate) as NSString
            }
        }
        return retDate!
        
        
    }
    
    func subMonths(inpDateStr:NSString, withINt noofMons:Int) -> NSString {
        var retDate:NSString?
        
        do {
            let format:DateFormatter = DateFormatter()
            
            format.date(from: (DateTimeUtil_dateFormat_ as NSString) as String)
            let inpDate: Date? = format.date(from: inpDateStr as String)
            
            var dateComponents = DateComponents()
            dateComponents.month = noofMons * -1
            
            var newDate: Date? = nil
            if let aDate = inpDate {
                newDate = Calendar.current.date(byAdding: dateComponents, to: aDate)
            }
            
            if let aDate = newDate {
                retDate = format.string(from: aDate) as NSString
            }
        }
        return retDate!
    }
 }



