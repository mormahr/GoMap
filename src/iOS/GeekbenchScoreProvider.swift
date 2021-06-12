//
//  GeekbenchScoreProvider.swift
//  Go Map!!
//
//  Created by Wolfgang Timme on 2/16/20.
//  Copyright © 2020 Bryce Cogswell. All rights reserved.
//

import Foundation

class GeekbenchScoreProvider {

	func geekbenchScore() -> Double {
		return GeekbenchScoreProvider.score
	}

	static var score: Double = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let name = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        let dict = [
            "x86_64": NSNumber(value: 4000)    /* Simulator */,
            "i386": NSNumber(value: 4000)      /* Simulator */,
            "iPad5,4": NSNumber(value: 0)      /* iPad Air 2 */,
            "iPad4,5": NSNumber(value: 2493)   /* iPad Mini (2nd Generation iPad Mini - Cellular) */,
            "iPad4,4": NSNumber(value: 2493)   /* iPad Mini (2nd Generation iPad Mini - Wifi) */,
            "iPad4,2": NSNumber(value: 2664)   /* iPad Air 5th Generation iPad (iPad Air) - Cellular */,
            "iPad4,1": NSNumber(value: 2664)   /* iPad Air 5th Generation iPad (iPad Air) - Wifi */,
            "iPad3,6": NSNumber(value: 1402)   /* iPad 4 (4th Generation) */,
            "iPad3,5": NSNumber(value: 1402)   /* iPad 4 (4th Generation) */,
            "iPad3,4": NSNumber(value: 1402)   /* iPad 4 (4th Generation) */,
            "iPad3,3": NSNumber(value: 492)    /* iPad 3 (3rd Generation) */,
            "iPad3,2": NSNumber(value: 492)    /* iPad 3 (3rd Generation) */,
            "iPad3,1": NSNumber(value: 492)    /* iPad 3 (3rd Generation) */,
            "iPad2,7": NSNumber(value: 490)    /* iPad Mini (Original) */,
            "iPad2,6": NSNumber(value: 490)    /* iPad Mini (Original) */,
            "iPad2,5": NSNumber(value: 490)    /* iPad Mini (Original) */,
            "iPad2,4": NSNumber(value: 492)    /* iPad 2 */,
            "iPad2,3": NSNumber(value: 492)    /* iPad 2 */,
            "iPad2,2": NSNumber(value: 492)    /* iPad 2 */,
            "iPad2,1": NSNumber(value: 492)    /* iPad 2 */,
            "iPhone7,2": NSNumber(value: 2855) /* iPhone 6+ */,
            "iPhone7,1": NSNumber(value: 2879) /* iPhone 6 */,
            "iPhone6,2": NSNumber(value: 2523) /* iPhone 5s (model A1457, A1518, A1528 (China), A1530 | Global) */,
            "iPhone6,1": NSNumber(value: 2523) /* iPhone 5s model A1433, A1533 | GSM) */,
            "iPhone5,4": NSNumber(value: 1240) /* iPhone 5c (model A1507, A1516, A1526 (China), A1529 | Global) */,
            "iPhone5,3": NSNumber(value: 1240) /* iPhone 5c (model A1456, A1532 | GSM) */,
            "iPhone5,2": NSNumber(value: 1274) /* iPhone 5 (model A1429, everything else) */,
            "iPhone5,1": NSNumber(value: 1274) /* iPhone 5 (model A1428, AT&T/Canada) */,
            "iPhone4,1": NSNumber(value: 405)  /* iPhone 4S */,
            "iPhone3,1": NSNumber(value: 206)  /* iPhone 4 */,
            "iPhone2,1": NSNumber(value: 150)  /* iPhone 3GS */,
            "iPod5,1": NSNumber(value: 410)    /* iPod Touch (Fifth Generation) */,
            "iPod4,1": NSNumber(value: 209)
        ]
		let value = dict[name]?.doubleValue ?? 2500.0
        return value
    }()
}
