<?php

require_once("lib/sensor.class.php");

$sensors = array();
$sensors["lights"] 	= new Sensor(0, "lights", "Lights", "img/lights.png");
$sensors["gps"] 	= new Sensor(1, "gps", "GPS", "img/gps.png");
$sensors["fan"] 	= new Sensor(2, "fan", "Fans", "img/fans.png");
$sensors["imu"] 	= new Sensor(3, "imu", "IMU", "img/imu.png");
$sensors["camera"] 	= new Sensor(4, "camera", "Camera", "img/camera.png");
$sensors["switch"] 	= new Sensor(5, "switch", "Ethernet", "img/switch.png");
$sensors["rangefinder"] = new Sensor(6, "rangefinder", "Range Finder", "img/rangefinder.png");


?>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" >
    <head>
        <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>Panneau de contrôle - Capra 6</title>
        <link rel="stylesheet" type="text/css" href="css/client.css" />
        <link rel="stylesheet" type="text/css" href="css/jquery.checkbox.css" />
        <link rel="stylesheet" type="text/css" href="css/jquery-ui-1.10.3.custom.min.css" />
		<script type="text/javascript" src="js/jquery.js" ></script>
		<script type="text/javascript" src="js/jquery.checkbox.js" /></script>
		<script type="text/javascript" src="js/jquery-ui-1.10.3.custom.min.js" /></script>
		<script type="text/javascript" src="js/client.js" /></script>

	</head>

	<body>
		<div id="container">
			<div id="connectBox">
			  <label>Host: <input type="text" id="host" value="localhost" style="background:#ff6666;"/></label><br />
			  <label>Port: <input type="text" id="port" value="53002" style="background:#ff6666	;"/><label><br/>
			  <input type="submit" id="open" value="Connect" />
			</div>

			<div id="monitoring">
				<table>
					<tr> 
						<td>Voltage:</td>
						<td><span class="monitoringValue" id="voltage">0.0</span></td>
						<td>Volts</td>
					</tr>
					<tr> 
						<td>Current:</td>
						<td><span class="monitoringValue" id="current">0.0</span></td>
						<td>Amps</td>
					</tr>
					<tr> 
						<td>Temperature:</td>
						<td><span class="monitoringValue" id="temperature">0.0</span></td>
						<td>deg. C</td>
					</tr>
				</table>
			</div>
			
			<div id="sensors">
				<table>
					<tr>
						<td><?php echo $sensors["imu"]->getHTML();?></td>
						<td><?php echo $sensors["switch"]->getHTML();?></td>
						<td><?php echo $sensors["camera"]->getHTML();?></td>
						<td><?php echo $sensors["gps"]->getHTML();?></td>
					</tr>
					<tr>
						<td><?php echo $sensors["fan"]->getHTML();?></td>
						<td><?php echo $sensors["rangefinder"]->getHTML();?></td>
						<td><?php echo $sensors["lights"]->getHTML();?></td>
					</tr>
				</table>
			</div>
		</div>
	</body>
</html>
