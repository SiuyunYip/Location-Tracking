//
//  FileManager.swift
//  Location
//
//  Created by zerenyip on 2022/10/21.
//

import Foundation

class LocalFileManager {
    static let instance = LocalFileManager()
    
    func saveText(_ content: String) {
        let text = content
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let fileURL = dir.appendingPathComponent("LongitudeLatitude.txt")
            print("===========================")
            print(fileURL.path)
            //writing
            if !FileManager.default.fileExists(atPath: fileURL.path) {
                do {
                        try content.write(to: fileURL, atomically: false, encoding: .utf8)
                    }
                catch {
                    print("data writing error")
                }
            } else {
                if let handle = try? FileHandle(forWritingTo: fileURL) {
                    handle.seekToEndOfFile() // moving pointer to the end
                    handle.write(content.data(using: .utf8)!) // adding content
                    handle.closeFile() // closing the file
                }
            }
        }
    }
}
