//
//  BLEViewController.swift
//  RestEaze
//
//  Created by William Jones on 7/20/21.
//

import UIKit
import CoreBluetooth

class BLEViewController: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    @IBOutlet weak var ConnectionStatus: UILabel!
    
    // Used to refer to the centralManager
    var centralManager: CBCentralManager!
    
    // Used to refer to the peripheral device
    var RestEaze: CBPeripheral?
    
    //UUIDs for the service and characteristic we are trying to access in the iphone
    let timeService = CBUUID(string: "726831D4-4F80-4C2C-B0C7-DCEA6346C53D")
    let charUUID = CBUUID(string: "61445567-26B9-4877-9D04-89E79982F313")

    override func viewDidLoad() {
        super.viewDidLoad()
        // Initializes cnetralManager variable
        centralManager = CBCentralManager(delegate: self, queue: nil)
        // Sets the connection status label until there is a connection
        ConnectionStatus.text = "Connection Status: Disconnected"
    }

    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == CBManagerState.poweredOn {
            print("BLE powered on")
            // when we scan for services
            central.scanForPeripherals(withServices: nil, options: nil)
        }
        else{
            print("Something is wrong with BLE")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        // Checks name of the device found by the central manager
        if let pname = peripheral.name{
            print(pname)
        if pname == "Apple TV"{
            self.centralManager.stopScan()

            self.RestEaze = peripheral
            self.RestEaze?.delegate = self

            self.centralManager.connect(peripheral, options: nil)
            }
        }
    }
    
    // Called when a device is connected
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.delegate = self
        // This is where service uuids would be passed
        peripheral.discoverServices([timeService])
        print("\(String(describing: peripheral.name)) Connected to your device")
        // Changes label in the UI
        ConnectionStatus.text = "Connection Status: Connected"
    }
    
    // Called when a service is discovered
    func peripheral(_ peripheral : CBPeripheral, didDiscoverServices error: Error?){
        if let service = peripheral.services?.first(where: {$0.uuid == timeService}){
            peripheral.discoverCharacteristics([charUUID], for: service)
            }
        }
    
    // Called when a characteristic is discovered
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if let characteristic = service.characteristics?.first(where: {$0.uuid == charUUID}){
            peripheral.readValue(for: characteristic)
        }
    }
    
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if let data = characteristic.value {
            let value : Int = data.withUnsafeBytes{ $0.pointee }
            let hexValue = String(format: "%02X", value)
            
//            DataTransfered.text = "Data Transfered: " + String(hexValue)
        }
    }
}


