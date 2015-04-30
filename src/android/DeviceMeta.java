package com.ozexpert.devicemeta;

import android.content.Context;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager.NameNotFoundException;
import android.net.wifi.WifiManager;
import android.telephony.TelephonyManager;

import java.util.Formatter;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 * This class echoes a string called from JavaScript.
 */
public class DeviceMeta extends CordovaPlugin {

    private static Context ctx;

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {

        ctx = this.cordova.getActivity().getApplicationContext();

        if (action.equals("getDeviceMeta")) {
            
            JSONObject r = new JSONObject();
            r.put("debug", this.isDebug());
            //r.put("ip", this.getIpAddress());
            r.put("networkProvider", this.getNetworkProvider());

            callbackContext.success(r);
        } else {
            return false;
        }
        return true;
    }

    private boolean isDebug() {
        try {
            if ((ctx.getPackageManager().getPackageInfo(
                ctx.getPackageName(), 0).applicationInfo.flags & 
                ApplicationInfo.FLAG_DEBUGGABLE) != 0) {
                //Debug and development mode
                return true;
            }
        } catch (NameNotFoundException e){
            // do nothing
        }
        return false;
    }

    // private String getIpAddress() {
    //     WifiManager wm = (WifiManager) ctx.getSystemService(Context.WIFI_SERVICE);
    //     String ip = Formatter.formatIpAddress(wm.getConnectionInfo().getIpAddress());
    //     return ip;
    // }
    private String getNetworkProvider() {
        TelephonyManager tm = (TelephonyManager) ctx.getSystemService(Context.TELEPHONY_SERVICE);
        return tm.getNetworkOperatorName();
    }

    // private void getDeviceMeta(String message, CallbackContext callbackContext) {
    //     if (message != null && message.length() > 0) {
    //         callbackContext.success(message);
    //     } else {
    //         callbackContext.error("Expected one non-empty string argument.");
    //     }
    // }
}
