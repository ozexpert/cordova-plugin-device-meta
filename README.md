# cordova-plugin-device-meta
Some device information for Cordova Apps (PhoneGap/Hybrid)

# Usage

    cordova.plugins.DeviceMeta.getDeviceMeta(function(result){
    	// result.debug - Whether App is in debug mode
    	// result.networkProvider - Network provider name
    	// result.ip - IP Address from device
    });