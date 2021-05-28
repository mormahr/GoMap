//
//  PresetGroup.swift
//  Go Map!!
//
//  Created by Bryce Cogswell on 12/12/20.
//  Copyright © 2020 Bryce. All rights reserved.
//

import Foundation

enum PresetKeyOrGroup {
	case key(PresetKey)
	case group(PresetGroup)
}

// A group of related tags, such as address tags, organized for display purposes
// A group becomes a Section in UITableView
final class PresetGroup {
	let name: String?				// e.g. Address
	let presetKeys: [PresetKeyOrGroup]
	let isDrillDown: Bool

	init(name: String?, tags: [PresetKeyOrGroup], isDrillDown: Bool = false) {
		self.name = name
		self.presetKeys = tags
		self.isDrillDown = isDrillDown
	}

	convenience init(fromMerger p1: PresetGroup, with p2: PresetGroup) {
		self.init(name: p1.name, tags: p1.presetKeys + p2.presetKeys)
	}

	var description: String {
		var text = "\(name ?? "<unknown>"):\n"
		for key in presetKeys {
			switch key {
			case let .key(key):	text += "   \(key.description)\n"
			case let .group(group):	text += "   \(group.description)\n"
			}
		}
		return text
	}

	func multiComboSummary(ofDict dict:[String:String]?, isPlaceholder:Bool) -> String
	{
		var summary = ""
		for preset in presetKeys {
			if let preset = preset as? PresetKey,
			   let values = preset.presetList,
			   values.count == 2,
			   values[0].tagValue == "yes",
			   values[1].tagValue == "no"
			{
				if let v = isPlaceholder ? "yes" : dict?[ preset.tagKey ],
				   OsmTags.isOsmBooleanTrue( v )
				{
					if summary.isEmpty {
						summary = preset.name
					} else {
						summary = summary + ", " + preset.name
					}
				}
			} else {
				// it's not a multiCombo
				return ""
			}
		}
		return summary
	}
}

