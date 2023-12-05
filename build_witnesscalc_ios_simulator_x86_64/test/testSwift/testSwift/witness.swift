//
//  witness.swift
//  testSwift
//
//  Created by yushihang on 2023/11/28.
//

import Foundation
fileprivate let __witnesscalc_authV2 = witnesscalc_authV2

public func witnesscalc_authV2_ (
    circuit_buffer: Data,
    json_buffer: Data,
    wtns_buffer: inout Data,
    error_msg :inout String
) -> Int {
    
    return circuit_buffer.withUnsafeBytes { (circuit_buffer_c_bytes: UnsafeRawBufferPointer) in
        return json_buffer.withUnsafeBytes { (json_buffer_c_bytes: UnsafeRawBufferPointer) in
            var c_wtnsSize: UInt = 4 * 1024 * 1024
            //c_wtnsSize = 1
            var c_wtnsBuffer = [CChar](repeating: 0, count: Int(c_wtnsSize+1))
            
            let c_errorMaxSize: UInt = 256
            var c_errorMsg = [CChar](repeating: 0, count: Int(c_errorMaxSize+1))
            guard let circuit_buffer_c_bytes_ = circuit_buffer_c_bytes.baseAddress?.assumingMemoryBound(to: CChar.self),
                  let json_buffer_c_bytes_ = circuit_buffer_c_bytes.baseAddress?.assumingMemoryBound(to: CChar.self)
            else {

                return Int(WITNESSCALC_ERROR)
            }
            let result = __witnesscalc_authV2(
                circuit_buffer_c_bytes_,
                UInt(circuit_buffer.count),
                json_buffer_c_bytes_,
                UInt(json_buffer.count),
                &c_wtnsBuffer,
                &c_wtnsSize,
                &c_errorMsg, c_errorMaxSize
            )
            return Int(result)
        }
    }
    
}

public  func calculateWitnessAuth(
    wasmBytes: Data,
    inputsJsonBytes: Data
) -> Data? {
    
    var wtns_buffer = Data()
    var error_msg = ""
    let result = witnesscalc_authV2_(
        circuit_buffer: wasmBytes,
        json_buffer: inputsJsonBytes,
        wtns_buffer: &wtns_buffer,
        error_msg: &error_msg
    )
    
    switch Int32(result) {
    case WITNESSCALC_OK:
        return wtns_buffer
        
    case WITNESSCALC_ERROR:
        print("result:\(result) Error:\(error_msg)")
        
    case WITNESSCALC_ERROR_SHORT_BUFFER:
        print("result:\(result) Error:Short buffer for proof or public \(error_msg)")
        
    default:
        ()
    }
    
    
    return nil
    }
