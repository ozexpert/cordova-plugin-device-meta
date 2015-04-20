var exec = require('cordova/exec');

exports.getDeviceMeta = function(arg0, success, error) {
    exec(success, error, "DeviceMeta", "getDeviceMeta", [arg0]);
};
