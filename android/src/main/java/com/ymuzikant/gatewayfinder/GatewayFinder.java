package com.ymuzikant.gatewayfinder;

import android.annotation.SuppressLint;
import android.content.Context;
import android.net.DhcpInfo;
import android.net.wifi.WifiManager;
import android.util.Log;

import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.ReadableNativeMap;
import com.facebook.react.bridge.WritableNativeMap;

/**
 * Created by Yaron Muzikant on 29-Jan-17.
 */

public class GatewayFinder extends ReactContextBaseJavaModule {
    private static final String TAG = "GatewayFinder";

    public GatewayFinder(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @Override
    public String getName() {
        return "GatewayFinder";
    }

    @ReactMethod
    public void getGatewayInfo(Callback onGatewayInfoFetched, Callback onError) {
        try {
            WritableNativeMap gatewayInfo = new WritableNativeMap();

            WifiManager wifiManager = (WifiManager) getReactApplicationContext().getSystemService(Context.WIFI_SERVICE);

            if (wifiManager.isWifiEnabled() && wifiManager.getConnectionInfo() != null) {
                // Get router info and show to user (IP and model)
                DhcpInfo dhcp = wifiManager.getDhcpInfo();
                String gatewayIpAddress = getIpAddress(dhcp.gateway);

                gatewayInfo.putString("ip", gatewayIpAddress);
                gatewayInfo.putString("bssid", sanitizeAccessPointID(wifiManager.getConnectionInfo().getBSSID()));
                gatewayInfo.putString("ssid", sanitizeAccessPointID(wifiManager.getConnectionInfo().getSSID()));

                if (onGatewayInfoFetched != null) {
                    onGatewayInfoFetched.invoke(gatewayInfo);
                } else {
                    reportError(onError, "no gateway found");
                }
            } else {
                reportError(onError, "Not connected to wifi");
            }
        } catch (Exception ex) {
            reportError(onError, ex.getMessage());
        }
    }

    private void reportError(Callback onError, String error) {
        if (onError != null) {
            onError.invoke(error);
        }

        Log.e(TAG, "reportError: " + error);
    }

    @SuppressLint("DefaultLocale")
    private String getIpAddress(int ip) {
        return String.format("%d.%d.%d.%d",
                (ip & 0xff),
                (ip >> 8 & 0xff),
                (ip >> 16 & 0xff),
                (ip >> 24 & 0xff));
    }

    private String sanitizeAccessPointID(String id) {
        if (id != null) {
            id = id.replace("&quot;", "");
            id = id.replace("\"", "");
        }
        return id;
    }
}