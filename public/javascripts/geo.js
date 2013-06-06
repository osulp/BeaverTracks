(function(){if(window.google&&google.gears){return;}
var factory=null;if(typeof GearsFactory!='undefined'){factory=new GearsFactory();}else{try{factory=new ActiveXObject('Gears.Factory');if(factory.getBuildInfo().indexOf('ie_mobile')!=-1){factory.privateSetGlobalObject(this);}}catch(e){if((typeof navigator.mimeTypes!='undefined')&&navigator.mimeTypes["application/x-googlegears"]){factory=document.createElement("object");factory.style.display="none";factory.width=0;factory.height=0;factory.type="application/x-googlegears";document.documentElement.appendChild(factory);}}}
if(!factory){return;}
if(!window.google){google={};}
if(!google.gears){google.gears={factory:factory};}})();var bb_successCallback;var bb_errorCallback;function handleBlackBerryLocation()
{if(bb_successCallback&&bb_errorCallback)
{if(blackberry.location.latitude==0&&blackberry.location.longitude==0)
{bb_errorCallback({message:"Position unavailable",code:2});}
else
{var timestamp=null;if(blackberry.location.timestamp)
{timestamp=new Date(blackberry.location.timestamp);}
bb_successCallback({timestamp:timestamp,coords:{latitude:blackberry.location.latitude,longitude:blackberry.location.longitude}});}
if(parseFloat(navigator.appVersion)>=4.6)
{blackberry.location.removeLocationUpdate(handleBlackBerryLocation);}
bb_successCallback=null;bb_errorCallback=null;}}
var geo_position_js=function()
{var pub={};var provider=null;pub.getCurrentPosition=function(successCallback,errorCallback,options){provider.getCurrentPosition(successCallback,errorCallback,options);}
pub.init=function()
{try
{if(typeof(geo_position_js_simulator)!="undefined")
{provider=geo_position_js_simulator;}
else if(typeof(bondi)!="undefined"&&typeof(bondi.geolocation)!="undefined"){provider=bondi.geolocation;}
else if(typeof(window.google)!="undefined"&&typeof(window.google.gears)!="undefined")
{provider=google.gears.factory.create('beta.geolocation');pub.getCurrentPosition=function(successCallback,errorCallback,options){try
{function _successCallback(p){if(typeof(p.latitude)!="undefined"){successCallback({timestamp:p.timestamp,coords:{latitude:p.latitude,longitude:p.longitude}});}
else
{successCallback(p);}}
provider.getCurrentPosition(_successCallback,errorCallback,options);}
catch(e)
{errorCallback({message:e,code:1});}}}
else if(typeof(navigator.geolocation)!="undefined")
{provider=navigator.geolocation;pub.getCurrentPosition=function(successCallback,errorCallback,options)
{function _successCallback(p){if(typeof(p.latitude)!="undefined"){successCallback({timestamp:p.timestamp,coords:{latitude:p.latitude,longitude:p.longitude}});}
else
{successCallback(p);}}
provider.getCurrentPosition(_successCallback,errorCallback,options);}
pub.watchPosition=function(successCallback,errorCallback,options){try
{provider.watchPosition(successCallback,errorCallback,options);pub.clearWatch=function(watchId){if(typeof(provider.clearWatch)!="undefined")
provider.clearWatch(watchId);}}
catch(e)
{provider.getCurrentPosition(successCallback,errorCallback,options);}}}
else if(typeof(Mojo)!="undefined"&&typeof(Mojo.Service)!="undefined"&&typeof(Mojo.Service.Request)!="Mojo.Service.Request"){provider=true;pub.getCurrentPosition=function(successCallback,errorCallback,options){parameters={};if(options){if(options.enableHighAccuracy&&options.enableHighAccuracy==true){parameters.accuracy=1;}
if(options.maximumAge){parameters.maximumAge=options.maximumAge;}
if(options.responseTime){if(options.responseTime<5){parameters.responseTime=1;}
else
if(options.responseTime<20){parameters.responseTime=2;}
else{parameters.timeout=3;}}}
r=new Mojo.Service.Request('palm://com.palm.location',{method:"getCurrentPosition",parameters:parameters,onSuccess:function(p){successCallback({timestamp:p.timestamp,coords:{latitude:p.latitude,longitude:p.longitude,heading:p.heading}});},onFailure:function(e){if(e.errorCode==1){errorCallback({code:3,message:"Timeout"});}
else
if(e.errorCode==2){errorCallback({code:2,message:"Position Unavailable"});}
else{errorCallback({code:0,message:"Unknown Error: webOS-code"+errorCode});}}});}}
else if(typeof(device)!="undefined"&&typeof(device.getServiceObject)!="undefined"){provider=device.getServiceObject("Service.Location","ILocation");pub.getCurrentPosition=function(successCallback,errorCallback,options){function callback(transId,eventCode,result){if(eventCode==4){errorCallback({message:"Position unavailable",code:2});}
else{successCallback({timestamp:null,coords:{latitude:result.ReturnValue.Latitude,longitude:result.ReturnValue.Longitude,altitude:result.ReturnValue.Altitude,heading:result.ReturnValue.Heading}});}}
var criteria=new Object();criteria.LocationInformationClass="BasicLocationInformation";provider.ILocation.GetLocation(criteria,callback);}}
else if(typeof(window.blackberry)!="undefined"&&blackberry.location.GPSSupported){blackberry.location.setAidMode(2);pub.getCurrentPosition=function(successCallback,errorCallback,options){bb_successCallback=successCallback;bb_errorCallback=errorCallback;if(parseFloat(navigator.appVersion)>=4.6)
{blackberry.location.onLocationUpdate(handleBlackBerryLocation);}
else
{blackberry.location.onLocationUpdate("handleBlackBerryLocation()");}
blackberry.location.refreshLocation();}
provider=blackberry.location;}}
catch(e){if(typeof(console)!="undefined"){console.log(e);}}
return provider!=null;}
return pub;}();
