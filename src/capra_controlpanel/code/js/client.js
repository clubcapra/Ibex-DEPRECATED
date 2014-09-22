var ws;

var successColor = "#66ff66";
var errorColor = "#ff6666";

//Sensors -- Order not important
var sensors = new Array();
sensors[0] = "lights";
sensors[1] = "gps";
sensors[2] = "fan";
sensors[3] = "imu";
sensors[4] = "camera";
sensors[5] = "switch";
sensors[6] = "rangefinder";
sensors[7] = "estopManual";
sensors[8] = "estopRemote";
sensors[9] = "mode";

var analogs = new Array();
analogs[0] = "tension";
analogs[1] = "temperature";
analogs[2] = "current";

$(document).ready(function() {
				$('input:checkbox:not([safari])').checkbox();
				$('input[safari]:checkbox').checkbox({cls:'jquery-safari-checkbox'});
				$("#connectBox").dialog(
					{
						width : 275,
						resizable:false,
						title : "Connection",
						closeOnEscape:false,
						position : [700,50]
					});
				$("#monitoring").dialog(
					{
						width:375,
						resizable:false,
						title : "Monitoring",
						closeOnEscape:false,
						position : [600,300]
					});
			});

function getAllComponents(){
	for(var i = 0; i < sensors.length; i++){
		ws.send("get " + sensors[i]);      
	}
	for(var i = 0; i < analogs.length; i++){
		ws.send("get " + analogs[i]);      
	}
}

function update(checkbox, id){
	if (checkbox.checked){
		ws.send("set " + sensors[id] +  " on");
	} else {
		ws.send("set " + sensors[id] +  " off");
	}
}

function onoff2bool(onoff){
	if(onoff.indexOf("ON") !== -1){
		return true;
		}
	else
		return false;
}


$(document).ready(function () {

	$("#open").click(function(evt) 
	{
		evt.preventDefault();

		var host = $("#host").val();
		var port = $("#port").val();
		var uri = "/ws";

		ws = new WebSocket("ws://" + host + ":" + port + uri);

		ws.onmessage = function(evt) 
		{

			var componentName = evt.data.split(" ")[0];

			//If its a sensor
			if($.inArray(componentName, sensors) != -1)
			{
				for(var i = 0; i <	sensors.length; i++)
				{
					if(componentName == sensors[i])
					{
						document.getElementById(componentName).checked=onoff2bool(evt.data.split(" ")[1])
					}
				}
			 
			 //if its an analog lecture
			}
			else if($.inArray(componentName, analogs) != -1)
			{
				for(var i = 0; i <	analogs.length; i++)
				{
					if(componentName == analogs[i])
					{
						document.getElementById(componentName).value=evt.data.split(" ")[1]
					}
				}
			}
			else
			{        
				alert("Cannot parse data from server:" + evt.data);
			}
		};

		ws.onclose = function(evt) {             
			$("#host").css("background", errorColor); 
			$("#port").css("background", errorColor); 
			$("#uri").css("background", errorColor); 
		};

		ws.onopen = function(evt) { 
			$("#host").css("background", successColor); 
			$("#port").css("background", successColor); 
			$("#uri").css("background", successColor);

			getAllComponents();

			//var tid = setInterval(getAllComponents, 1000);

		};
	});
});