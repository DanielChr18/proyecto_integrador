demo = {
	initDocumentationCharts: function() {
		if ($('#dailySalesChart').length != 0 && $('#websiteViewsChart').length != 0) {
			/* ----------==========     Daily Sales Chart initialization For Documentation    ==========---------- */

			dataDailySalesChart = {
				labels: ['M', 'T', 'W', 'T', 'F', 'S', 'S'],
				series: [
					[12, 17, 7, 17, 23, 18, 38]
				]
			};

			optionsDailySalesChart = {
				lineSmooth: Chartist.Interpolation.cardinal({
					tension: 0
				}),
				low: 0,
				high: 50, // creative tim: we recommend you to set the high sa the biggest value + something for a better look
				chartPadding: {
					top: 0,
					right: 0,
					bottom: 0,
					left: 0
				},
			}

			var dailySalesChart = new Chartist.Line('#dailySalesChart', dataDailySalesChart, optionsDailySalesChart);

			var animationHeaderChart = new Chartist.Line('#websiteViewsChart', dataDailySalesChart, optionsDailySalesChart);
		}
	},

	initDashboardPageCharts: function() {

		if ($('#dailySalesChart').length != 0 || $('#completedTasksChart').length != 0 || $('#websiteViewsChart').length != 0) {
			/* ----------==========     Daily Sales Chart initialization    ==========---------- */

			dataDailySalesChart = {
				labels: ['M', 'T', 'W', 'T', 'F', 'S', 'S'],
				series: [
					[12, 17, 7, 17, 23, 18, 38]
				]
			};

			optionsDailySalesChart = {
				lineSmooth: Chartist.Interpolation.cardinal({
					tension: 0
				}),
				low: 0,
				high: 50, // creative tim: we recommend you to set the high sa the biggest value + something for a better look
				chartPadding: {
					top: 0,
					right: 0,
					bottom: 0,
					left: 0
				},
			}

			var dailySalesChart = new Chartist.Line('#dailySalesChart', dataDailySalesChart, optionsDailySalesChart);

			md.startAnimationForLineChart(dailySalesChart);



			/* ----------==========     Completed Tasks Chart initialization    ==========---------- */

			dataCompletedTasksChart = {
				labels: ['12p', '3p', '6p', '9p', '12p', '3a', '6a', '9a'],
				series: [
					[230, 750, 450, 300, 280, 240, 200, 190]
				]
			};

			optionsCompletedTasksChart = {
				lineSmooth: Chartist.Interpolation.cardinal({
					tension: 0
				}),
				low: 0,
				high: 1000, // creative tim: we recommend you to set the high sa the biggest value + something for a better look
				chartPadding: {
					top: 0,
					right: 0,
					bottom: 0,
					left: 0
				}
			}

			var completedTasksChart = new Chartist.Line('#completedTasksChart', dataCompletedTasksChart, optionsCompletedTasksChart);

			// start animation for the Completed Tasks Chart - Line Chart
			md.startAnimationForLineChart(completedTasksChart);


			/* ----------==========     Emails Subscription Chart initialization    ==========---------- */

			var dataWebsiteViewsChart = {
				labels: ['J', 'F', 'M', 'A', 'M', 'J', 'J', 'A', 'S', 'O', 'N', 'D'],
				series: [
					[542, 443, 320, 780, 553, 453, 326, 434, 568, 610, 756, 895]

				]
			};
			var optionsWebsiteViewsChart = {
				axisX: {
					showGrid: false
				},
				low: 0,
				high: 1000,
				chartPadding: {
					top: 0,
					right: 5,
					bottom: 0,
					left: 0
				}
			};
			var responsiveOptions = [
				['screen and (max-width: 640px)', {
					seriesBarDistance: 5,
					axisX: {
						labelInterpolationFnc: function(value) {
							return value[0];
						}
					}
				}]
			];
			var websiteViewsChart = Chartist.Bar('#websiteViewsChart', dataWebsiteViewsChart, optionsWebsiteViewsChart, responsiveOptions);

			//start animation for the Emails Subscription Chart
			md.startAnimationForBarChart(websiteViewsChart);
		}
	},

	initGoogleMaps: function() {
		var myLatlng = new google.maps.LatLng(40.748817, -73.985428);
		var mapOptions = {
			zoom: 13,
			center: myLatlng,
			scrollwheel: false, //we disable de scroll over the map, it is a really annoing when you scroll through page
			styles: [{
				"featureType": "water",
				"stylers": [{
					"saturation": 43
				}, {
					"lightness": -11
				}, {
					"hue": "#0088ff"
				}]
			}, {
				"featureType": "road",
				"elementType": "geometry.fill",
				"stylers": [{
					"hue": "#ff0000"
				}, {
					"saturation": -100
				}, {
					"lightness": 99
				}]
			}, {
				"featureType": "road",
				"elementType": "geometry.stroke",
				"stylers": [{
					"color": "#808080"
				}, {
					"lightness": 54
				}]
			}, {
				"featureType": "landscape.man_made",
				"elementType": "geometry.fill",
				"stylers": [{
					"color": "#ece2d9"
				}]
			}, {
				"featureType": "poi.park",
				"elementType": "geometry.fill",
				"stylers": [{
					"color": "#ccdca1"
				}]
			}, {
				"featureType": "road",
				"elementType": "labels.text.fill",
				"stylers": [{
					"color": "#767676"
				}]
			}, {
				"featureType": "road",
				"elementType": "labels.text.stroke",
				"stylers": [{
					"color": "#ffffff"
				}]
			}, {
				"featureType": "poi",
				"stylers": [{
					"visibility": "off"
				}]
			}, {
				"featureType": "landscape.natural",
				"elementType": "geometry.fill",
				"stylers": [{
					"visibility": "on"
				}, {
					"color": "#b8cb93"
				}]
			}, {
				"featureType": "poi.park",
				"stylers": [{
					"visibility": "on"
				}]
			}, {
				"featureType": "poi.sports_complex",
				"stylers": [{
					"visibility": "on"
				}]
			}, {
				"featureType": "poi.medical",
				"stylers": [{
					"visibility": "on"
				}]
			}, {
				"featureType": "poi.business",
				"stylers": [{
					"visibility": "simplified"
				}]
			}]

		};
		var map = new google.maps.Map(document.getElementById("map"), mapOptions);

		var marker = new google.maps.Marker({
			position: myLatlng,
			title: "Hello World!"
		});

		// To add the marker to the map, call setMap();
		marker.setMap(map);
	}
}



function agregarProductos(id) {
	$.ajax({
		type: 'POST',
		data: {
			'id': id
		},
		url: 'agregarProducto',
		success: function(data) {
			$("#id_compras1")
				.load(window.location.href + " #id_compras1");
			$("#id_compras2")
				.load(window.location.href + " #id_compras2");
			if (data.CONFIRMACION == 'SI') {
				swal("&#161;&#201;xito!", "Producto agregado al carrito", "success");
			}
		},
		error: function() {
		}
	});
}


// Script Validar Números
function validaNumericos(event) {
	if (event.charCode >= 48 && event.charCode <= 57) {
		return true;
	}
	return false;
}

// Script Imagen
function imagen(idInput, idBox, idMensaje) {
	document
		.querySelector(idInput)
		.addEventListener(
			'change',
			function(e) {
				var boxFile = document.querySelector(idBox);
				boxFile.classList.remove('attached');
				boxFile.innerHTML = boxFile.getAttribute("data-text");
				if (this.value !== '') {
					var allowedExtensions = /(\.jpg|\.jpeg|\.png|\.tiff)$/i;
					if (allowedExtensions.exec(this.value)) {
						boxFile.innerHTML = e.target.files[0].name;
						boxFile.classList.add('attached');
						if (idMensaje != null)
							$(idMensaje).hide();
					} else {
						this.value = '';
						alert('El archivo que intentas subir no está permitido.\nLos archivos permitidos son .jpg, .jpeg, .png y .tiff');
						boxFile.classList.remove('attached');
						if (idMensaje != null)
							$(idMensaje).show();
					}
				} else {
					if (idMensaje != null)
						$(idMensaje).show();
				}
			});
}



$(function() {
	//Card number input
	$(".number").on(
		"keydown input",
		function() {
			if (event.key >= 0 && event.key <= 9) {
				if ($(this).val().length === 4
					|| $(this).val().length === 9
					|| $(this).val().length === 14) {
					$(this).val($(this).val() + " ");
				}
			}
		});

	//Date expire input
	$(".expire")
		.keypress(
			function(event) {
				if (event.charCode >= 48 && event.charCode <= 57) {
					var anio = (new Date).getFullYear();
					var anioAyuda = 0;
					if ($(this).val().length === 0) {
						if (event.key == 1 || event.key == 0)
							return event.charCode;
						else
							$(this).val(0 + event.key + " / ");
					} else if ($(this).val().length === 1
						&& $(this).val() === '1') {
						if (event.key == 0 || event.key == 1
							|| event.key == 2)
							$(this).val(
								$(this).val() + event.key
								+ " / ");
					} else if ($(this).val().length === 1
						&& $(this).val() !== '1') {
						if (event.key != 0)
							$(this).val(
								$(this).val() + event.key
								+ " / ");
					} else if ($(this).val().length === 2
						&& event.key >= anio.toString()
							.substring(0, 1)) {
						$(this).val(
							$(this).val() + " / " + event.key);
					} else if ($(this).val().length === 3
						&& event.key >= anio.toString()
							.substring(0, 1)) {
						$(this).val(
							$(this).val() + "/ " + event.key);
					} else if ($(this).val().length === 4
						&& event.key >= anio.toString()
							.substring(0, 1)) {
						$(this)
							.val(
								$(this).val() + " "
								+ event.key);
					} else if ($(this).val().length === 5
						&& event.key >= anio.toString()
							.substring(0, 1)) {
						return event.charCode;
					} else if ($(this).val().length === 6) {
						anioAyuda = $(this).val().substring(
							$(this).val().length - 1,
							$(this).val().length)
							+ event.key;
						if (anioAyuda >= anio.toString().substring(
							0, 2)) {
							return event.charCode;
						}
					} else if ($(this).val().length === 7) {
						anioAyuda = $(this).val().substring(
							$(this).val().length - 2,
							$(this).val().length)
							+ event.key;
						if (anioAyuda >= anio.toString().substring(
							0, 3))
							return event.charCode;
					} else if ($(this).val().length === 8) {
						anioAyuda = $(this).val().substring(
							$(this).val().length - 3,
							$(this).val().length)
							+ event.key;
						if (anioAyuda >= anio)
							return event.charCode;
					}
				}
				return false;
			});
});





var contadorReg = 0;
var horasReg = [];
var confirmarReg = 0;

function agregarHorarioRegistrar() {
	var horaReg = $("#id_horarioRegistrar").val();
	if (horaReg > 7 && horaReg <= 20) {
		if (contadorReg <= 2) {
			if (horasReg.length != 0) {
				for (var i = 0; i < horasReg.length; i++) {
					if (horasReg[i] == horaReg) {
						confirmarReg = 1;
						break;
					}
				}
				if (confirmarReg == 0) {
					horasReg.push(horaReg);
					$("#id_horariosServiciosRegistrar")
						.append(
							"<div class='col-md-2' id='id_boton" + horaReg + "'><div class='form-group'>"
							+ "<button type='button' class='close' onclick=\"eliminarHorarioRegistrar('"
							+ horaReg
							+ "');\">&times;</button><h4>"
							+ horaReg
							+ ":00</h4></div></div>");
					contadorReg = contadorReg + 1;
					$('#id_mensajeHoraConfirmarRegistrar').hide();
				} else if (confirmarReg == 1) {
					alert('Horario repetido');
					confirmarReg = 0;
				}
				var horariosReg = "";
				for (var i = 0; i < horasReg.length; i++) {
					if ((horasReg.length - 1) == i) {
						horariosReg += horasReg[i];
					} else {
						horariosReg += horasReg[i] + ",";
					}
				}
				$("#id_ayudaHoraRegistrar").val(horariosReg);
			} else if (horasReg.length == 0) {
				horasReg.push(horaReg);
				$("#id_horariosServiciosRegistrar")
					.append(
						"<div class='col-md-2' id='id_boton" + horaReg + "'><div class='form-group'>"
						+ "<button type='button' class='close' onclick=\"eliminarHorarioRegistrar('"
						+ horaReg
						+ "');\">&times;</button><h4>"
						+ horaReg
						+ ":00</h4></div></div>");
				$("#id_ayudaHoraRegistrar").val(horaReg);
				$('#id_mensajeHoraConfirmarRegistrar').hide();
				contadorReg = contadorReg + 1;
			}
		} else {
			alert('Solo se pueden agregar hasta 3 horarios de atención');
		}
	} else if ((horaReg < 8) || (horaReg > 20)) {
		alert('El horario es desde las 10 Hr hasta las 20 Hr');
	} else {
		alert('Solo se permiten números');
	}
}

function eliminarHorarioRegistrar(id) {
	for (var i = 0; i < horasReg.length; i++) {
		if (horasReg[i] == id) {
			var h = horasReg.indexOf(id);
			horasReg.splice(h, 1);
			$("#id_horariosServiciosRegistrar #id_boton" + id).remove();
			var horariosReg = "";
			for (var i = 0; i < horasReg.length; i++) {
				if ((horasReg.length - 1) == i) {
					horariosReg += horasReg[i];
				} else {
					horariosReg += horasReg[i] + ",";
				}
			}
			$("#id_ayudaHoraRegistrar").val(horariosReg);
			contadorReg = contadorReg - 1;
			break;
		}
	}
	if (horasReg.length == 0) {
		$('#id_mensajeHoraConfirmarRegistrar').show();
	}
}


var contadorMod = 0;
var horasMod = [];
var confirmarMod = 0;

function agregarHorarioModificar() {
	var horaMod = $("#id_horarioModificar").val();
	if (horaMod > 7 && horaMod <= 20) {
		if (contadorMod <= 2) {
			if (horasMod.length != 0) {
				for (var i = 0; i < horasMod.length; i++) {
					if (horasMod[i] == horaMod) {
						confirmarMod = 1;
						break;
					}
				}
				if (confirmarMod == 0) {
					horasMod.push(horaMod);
					$("#id_horariosServiciosModificar")
						.append(
							"<div class='col-md-2' id='id_boton" + horaMod + "'><div class='form-group'>"
							+ "<button type='button' class='close' onclick=\"eliminarHorarioModificar('"
							+ horaMod
							+ "');\">&times;</button><h4>"
							+ horaMod
							+ ":00</h4></div></div>");
					contadorMod = contadorMod + 1;
					$('#id_mensajeHoraConfirmarModificar').hide();
				} else if (confirmarMod == 1) {
					alert('Horario repetido');
					confirmarMod = 0;
				}
				var horariosMod = "";
				for (var i = 0; i < horasMod.length; i++) {
					if ((horasMod.length - 1) == i) {
						horariosMod += horasMod[i];
					} else {
						horariosMod += horasMod[i] + ",";
					}
				}
				$("#id_ayudaHoraModificar").val(horariosMod);
			} else if (horasMod.length == 0) {
				horasMod.push(horaMod);
				$("#id_horariosServiciosModificar")
					.append(
						"<div class='col-md-2' id='id_boton" + horaMod + "'><div class='form-group'>"
						+ "<button type='button' class='close' onclick=\"eliminarHorarioModificar('"
						+ horaMod
						+ "');\">&times;</button><h4>"
						+ horaMod
						+ ":00</h4></div></div>");
				$("#id_ayudaHoraModificar").val(horaMod);
				contadorMod = contadorMod + 1;
				$('#id_mensajeHoraConfirmarModificar').hide();
			}
		} else {
			alert('Solo se pueden agregar hasta 3 horarios de atención');
		}
	} else if ((horaMod < 8) || (horaMod > 20)) {
		alert('El horario es desde las 10 Hr hasta las 20 Hr');
	} else {
		alert('Solo se permiten números');
	}
}

function eliminarHorarioModificar(id) {
	for (var i = 0; i < horasMod.length; i++) {
		if (horasMod[i] == id) {
			var h = horasMod.indexOf(id);
			horasMod.splice(h, 1);
			$("#id_horariosServiciosModificar #id_boton" + id).remove();
			var horariosMod = "";
			for (var i = 0; i < horasMod.length; i++) {
				if ((horasMod.length - 1) == i) {
					horariosMod += horasMod[i];
				} else {
					horariosMod += horasMod[i] + ",";
				}
			}
			$("#id_ayudaHoraModificar").val(horariosMod);
			contadorMod = contadorMod - 1;
			break;
		}
	}
	if (horasMod.length == 0) {
		$('#id_mensajeHoraConfirmarModificar').show();
	}
}
