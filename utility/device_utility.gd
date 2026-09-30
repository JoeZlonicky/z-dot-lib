class_name DeviceUtility


static func is_web() -> bool:
	return OS.get_name() == "Web"


static func is_mobile() -> bool:
	return OS.get_name() == "Android" || OS.get_name() == "iOS"


static func is_mobile_web() -> bool:
	return OS.has_feature("web_android") || OS.has_feature("web_ios")
