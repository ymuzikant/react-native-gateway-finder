# react-native-gateway-finder

## Installation:
* Run `npm install react-native-gateway-finder --save`
* Run `react-native link react-native--gateway-finder`

## Usage:
```javascript
import GatewayFinder from 'react-native-gateway-finder';

GatewayFinder.getGatewayInfo(
  (gatewayInfo) => {
      console.log(gatewayInfo);
  },
  (error) => {
      console.error(error);
  });
  ```
  
The output of this snippet is:
```
{
  ssid: 'network_name',
  bssid: 'b1:5f:40:2b:54:b0',
  ip: '10.0.0.1'
}
```
