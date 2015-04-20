var exec = require('cordova/exec');

exports.getDeviceMeta = function(success, error) {
    exec(success, error, "DeviceMeta", "getDeviceMeta", []);
};
