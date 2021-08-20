//
//  Database.swift
//  RestEaze
//
//  Created by William Jones on 7/30/21.
//

import Foundation
import SQLite3

class DatabaseHandler{
    var database : OpaquePointer?
    var path : String = "RestEazeDB.sqlite"
    init() {
    
    }
    var currentTableName = "something temporary"
    private var KEY_ID = "id"
    private var KEY_COUNTER = "counter"
    private var KEY_TIMESTAMP = "timestamp"
    private var KEY_FIELDS = "FIELDS"
    private var KEY_CAP_1 = "CAP1"
    private var KEY_CAP_2 = "CAP2"
    private var KEY_CAP_3 = "CAP3"
    private var KEY_ACC_X = "ACCLX"
    private var KEY_ACC_Y = "ACCLY"
    private var KEY_ACC_Z = "ACCLZ"
    private var KEY_GYRO_X = "GYROX"
    private var KEY_GYRO_Y = "GYROY"
    private var KEY_GYRO_Z = "GYROZ"
    private var KEY_MAG_X = "MAGX"
    private var KEY_MAG_Y = "MAGY"
    private var KEY_MAG_Z = "MAGZ"
    private var KEY_LED_IR = "LEDIR"
    private var KEY_LED_RED = "LEDRED"
    private var KEY_LED_GREEN = "LEDGREEN"
    private var KEY_HEART_RATE = "HEARTRATE"
    private var KEY_BLOOD_OXYGEN_LEVEL = "BLOODOXYGENLEVEL"
    private var KEY_CONFIDENCE_LEVEL = "CONFIDENCELEVEL"
    private var KEY_RESP_RATE = "RESPRATE"
    private var KEY_OBJECT_TEMPERATURE = "OBJECT_TEMPERATURE"
    private var KEY_AMBIENT_TEMPERATURE = "AMBIENT_TEMPERATURE"
    private var KEY_SYNC = "SYNCSTATE"
    
    func createDatabase() -> OpaquePointer? {
        let filepath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathExtension(path)
        
        var database : OpaquePointer? = nil
        
        if sqlite3_open(filepath.path, &database) != SQLITE_OK{
            print("error creating database")
            return nil
        }else{
            print("database has been created with path \(path)")
            return database
        }
    }
    
    
    func createTable() {
        let resteazeTable = "CREATE TABLE IF NOT EXISTS "
            + currentTableName + "("
            + KEY_ID + " INTEGER PRIMARY KEY AUTOINCREMENT, "
            + KEY_COUNTER + " INTEGER,"
            + KEY_TIMESTAMP + " REAL,"
            + KEY_FIELDS + " INTEGER,"
            + KEY_CAP_1 + " INTEGER,"
            + KEY_CAP_2 + " INTEGER,"
            + KEY_CAP_3 + " INTEGER,"
            + KEY_ACC_X + " INTEGER,"
            + KEY_ACC_Y + " INTEGER,"
            + KEY_ACC_Z + " INTEGER,"
            + KEY_GYRO_X + " INTEGER,"
            + KEY_GYRO_Y + " INTEGER,"
            + KEY_GYRO_Z + " INTEGER,"
            + KEY_MAG_X + " INTEGER,"
            + KEY_MAG_Y + " INTEGER,"
            + KEY_MAG_Z + " INTEGER,"
            + KEY_LED_IR + " INTEGER ,"
            + KEY_LED_RED + " INTEGER ,"
            + KEY_LED_GREEN + " INTEGER ,"
            + KEY_HEART_RATE + " INTEGER,"
            + KEY_BLOOD_OXYGEN_LEVEL + " INTEGER,"
            + KEY_CONFIDENCE_LEVEL + " INTEGER,"
            + KEY_RESP_RATE + " INTEGER,"
            + KEY_OBJECT_TEMPERATURE + " INTEGER,"
            + KEY_AMBIENT_TEMPERATURE + " INTEGER,"
            + KEY_SYNC + " INTEGER "
            + ")"
        var createTable : OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.database, resteazeTable, -1, &createTable, nil) == SQLITE_OK {
            print("table created")
        }else{
            print("error creating table")
        }
    }
}
