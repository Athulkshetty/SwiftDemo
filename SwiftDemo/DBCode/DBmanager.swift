//
//  DBmanager.swift
//  SwiftDemo
//
//  Created by LCode Technologies on 22/11/18.
//  Copyright © 2018 Lcodetechnologies. All rights reserved.
//

import UIKit

class DBmanager: NSObject {
    
    private static let instance = DBmanager()
    let appreferce = apppreference()
    var databasePath = String()
    var success:Bool?
    var defaultDBPath = String()
    var editableSQLfile = String()
    var database: FMDatabase!
    var cString:Character?
    var databasenew:sqlite3_vfs? = nil
    var actypeselect:NSString?
    var datetimeutilobj:DateTimeUtil?


    
    class var sharedInstance: DBmanager
    {
        struct Static {
            static var instance : DBmanager? = nil
        }
        Static.instance = DBmanager()
        
        return Static.instance!
    }
    
    func dbpath() -> String {
        
        let filemgr = FileManager.default
        let dirPaths = filemgr.urls(for: .documentDirectory,
                                    in: .userDomainMask)
        databasePath = dirPaths[0].appendingPathComponent("csbepbkdbswift.sqlite3").path
        return databasePath
        
    }
    
    func initWithdbFile()
    {
        // Move database file from bundle to documents folder
        
        let fileManager = FileManager.default
        
        let documentsUrl = fileManager.urls(for: .documentDirectory,
                                            in: .userDomainMask)
        
        guard documentsUrl.count != 0 else {
            return // Could not find documents URL
        }
        
        let finalDatabaseURL = documentsUrl.first!.appendingPathComponent("csbepbkdbswift.sqlite3")
        
        if !( (try? finalDatabaseURL.checkResourceIsReachable()) ?? false) {
            print("DB does not exist in documents folder")
            
            let documentsURL = Bundle.main.resourceURL?.appendingPathComponent("csbepbkdbswift.sqlite3")
            
            do {
                try fileManager.copyItem(atPath: (documentsURL?.path)!, toPath: finalDatabaseURL.path)
            } catch let error as NSError {
                print("Couldn't copy file to final location! Error:\(error.description)")
            }
            
        } else {
            print("Database file found at path: \(finalDatabaseURL.path)")
        }
        
   }
    func createtableScripts()
    {
        let arr:NSMutableArray = NSMutableArray()
        let createlcodeuseracs = "CREATE TABLE LCODEPB_USERACS ( USERAC_IMEI TEXT,  USERACS_USERID         TEXT,RUN_NO TEXT,  USERACS_FULLACNUM           TEXT,  USERACS_EFF_DATE                DATE,  USERACS_BRNCODE                TEXT,  USERACS_ACTYPE                TEXT,  USERACS_SUBTYPE                  TEXT,  USERACS_ACNUM                    TEXT,  USERACS_ACNAME                  TEXT,  USERACS_CURRCODE              TEXT,  USERACS_BAL                       TEXT,  USERACS_ACOPDATE              TEXT,  USERACS_PERIOD                    INTEGER,  USERACS_PERIOD_IDEN          TEXT,  USERACS_INTRATE              INTEGER,  USERACS_MAT_DATE              TEXT,  USERACS_AMT        TEXT,  USERACS_MAT_AMT    TEXT,  USERACS_REPAY_CLAUSE      TEXT,  USERACS_INST_AMT               TEXT,  USERACS_INST_FREQ              TEXT,  USERACS_INST_FROM_DATE          TEXT,  USERACS_LIMIT_AMT        TEXT,  USERACS_DRAWING_POWER    TEXT,  USERACS_INS_PREM_DATE    DATE,  USERACS_STOCK_DATE        TEXT,  USERACS_ODFORM_DATE        TEXT,  USERACS_RENEW_DATE        TEXT,  USERACS_EXP_DATE        TEXT, USERACS_AC_STATUS TEXT, PRIMARY KEY (USERACS_USERID,USERACS_FULLACNUM));";
        arr.add(createlcodeuseracs)
        
        let createlcodeusermbrn = "CREATE TABLE LCODEPB_MBRN ( MBRN_CODE        TEXT, MBRN_NAME        TEXT, MBRN_ADDR1       TEXT, MBRN_ADDR2       TEXT, MBRN_ADDR3       TEXT, MBRN_CITY        TEXT, MBRN_PHONE1      TEXT, MBRN_PHONE2      TEXT, MBRN_FAX         TEXT, MBRN_FROMTIME_FN TEXT, MBRN_UPTOTIME_FN TEXT, MBRN_FROMTIME_AN TEXT, MBRN_UPTOTIME_AN TEXT, MBRN_FROMTIME_HD TEXT, MBRN_UPTOTIME_HD TEXT, MBRN_WEEK_HOL    TEXT, MBRN_IFSC        TEXT, MBRN_MICR        TEXT, PRIMARY KEY (MBRN_CODE));";
        arr.add(createlcodeusermbrn)
        
        let createlcodeusertrans = "CREATE TABLE LCODEPB_TRAN( RUN_NO TEXT,REF_NUM TEXT,TRAN_ACNUM    TEXT,  TRAN_DATE    TEXT,TRAN_CBSREFNUM  TEXT, TRAN_ACBRN_CODE  TEXT, TRAN_VALUEDATE  TEXT, TRAN_DRCR    TEXT, TRAN_CURR    TEXT, TRAN_AMOUNT    TEXT, TRAN_ACBAL    TEXT, TRAN_CHQ_NUM  TEXT, TRAN_CHQ_DATE  TEXT, TRAN_REMARKS1   TEXT, TRAN_TYPE_OF_TRAN  TEXT, TRAN_UDA_ACNUM_FLG text, TRAN_NOTE_FLG    TEXT,  PRIMARY KEY(TRAN_ACNUM,TRAN_DATE,TRAN_CBSREFNUM));";
         arr.add(createlcodeusertrans)
        
        let createlcodeglcodepbacttpe = "create table G_LCODEPB_ACTYPE (                      ACTYPE_CODE              TEXT,                      ACTYPE_NAME       TEXT,                      ACTYPE_CLASS         TEXT, PRIMARY KEY (ACTYPE_CODE) ) ;";
        arr.add(createlcodeglcodepbacttpe)
        
        let createlcodeglcodeusers = "create table LCODEPB_USERS (USER_ID TEXT, USER_MOBILE_NO TEXT,                      USER_IMEI_NO  TEXT,USER_REGISTN_TIME TEXT,USER_LAST_ACCESS_TIME TEXT, USER_OTP TEXT, USER_MOBILE_PIN TEXT, USER_SYNC_DATE TEXT, USER_TRN_MAXDATE TEXT,    USER_NEWOTP_FLG TEXT, PRIMARY KEY (USER_ID,USER_MOBILE_NO) ) ;";
        arr.add(createlcodeglcodeusers)
        
        let createlcodeglcodepartymaster = "CREATE TABLE LCODEPB_PARTYMASTER (PARTYMAST_USERID TEXT, PARTYMAST_BRN_CODE TEXT, PARTYMAST_CLIENTCD TEXT, PARTYMAST_CLIENTNAME TEXT, PARTYMAST_ADDR1 TEXT, PARTYMAST_ADDR2 TEXT, PARTYMAST_ADDR3 TEXT, PARTYMAST_ADDR4 TEXT, PARTYMAST_CITY TEXT, PARTYMAST_TEL_MOB TEXT, PARTYMAST_TEL_RES TEXT, PARTYMAST_TEL_OFF TEXT, PARTYMAST_MAILID TEXT,PRIMARY KEY (PARTYMAST_USERID));";
        arr.add(createlcodeglcodepartymaster)
        
        let createlcodeglcodesetting = "CREATE TABLE LCODEPB_SETTINGS(                      SETTING_USER_ID            TEXT,                      SETTING_DEF_ACNUM            TEXT,                      SETTING_DISP_BAL            TEXT,                      SETTING_DISP_ORDER        TEXT,                      SETTING_TRANVIEW_COUNT    TEXT, SETTING_LANG TEXT, SETTING_HELP TEXT,SETTING_DISPPRD TEXT, PRIMARY KEY(SETTING_USER_ID));";
        arr.add(createlcodeglcodesetting)
        
        let createlcodeglcodepbudatran = "CREATE TABLE LCODEPB_UDATRAN(UDAT_USERID TEXT,UDAT_UDA_ACNUM TEXT,UDAT_SL NUMBER,UDAT_TRANDT TEXT,UDAT_TRANAMT TEXT,UDAT_DRCR TEXT,UDAT_REMARKS TEXT,PRIMARY KEY (UDAT_USERID,UDAT_UDA_ACNUM,UDAT_SL));";
        arr.add(createlcodeglcodepbudatran)
        
        let createlcodeglcodepbudanotes = "CREATE TABLE LCODEPB_TRAN_UDANOTE(TRAN_UDAN_ACNUM TEXT,TRAN_UDAN_DATE TEXT,TRAN_UDAN_CBSREFNUM TEXT,TRAN_UDAN_HEAD_CODE TEXT,TRAN_UDAN_NOTE TEXT,TRAN_UDAN_SRL NUMBER,PRIMARY KEY(TRAN_UDAN_ACNUM,TRAN_UDAN_DATE,TRAN_UDAN_CBSREFNUM));"
        arr.add(createlcodeglcodepbudanotes)
        
        let createlcodeglcodepbuda = "CREATE TABLE LCODEPB_UDA (UDA_USERID  TEXT,UDA_UDA_ACNUM  TEXT,UDA_CURRCODE  TEXT,UDA_ACOPDT  TEXT,UDA_OPBAL  TEXT,UDA_DRCR  TEXT,UDA_CLSBAL  TEXT,UDA_REMARKS  TEXT,PRIMARY KEY (UDA_USERID,UDA_UDA_ACNUM));";
        arr.add(createlcodeglcodepbuda)
        
        let createlcodeglcodepbuseraddress = "CREATE TABLE LCODEPB_USERADDR (USERA_USERID  TEXT,USERA_PARTY_CODE  TEXT,USERA_BRN_CODE    TEXT,USERA_NAME  TEXT,USERA_ADDR1  TEXT,USERA_ADDR2  TEXT,USERA_ADDR3  TEXT,USERA_ADDR4    TEXT,USERA_CITY        TEXT,USERA_STATE   TEXT,USERA_PINCCODE  TEXT,USERA_CNTRY   TEXT,USERA_PHONE_RESI  TEXT,USERA_PHONE_WORK  TEXT,USERA_MAIL_ID  TEXT,USERA_MOB_NO   TEXT,PRIMARY KEY (USERA_USERID, USERA_PARTY_CODE, USERA_BRN_CODE))";
        arr.add(createlcodeglcodepbuseraddress)
        
        let createlcodeglcodestate = "CREATE TABLE STATE(HOLSTAT_CODE TEXT,HOLSTAT_NAME TEXT,HOLSTAT_UT_FLG TEXT,HOLSTAT_KEY NUMBER,PRIMARY KEY (HOLSTAT_CODE))";
        arr.add(createlcodeglcodestate)
        
        let createlcodeglcodeholiday = "CREATE TABLE HOLIDAY(HOLSTATD_SL NUMBER,HOLSTATD_DATE TEXT,HOLSTATD_HOLIDTLS TEXT,HOLSTATD_GLOBHOL TEXT,HOLSTATD_KEY NUMBER,PRIMARY KEY (HOLSTATD_SL))";
        arr.add(createlcodeglcodeholiday)
        
        let createlcodeglcodeholidaystate = "CREATE TABLE HOLIDAY_STATE(HOLSTATDS_SL NUMBER,HOLSTATDS_DTL_SL  NUMBER,HOLSTATDS_CODE TEXT,PRIMARY KEY (HOLSTATDS_SL, HOLSTATDS_DTL_SL))";
        arr.add(createlcodeglcodeholidaystate)
        
        let createlcodeglcodemnotify =  "CREATE TABLE MNOTIFY(MNOT_SEQ_NUM VARCHAR2(25) NOT NULL,MNOT_DTL_SL  NUMBER(3) NOT NULL,MNOT_USER_ID VARCHAR2(20),MNOT_DATE    DATE,MNOT_MSG     VARCHAR2(500), MNOT_DELETE  CHAR(1),PRIMARY KEY (MNOT_SEQ_NUM, MNOT_DTL_SL))";
        
        arr.add(createlcodeglcodemnotify)
        
        let createlcodeglcodeoffers = "CREATE TABLE OFFERS(OFFER_SL TEXT,OFFER_DESCN TEXT,OFFER_URL TEXT,PRIMARY KEY(OFFER_SL))";
        arr.add(createlcodeglcodeoffers)
        
        let createlcodeglcodemaplocation = "CREATE TABLE MAP_LOCATION(MAP_SERAIL            TEXT,MAP_CODE                 TEXT,MAP_TYPE                TEXT,MAP_NAME                TEXT,MAP_STATE             TEXT,MAP_CITY                TEXT,MAP_ADDRESS                TEXT,MAP_LONGITUDE            TEXT,MAP_LATITUDE            TEXT,MAP_LOCATION            TEXT,MAP_PINCODE                  TEXT,MAP_STATE_CODE            TEXT,MAP_CITY_CODE            TEXT,PRIMARY KEY(MAP_CODE,MAP_TYPE));";
        arr.add(createlcodeglcodemaplocation)
        
        let createlcodeglcodepbparam = "CREATE TABLE LCODEPB_PARAM(LCODEPB_PARAM_KEY TEXT,LCODEPB_PARAM1 TEXT,LCODEPB_PARAM2 TEXT,LCODEPB_PARAM3 TEXT,LCODEPB_PARAM4 TEXT,LCODEPB_PARAM5 TEXT,LCODEPB_PARAM6 TEXT,LCODEPB_PARAM7 TEXT,LCODEPB_PARAM8 TEXT,LCODEPB_PARAM9 TEXT,LCODEPB_PARAM10 TEXT,PRIMARY KEY(LCODEPB_PARAM_KEY))";
        arr.add(createlcodeglcodepbparam)
        
      
        insertQuery(query: arr)
    }
    
    func setlcodepbuda() -> Void
    {
        database = FMDatabase(path: dbpath())
        database.open()
        let array = getSelectcommonData(sqlquery: "\("SELECT * FROM LCODEPB_UDA WHERE UDA_USERID = '")\(appreferce.getUserID())\("'")" as NSString)
        if array.count == 0 {
            accDetailsub()
        }
        database.close()
        deletetmp()
        
    }
    func accDetailsub() -> Void{
        
        database = FMDatabase(path: dbpath())
        database.open()
        var query:NSString = ""
        var flg:NSString = ""
        query = NSString(format: "\("select * from LCODEPB_UDA where UDA_USERID ="), \(appreferce.getUserID()),\("'")" as NSString)
        let results:FMResultSet = database.executeQuery(query as String?, withArgumentsIn: nil)
        while results.next()
        {
            print("\(results.string(forColumn:"UDA_USERID"))")
            print("\(results.string(forColumn:"UDA_UDA_ACNUM"))")
            flg = "1";
        }
        database.close()
        
        let personlledgearr:NSMutableArray = NSMutableArray()
        var str:NSString = "INSERT OR REPLACE INTO LCODEPB_UDA VALUES('LCODE', 'Education', 'INR','20130101','0','D','0','')"
          personlledgearr.add(str)
        str = "INSERT OR REPLACE INTO LCODEPB_UDA VALUES('LCODE', 'Food', 'INR','20150101','0','D','0','')";
         personlledgearr.add(str)
        str="INSERT OR REPLACE INTO LCODEPB_UDA VALUES('LCODE', 'Fuel', 'INR','20150101','0','D','0','')";
        personlledgearr.add(str)
        str="INSERT OR REPLACE INTO LCODEPB_UDA VALUES('LCODE', 'Grocery', 'INR','20150101','0','D','0','')";
        personlledgearr.add(str)
        str="INSERT OR REPLACE INTO LCODEPB_UDA VALUES('LCODE', 'Health', 'INR','20150101','0','D','0','')";
        personlledgearr.add(str)
        str="INSERT OR REPLACE INTO LCODEPB_UDA VALUES('LCODE', 'Travel', 'INR','20150101','0','D','0','')";
        personlledgearr.add(str)
        insertQuery(query: personlledgearr)
        
        let userid:NSString = appreferce.getUserID()
        if !userid.isEqual(to: "")
        {
            let arr1:NSMutableArray = NSMutableArray()
            str = NSString(format:"\("UPDATE LCODEPB_UDA SET UDA_USERID = '"),\(appreferce.getUserID()), \("' WHERE UDA_USERID = 'LCODE'")" as NSString)
            arr1.add(str)
            insertQuery(query: arr1)
        }
        
    }
    func deletetmp() -> Void {
        let arr2:NSMutableArray = NSMutableArray()
        let str2:NSString =  "\("DELETE FROM LCODEPB_UDA WHERE UDA_USERID =") ''" as NSString
        arr2.add(str2)
        insertQuery(query: arr2)
        
    }
    func getSelectcommonData(sqlquery:NSString) -> NSMutableArray
    {
       let accountArray:NSMutableArray = NSMutableArray()
        database = FMDatabase(path: dbpath())
        database.open()
        let results: FMResultSet? = database.executeQuery(sqlquery as String?, withArgumentsIn: nil)
        while (results?.next())!{
            print("inside")
            let nsdict:NSMutableDictionary = (results?.columnNameToIndexMap)!
            
            let columnnames:NSEnumerator = nsdict.keyEnumerator()
        
            let columnname:NSString? = nil
            while (columnname == columnnames.nextObject() as? NSString)
            {
                let objectname:CprKeyPair = CprKeyPair()
                objectname.keyName = columnname
                objectname.keyPair = results?.string(forColumn: columnname! as String)! as NSString?
                accountArray.add(objectname)
            }
        }
        database.close()
        return accountArray
    }
    func insertQuery(query:NSMutableArray) -> Void
    {
        database = FMDatabase(path: dbpath())
        database.open()
        for str in query
        {
            let executeUpdate = database.executeUpdate(str as! String, withArgumentsIn: nil)
            if(executeUpdate)
            {
               print("updated")
            }
            else{
                  print("\(str)Nott----->updated")
            }
        }
        database.close()
    }

func deletecifdetails() -> Void
{
    let deletearray:NSMutableArray = NSMutableArray()
    let strDEL1:NSString = NSString(format: "DELETE FROM LCODEPB_USERACS WHERE USERACS_USERID = \( appreferce.getUserID())" as NSString)
    deletearray.add(strDEL1)
    
    let strDEL2:NSString = NSString(format: "DELETE FROM LCODEPB_USERS WHERE USER_ID = \( appreferce.getUserID())" as NSString)
    deletearray.add(strDEL2)
    
    let strDEL3:NSString = NSString(format: "DELETE FROM LCODEPB_PARTYMASTER WHERE PARTYMAST_USERID = \( appreferce.getUserID())" as NSString)
    deletearray.add(strDEL3)
    
    let strDEL4:NSString = NSString(format: "DELETE FROM LCODEPB_SETTINGS WHERE SETTING_USER_ID = \( appreferce.getUserID())" as NSString)
    deletearray.add(strDEL4)
    
    let strDEL5:NSString = NSString(format: "DELETE FROM LCODEPB_UDATRAN WHERE UDAT_USERID =\( appreferce.getUserID())" as NSString)
    deletearray.add(strDEL5)
    
    let strDEL6:NSString = NSString(format: "DELETE FROM LCODEPB_UDA WHERE UDA_USERID =  \( appreferce.getUserID())" as NSString)
    deletearray.add(strDEL6)
    
    let strDEL7:NSString = NSString(format: "DELETE FROM LCODEPB_USERADDR WHERE USERA_USERID =  \( appreferce.getUserID())" as NSString)
    deletearray.add(strDEL7)
    
    let strDEL8:NSString = NSString(format: "DELETE FROM LCODEPB_DOMAINUSR WHERE USERDOMN_USERID = \( appreferce.getUserID())" as NSString)
    deletearray.add(strDEL8)
    insertQuery(query: deletearray)
}
 
  func deleteuseracs(userid:NSString) -> Void{
    let deluseracsarray:NSMutableArray = NSMutableArray()
    let strDEL:NSString = NSString(format: "DELETE FROM LCODEPB_USERACS WHERE USERACS_USERID = \(userid)" as NSString)
    deluseracsarray.add(strDEL)
     insertQuery(query: deluseracsarray)
 }

  func fetchusermobnumdetails() -> NSString {
       
        var mobnum:NSString?
         database = FMDatabase(path: dbpath())
        database.open()
        
        let query:NSString = NSString(format: "select USER_MOBILE_NO from lcodepb_users where USER_ID =\(appreferce.getUserID())" as NSString)
        
        let results:FMResultSet = database.executeQuery(query as String?, withArgumentsIn: nil)
        while results.next()
        {
            print("\(results.string(forColumn:"USER_MOBILE_NO"))")
            mobnum = results.string(forColumn:"USER_MOBILE_NO")! as NSString
        }
        database.close()
        return mobnum!
        
 }

    func insertDomainUsr(userid:NSString, domainid:NSString) -> Void {
        let domainarr:NSMutableArray = NSMutableArray()
       
        let str:NSString = NSString(format:"\("INSERT OR REPLACE INTO LCODEPB_DOMAINUSR (USERDOMN_USERID,USERDOMN_DOMID) VALUES ('"),\(userid),\("',"),\("',"),\(domainid),\("')")" as NSString)
        domainarr.add(str)
        insertQuery(query: domainarr)
       
}
   
    func getAccountInfo() -> NSMutableArray
    {
        let accountarray:NSMutableArray = NSMutableArray()
        database = FMDatabase(path: dbpath())
        database.open()
        let results:FMResultSet = database.executeQuery("SELECT * FROM G_LCODEPB_ACTYPE ORDER BY ACTYPE_CLASS DESC", withArgumentsIn: nil)
        while results.next()
        {
            print("\(results.string(forColumn: "ACTYPE_CLASS"))")
            let dict:NSMutableDictionary = NSMutableDictionary()
            let objectname:AccountType = AccountType()
            objectname.ACTYPE_CODE = results.string(forColumn: "ACTYPE_CODE") as NSString?
            let getTransactionInfo:NSMutableArray = selectAccountDetails(acttype: objectname.ACTYPE_CODE!)
            objectname.ACTYPE_NAME = results.string(forColumn: "ACTYPE_NAME") as NSString?
            objectname.ACTYPE_CLASS = results.string(forColumn: "ACTYPE_CLASS") as NSString?
            actypeselect = results.string(forColumn: "ACTYPE_CLASS")as NSString?
            dict.setObject(objectname, forKey: "AccountType" as NSCopying)
            dict.setObject(getTransactionInfo, forKey: "TransInfo" as NSCopying)
            accountarray.add(dict)
        }
        database.close()
        return accountarray
        
    }
    func selectAccountDetails(acttype:NSString) -> NSMutableArray {
        let accountArray:NSMutableArray = NSMutableArray()
        let database:FMDatabase = FMDatabase(path: dbpath())
        database.open()
        
        let results:FMResultSet = database.executeQuery(NSString(format:"SELECT * FROM LCODEPB_USERACS,G_LCODEPB_ACTYPE WHERE USERACS_ACTYPE = \(NSString.init(string: acttype)) AND USERACS_USERID = \(appreferce.getUserID()) AND ACTYPE_CODE = USERACS_ACTYPE ORDER BY USERACS_FULLACNUM ASC" as NSString) as String?, withArgumentsIn: nil)
        while results.next(){
            print("\(results.string(forColumn: "ACTYPE_CODE"))")
            print("\(results.string(forColumn: "USERACS_USERID"))")
            print("\(results.string(forColumn: "USERACS_ACTYPE"))")
            
            let objectname:UserAccount = UserAccount()
            objectname.USERACS_USERID = results.string(forColumn: "USERACS_EXP_DATE")as NSString?
            objectname.USERACS_FULLACNUM = results.string(forColumn: "USERACS_FULLACNUM")as NSString?
            objectname.USERACS_EFF_DATE = results.string(forColumn: "USERACS_EFF_DATE")as NSString?
            objectname.USERACS_BRNCODE = results.string(forColumn: "USERACS_BRNCODE")as NSString?
            objectname.USERACS_ACTYPE = results.string(forColumn: "USERACS_ACTYPE")as NSString?
            objectname.USERACS_SUBTYPE = results.string(forColumn: "USERACS_SUBTYPE") as NSString?
            objectname.USERACS_ACNUM = results.string(forColumn: "USERACS_ACNUM")as NSString?
            objectname.USERACS_ACNAME = results.string(forColumn: "USERACS_ACNAME") as NSString?
            
            objectname.USERACS_CURRCODE = results.string(forColumn: "USERACS_CURRCODE") as NSString?
            objectname.USERACS_BAL = results.string(forColumn: "USERACS_BAL") as NSString?
            objectname.USERACS_ACOPDATE = results.string(forColumn: "USERACS_ACOPDATE") as NSString?
            objectname.USERACS_PERIOD = results.string(forColumn: "USERACS_PERIOD")as NSString?
            
            objectname.USERACS_EXP_DATE = results.string(forColumn: "USERACS_EXP_DATE") as NSString?
            objectname.USERACS_RENEW_DATE = results.string(forColumn: "USERACS_RENEW_DATE") as NSString?
            objectname.USERACS_ODFORM_DATE = results.string(forColumn: "USERACS_ODFORM_DATE") as NSString?
            objectname.USERACS_STOCK_DATE = results.string(forColumn: "USERACS_STOCK_DATE")as NSString?
            objectname.USERACS_INS_PREM_DATE = results.string(forColumn: "USERACS_INS_PREM_DATE") as NSString?
            objectname.USERACS_DRAWING_POWER = results.string(forColumn: "USERACS_DRAWING_POWER") as NSString?
            objectname.USERACS_LIMIT_AMT = results.string(forColumn: "USERACS_LIMIT_AMT") as NSString?
            objectname.USERACS_INST_FROM_DATE = results.string(forColumn: "USERACS_INST_FROM_DATE") as NSString?
            
            objectname.USERACS_INST_FREQ = results.string(forColumn: "USERACS_INST_FREQ") as NSString?
            objectname.USERACS_INST_AMT = results.string(forColumn: "USERACS_INST_AMT") as NSString?
            objectname.USERACS_REPAY_CLAUSE = results.string(forColumn: "USERACS_REPAY_CLAUSE")as NSString?
            objectname.USERACS_AMT = results.string(forColumn: "USERACS_AMT") as NSString?
            objectname.USERACS_MAT_DATE = results.string(forColumn: "USERACS_MAT_DATE") as NSString?
            objectname.USERACS_INTRATE = results.string(forColumn: "USERACS_INTRATE") as NSString?
            objectname.USERACS_PERIOD_IDEN = results.string(forColumn: "USERACS_PERIOD_IDEN") as NSString?
            
            objectname.USERACS_ACTYPE_CLASS = results.string(forColumn: "USERACS_ACTYPE_CLASS") as NSString?
            
            accountArray.add(objectname)
        }
        database.close()
        return accountArray
        
    }
    
    func getLCODEPB_PARAM() -> NSString {
        
        database = FMDatabase(path: dbpath())
        database.open()
        var strLCODEPB_PARAM1:NSString = ""
        
        let str:NSString = "SELECT LCODEPB_PARAM1 FROM LCODEPB_PARAM"
        let results:FMResultSet = database.executeQuery(str as String?, withArgumentsIn: nil)
        if results.next(){
            strLCODEPB_PARAM1 = results.string(forColumn:"LCODEPB_PARAM1")! as NSString
        }
        database.close()
        
        return strLCODEPB_PARAM1;
 
    }
    func getTransactionInfo() -> NSMutableArray {
        
        let array:NSMutableArray = selectTransactionData()
        return array
    }
    
    func selectTransactionData() -> NSMutableArray {
        
        let transactionArray:NSMutableArray = NSMutableArray()
        database = FMDatabase(path: dbpath())
        database.open()
        let results:FMResultSet = database.executeQuery("SELECT * FROM LCODEPB_TRAN", withArgumentsIn: nil)
        while results.next(){
            let objectname:Transaction = Transaction()
            objectname.TRAN_ACBAL = results.string(forColumn: "TRAN_ACBAL") as NSString?
            objectname.TRAN_ACBRN_CODE = results.string(forColumn: "TRAN_ACBRN_CODE") as NSString?
            objectname.TRAN_ACNUM = results.string(forColumn: "TRAN_ACNUM") as NSString?
            objectname.TRAN_AMOUNT = results.string(forColumn: "TRAN_AMOUNT") as NSString?
            objectname.TRAN_CBSREFNUM = results.string(forColumn: "TRAN_CBSREFNUM") as NSString?
            objectname.TRAN_CHQ_DATE = results.string(forColumn: "TRAN_CHQ_DATE") as NSString?
            objectname.TRAN_CHQ_NUM = results.string(forColumn: "TRAN_CHQ_NUM") as NSString?
            objectname.TRAN_CURR = results.string(forColumn: "TRAN_CURR") as NSString?
            objectname.TRAN_DATE = results.string(forColumn: "TRAN_DATE") as NSString?
            objectname.TRAN_DRCR = results.string(forColumn: "TRAN_DRCR") as NSString?
            objectname.TRAN_NOTE_FLG = results.string(forColumn: "TRAN_NOTE_FLG") as NSString?
            objectname.TRAN_REMARKS1 = results.string(forColumn: "TRAN_REMARKS1") as NSString?
            objectname.TRAN_TYPE_OF_TRAN = results.string(forColumn: "TRAN_TYPE_OF_TRAN") as NSString?
            objectname.TRAN_UDA_ACNUM_FLG = results.string(forColumn: "TRAN_UDA_ACNUM_FLG") as NSString?
            objectname.TRAN_VALUEDATE = results.string(forColumn: "TRAN_VALUEDATE") as NSString?
         transactionArray.add(objectname)
        }
        database.close()
        return transactionArray
    }
    
    func getPartyString() -> NSString {
        
        var partyname:NSString?
        database = FMDatabase(path: dbpath())
        database.open()
        let results:FMResultSet = database.executeQuery(NSString(format: "SELECT PARTYMAST_CLIENTNAME FROM LCODEPB_PARTYMASTER WHERE PARTYMAST_USERID = \(appreferce.getUserID())" as NSString) as String?, withArgumentsIn: nil)
        
        while results.next()
        {
            partyname = results.string(forColumn: "PARTYMAST_CLIENTNAME")as NSString?
        }
        database.close()
        return partyname!
        
    }
    
    func getnotifycount() -> NSString {
        var _total_count :NSString?
        
      database = FMDatabase(path: dbpath())
        database.open()
        let results:FMResultSet = database.executeQuery("SELECT COUNT(0) ALTERCOUNT FROM MNOTIFY WHERE MNOT_DELETE != '1'", withArgumentsIn: nil)
        while results.next()
        {
            _total_count = results.string(forColumn: "ALTERCOUNT") as NSString?
        }
        database.close()
        return _total_count!
    }
    
    func getmaxmnotifseqnum() -> NSString {
        var max_srl:NSString?
        database = FMDatabase(path: dbpath())
        database.open()
        let results:FMResultSet = database.executeQuery("SELECT IFNULL(MAX(MNOT_SEQ_NUM),0)  MNOT_SEQ_NUM FROM MNOTIFY", withArgumentsIn: nil)
        while results.next() {
            max_srl = results.string(forColumn: "MNOT_SEQ_NUM")as NSString?
        }
        database.close()
        return max_srl!
    }
    func getPartyDetails() -> NSMutableArray {
        let partyArray:NSMutableArray = NSMutableArray()
        database  = FMDatabase(path: dbpath())
        database.open()
        let results:FMResultSet = database.executeQuery(NSString(format: "SELECT PARTYMAST_USERID,PARTYMAST_BRN_CODE,PARTYMAST_CLIENTCD,PARTYMAST_CLIENTNAME,                     PARTYMAST_ADDR1,PARTYMAST_ADDR2,PARTYMAST_ADDR3,PARTYMAST_ADDR4,PARTYMAST_CITY,PARTYMAST_TEL_MOB,                     PARTYMAST_TEL_RES,PARTYMAST_TEL_OFF,PARTYMAST_MAILID,MBRN_NAME FROM LCODEPB_PARTYMASTER,LCODEPB_MBRN WHERE PARTYMAST_BRN_CODE = MBRN_CODE AND PARTYMAST_USERID =  \(appreferce.getUserID())" as NSString) as String?, withArgumentsIn: nil)
        
        
        while results.next() {
            var objectname:CprKeyPair = CprKeyPair()
            
            objectname.keyName = appreferce.languageSelectedStringForKey(key: "lblBranch")
            objectname.keyPair = results.string(forColumn: "MBRN_NAME")! as NSString
            partyArray.add(objectname)
            
            objectname.keyName = appreferce.languageSelectedStringForKey(key: "lblCustomerCode")
            objectname.keyPair = results.string(forColumn: "PARTYMAST_CLIENTCD")! as NSString
            partyArray.add(objectname)
            
            objectname.keyName = appreferce.languageSelectedStringForKey(key: "lblName")
            objectname.keyPair = results.string(forColumn: "PARTYMAST_CLIENTNAME")! as NSString
            partyArray.add(objectname)
            
            let address1:NSString = results.string(forColumn: "PARTYMAST_ADDR1")! as NSString
            let address2:NSString = results.string(forColumn: "PARTYMAST_ADDR2")! as NSString
            let address3:NSString = results.string(forColumn: "PARTYMAST_ADDR3")! as NSString
            let address4:NSString = results.string(forColumn: "PARTYMAST_ADDR4")! as NSString
            let addressy:NSString = results.string(forColumn: "PARTYMAST_CITY")! as NSString
            let address:NSString = NSString(format: "\n\(address1)\n\(address2)\n\(address3)\n\(address4)\n\(addressy)" as NSString)
            
            objectname = CprKeyPair()
            objectname.keyName = appreferce.languageSelectedStringForKey(key: "lblAddress")
            objectname.keyPair = address;
            partyArray.add(objectname)
            
            objectname = CprKeyPair()
            objectname.keyName = appreferce.languageSelectedStringForKey(key: "lblMobile")
            objectname.keyPair = results.string(forColumn: "PARTYMAST_TEL_MOB")! as NSString
            partyArray.add(objectname)
            
            objectname = CprKeyPair()
            objectname.keyName = appreferce.languageSelectedStringForKey(key: "lblResidence")
            objectname.keyPair = results.string(forColumn: "PARTYMAST_TEL_RES")! as NSString
            partyArray.add(objectname)
            
            objectname = CprKeyPair()
            objectname.keyName = appreferce.languageSelectedStringForKey(key: "lblEmailid")
            objectname.keyPair = results.string(forColumn: "PARTYMAST_MAILID")! as NSString
            partyArray.add(objectname)
        }
        database.close()
        return partyArray
    }
    func getEachIndAccountColumns(sqlquery:NSString) -> NSMutableDictionary {
        
        database = FMDatabase(path: dbpath())
        database.open()
        var nsdict:NSMutableDictionary?
        let results:FMResultSet = database.executeQuery((sqlquery as String??)!, withArgumentsIn: nil)
        while results.next()
        {
            nsdict = results.columnNameToIndexMapActual()
        }
        database.close()
        return nsdict!
    }
    func getEachIndAccount(sqlquery:NSString) -> NSMutableArray {
        
        let nsdict:NSMutableDictionary = getEachIndAccountColumns(sqlquery: sqlquery)
        let accountArray:NSMutableArray = NSMutableArray()
        database = FMDatabase(path: dbpath())
        database.open()
        let results:FMResultSet = database.executeQuery(sqlquery as String?, withArgumentsIn: nil)
        while results.next() {
            let columnNames:NSEnumerator = nsdict.keyEnumerator()
            let columnName:NSString? = nil
            while(columnName == columnNames.nextObject() as? NSString){
                let objectname:CprKeyPair = CprKeyPair()
                objectname.keyName = columnName
                
                
                if (columnName?.isEqual(to: "Account Opening Date"))! || (columnName?.isEqual(to: "Effective Date"))! || (columnName?.isEqual(to: "Loan Date"))! || (columnName?.isEqual(to: "Maturity Date"))! || (columnName?.isEqual(to: "Due Date"))! || (columnName?.isEqual(to: "Instalment From Date"))!
                {
                    objectname.keyPair =
                        datetimeutilobj?.getDisplayFormatDate(actualval: results.string(forColumn: columnName?.lowercased)! as NSString)
                }
                else
                {
                    objectname.keyPair = results.string(forColumn: columnName?.lowercased)! as NSString
                    accountArray.add(objectname)
                    
                }
            }
            
        }
        database.close()
        return accountArray
    }
        
    func getEachIndAccount_withOrder(sqlquery:NSString, withacttype acnttype:NSString) -> NSMutableArray {
      
        let nsdict:NSMutableDictionary  = self.getEachIndAccountColumns(sqlquery: sqlquery);
        var accountarry:NSMutableArray = NSMutableArray()
        let database:FMDatabase = FMDatabase(path: self.dbpath())
        database.open()
        let results:FMResultSet = database.executeQuery(sqlquery as String?, withArgumentsIn: nil)
        var __UPDFLG :Bool = true
        var balbak:NSString = ""
        var limitamt:NSString = ""
        while results.next()
        {
            var columnNames:NSEnumerator = nsdict.keyEnumerator()
            var columnsName:NSString? = nil
            //Pending this has to later
         //   var mainarray:NSArray = [CpraccountdtlBookViewController getAccountColumnName];
            var mainarray:NSArray?
           
        }
     
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
