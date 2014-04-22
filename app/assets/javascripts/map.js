
	var rendererOptions = {
	  draggable: true
	};

	var directionsDisplay = new google.maps.DirectionsRenderer(rendererOptions);;
	var directionsService = new google.maps.DirectionsService();
	var elevator = new google.maps.ElevationService();
	var map;

	var elevator;
	var chart;
	var infowindow = new google.maps.InfoWindow();
	var polyline;


	// Load the Visualization API and the columnchart package.
	google.load('visualization', '1', {packages: ['columnchart']});

	function initialize() {
	  // directionsDisplay = new google.maps.DirectionsRenderer();
	  var san_francisco = new google.maps.LatLng(37.7933, -122.3167);
	  var mapOptions = {
	    zoom:12,
	    center: san_francisco,
	    mapTypeControl: true,
	    mapTypeControlOptions: {
	    	style: google.maps.MapTypeControlStyle.HORIZONTAL_BAR,
	    	position: google.maps.ControlPosition.TOP_LEFT
	    },
	    panControl: false,
	    panControlOptions: {
	    	position: google.maps.ControlPosition.TOP_LEFT
	    },
	    mapTypeId: google.maps.MapTypeId.ROADMAP, //Blue Essence from Snazzy Maps
    	styles:[
    	{"featureType":"landscape.natural","elementType":"geometry.fill","stylers":[{"visibility":"on"},{"color":"#e0efef"}]},
    	{"featureType":"poi","elementType":"geometry.fill","stylers":[{"visibility":"on"},{"hue":"#1900ff"},{"color":"#c0e8e8"}]},
    	{"featureType":"landscape.man_made","elementType":"geometry.fill"},
    	{"featureType":"road","elementType":"geometry","stylers":[{"lightness":100},{"visibility":"simplified"}]},
    	{"featureType":"road","elementType":"labels","stylers":[{"visibility":"off"}]},
    	{"featureType":"water","stylers":[{"color":"#7dcdcd"}]},
    	{"featureType":"transit.line","elementType":"geometry","stylers":[{"visibility":"on"},{"lightness":700}]}]
	  }
	  map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
	  directionsDisplay.setMap(map);
	  directionsDisplay.setPanel(document.getElementById('directionsPanel'));
	  // var control = directionsDisplay.setPanel(document.getElementById('directionsPanel');
	  // 	control.style.display = '';

	  var updateForm = function(){
	  	var $start = $("#start");
	  	var $end = $("#end");

	  	$("#form_start").val($start.val());
	  	$("#form_end").val($end.val());
	  	// clearing the previous set of waypoints
	  	$("#waypoints").empty();

	  	// calling the function directionDisplay. dir is the result of the directions API call. 
	  	var dir = directionsDisplay.getDirections();
	  	// grabbing waypoints and iterating thru the array
	    dir.routes[0].legs[0].via_waypoints.forEach(function(waypoint,index){
	    	// for each waypoint pass the lattitude(d) and longtitude(e) to the form which is then saved. 
	    	$("#new_journey #waypoints").append("<input type='hidden' name='journey[waypoint]["+index+"][d]' value='"+waypoint.d+"'>")
	    	$("#new_journey #waypoints").append("<input type='hidden' name='journey[waypoint]["+index+"][e]' value='"+waypoint.e+"'>")
	    })
	  }

	  google.maps.event.addListener(directionsDisplay, 'directions_changed', function() {
	    console.log("The direction change was: ", directionsDisplay.getDirections())
	    updateForm()
	    createLatLngList(directionsDisplay.getDirections());
	  });

	  calcRoute();

	  // Draw the path, using the Visualization API and the Elevation service.
	  // drawPath();
	}

	function calcRoute(){
	  var selectedMode = document.getElementById('mode').value;
	  var start = document.getElementById('start').value;
	  var end = document.getElementById('end').value;

	  var request = {
	      origin:start,
	      destination:end,
	      provideRouteAlternatives:true,
	      travelMode: google.maps.TravelMode[selectedMode]
	  };

	  directionsService.route(request, function(response, status) {
	    if (status == google.maps.DirectionsStatus.OK) {
	      directionsDisplay.setDirections(response);
	      showSaveBtn(status);
	      // document.getElementById('save_btn').classList.toggle('hidden');
	    }
	  });
	  
	}

	function showSaveBtn(status){
		if (status == google.maps.DirectionsStatus.OK  && $('#signin').length !== 1) {
	 		document.getElementById('save_btn').classList.remove('hidden');
	 	}
	 	else if (status == google.maps.DirectionsStatus.OK  && $('#signin').length === 1) {
	 		document.getElementById('please').classList.remove('hidden');
	 	}
	 }


	function createLatLngList(result) {
		console.log("result ", result);
	  var total = 0;
	  var latlngList = [];
	  var myroute = result.routes[0].legs[0];
	  console.log("myroute", myroute);
	  for (var i = 0; i < myroute.steps.length; i++) {
	    latlngList.push(myroute.steps[i].end_location); 
	  }
	  console.log("latlngList ", latlngList);
	  drawPath(latlngList);
	};


	function drawPath(list) {
		console.log("list ", list);
	  var start = document.getElementById('start').value;
	  var end = document.getElementById('end').value;

	  // Create a new chart in the elevation_chart DIV.
	  chart = new google.visualization.ColumnChart(document.getElementById('elevation_chart'));

	  var path = [];
	  if (list !== undefined){
		  for (var i = 0; i < list.length; i++) {
		  path.push(new google.maps.LatLng(list[i].A, list[i].k)) // previously list[i].d and list[i].e
		  }	
	  console.log("This is the list: ", list);
		}
		console.log("path", path);
	  // Create a PathElevationRequest object using this array.
	  // Ask for 25 samples along that path.
	  var pathRequest = {
	    'path': path,
	    'samples': 25
	  }

	  // Initiate the path request.
	  elevator.getElevationAlongPath(pathRequest, plotElevation);
	}

	// Takes an array of ElevationResult objects, draws the path on the map
	// and plots the elevation profile on a Visualization API ColumnChart.
	function plotElevation(results, status) {
	  if (status != google.maps.ElevationStatus.OK) {
	    return;
	  }
	  var elevations = results; //elevation+location(lat,lng)+resolution
	  console.log("elevations", elevations);
	  // Extract the elevation samples from the returned results
	  // and store them in an array of LatLngs.
	  var elevationPath = [];
	  for (var i = 0; i < results.length; i++) {
	    elevationPath.push(elevations[i].location);  //elevation[i].location = location in lat,lng format
	  }
	  console.log("elevationPath", elevationPath);

	  // Extract the data from which to populate the chart.
	  // Because the samples are equidistant, the 'Sample'
	  // column here does double duty as distance along the
	  // X axis.
	  var data = new google.visualization.DataTable();
	  data.addColumn('string', 'Sample');
	  data.addColumn('number', 'Elevation');
	  for (var i = 0; i < results.length; i++) {
	    data.addRow(['', elevations[i].elevation]);
	  }

	  console.log("data", data);

	  var options = {
          titleY: 'Elevation (m)',
          height: 150,
	    		legend: 'none',
	    		backgroundColor: 'rgba(127, 140, 141,0.6)',
	    		colors:['#4B0082','#34DDDD','red'],
	    		fontName: 'Open Sans',
	    		animation:{
		        duration: 1000,
		        easing: 'linear',
		      }
        };

	  // Draw the chart using the data within its DIV.
	  document.getElementById('elevation_chart').style.display = 'block';
	  chart.draw(data,options);

	}
 	

	// google.maps.event.addDomListener(window, 'load', initialize);

	$(document).on('ready page:load', initialize);


	  //makes a new map with saved routes

	  function calcMyRoute() {
	  var my_start = document.getElementById('my-start').innerHTML;
	  var my_end = document.getElementById('my-end').innerHTML;
	  
	  var waypts = [];
	  var checkboxArray = eval(document.getElementById("waypoints").innerHTML);
	  console.log(checkboxArray);

	  var my_path = [];
	  for (var i = 0; i < checkboxArray.length; i+=2) {
	  my_path.push({location: new google.maps.LatLng(checkboxArray[i], checkboxArray[i+1]),
	  	stopover:true
	  	});
	  	}
	  console.log(my_path);


	  var request = {
	      origin: my_start,
	      waypoints: my_path,
	      destination: my_end,
	      travelMode: google.maps.TravelMode.BICYCLING
	  }
	  console.log(request);

	  directionsService.route(request, function(response, status) {
	    if (status == google.maps.DirectionsStatus.OK) {
	      directionsDisplay.setDirections(response);
	      console.log(status);
	      console.log(resonse);
	    }
	  });
	  drawPath(my_path)
	}
	// end of calcMyRoute




