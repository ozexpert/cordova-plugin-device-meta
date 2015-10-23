# cordova-plugin-device-meta
Some device information for Cordova Apps (PhoneGap/Hybrid)
Currently supports only Android, and iOS

# Install 

```
cordova plugin add https://github.com/ozexpert/cordova-plugin-device-meta.git
```

# Usage

    cordova.plugins.DeviceMeta.getDeviceMeta(function(result){
    	// result.debug - Whether App is in debug mode
    	// result.networkProvider - Network provider name
    	// result.ip - IP Address from device
    	// result.manufacturer - Device manufacturer
    });
