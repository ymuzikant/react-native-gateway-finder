/**
 * Created by Yaron Muzikant on 29-Jan-17.
 */
import { NativeModules } from 'react-native';

var NativeGatewayFinder = NativeModules.GatewayFinder;

function htmlSanitize(str) {
    if (!str) return str;

    return str
        .replace(/&/g, '')
        .replace(/"/g, '')
        .replace(/'/g, '')
        .replace(/</g, '')
        .replace(/>/g, '');
}

GatewayFinder =
    {
        getGatewayInfo: function (onSuccess, onError) {
            NativeGatewayFinder.getGatewayInfo(
                (gatewayInfo) => {
                    onSuccess({
                        ip: gatewayInfo.ip,
                        ssid: htmlSanitize(gatewayInfo.ssid),
                        bssid: htmlSanitize(gatewayInfo.bssid)});
                },
                onError
            );
        }
    };

module.exports = GatewayFinder;

