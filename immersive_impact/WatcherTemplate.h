#pragma once
#include <string.h>

//THIS IS NOT A TEMPLATE CLASS/PARENT CLASS FOR WATCHERS
//I'm just a fucking lazy bitch so I decided to make this one for copy pasta.
//Copy & Paste this template for additional watchers.
class Watcher {
protected:
	static Watcher *instance;
	std::string className = "WatcherTemplate";
public:
	Watcher() {
		if (instance)
			delete(instance);
		instance = this;
		_MESSAGE((className + std::string(" instance created.")).c_str());
	}

	Watcher *GetInstance() {
		return instance;
	}
	virtual ~Watcher();

	static void InitHook();

	static void ResetHook();
};