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

$(function() {
	var date = new Date();
	date.setMonth(date.getMonth() - 2);
	var fechaMaxima = date.toISOString().split("T")[0];
	date.setMonth(date.getMonth() + 2);
	date.setFullYear(date.getFullYear() - 15);
	var fechaMinima = date.toISOString().split("T")[0];

	$("#id_fechaNacMascotaRegistrar").attr('max', fechaMaxima);
	$("#id_fechaNacMascotaModificar").attr('max', fechaMaxima);
	$("#id_fechaNacMascotaRegistrar").attr('min', fechaMinima);
	$("#id_fechaNacMascotaModificar").attr('min', fechaMinima);
});



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





// ------------------- Funciones ------------------- //

// ------------------- 1.- Script Validar Números ------------------- //
function validaNumericos(event) {
	if (event.charCode >= 48 && event.charCode <= 57) {
		return true;
	}
	return false;
}
// ------------------- 1.- Script Validar Números ------------------- //

// ------------------- 2.- Script Imagen ------------------- //
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
						swal("¡Aviso!", "El archivo que intentas subir no está permitido. Los archivos permitidos son .jpg, .jpeg, .png y .tiff", "warning");
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
// ------------------- 2.- Script Imagen ------------------- //

// ------------------- Funciones ------------------- //




// ------------------- Métodos del CRUD Marca ------------------- //
function registrarMarca() {
	var validator = $('#id_formRegistrarMarca').data(
		'bootstrapValidator');
	validator.validate();
	if (validator.isValid()) {
		$.ajax({
			type: 'POST',
			data: $("#id_formRegistrarMarca").serialize(),
			url: 'registrarMarca',
			success: function(data) {
				if (data.CONFIRMACION == 'SI') {
					swal("¡Éxito!", data.MENSAJE, "success");
					setTimeout(function() {
						window.location = 'crudMarcas';
					}, 1500);
				} else {
					swal("¡Aviso!", data.MENSAJE, "warning");
				}
			},
			error: function() {
				swal("¡Error!", "¡Comunicate con el administrador!",
					"error");
			}
		});
	}
}

function modificarMarca() {
	var validator = $('#id_formModificarMarca').data(
		'bootstrapValidator');
	validator.validate();
	if (validator.isValid()) {
		$.ajax({
			type: 'POST',
			data: $("#id_formModificarMarca").serialize(),
			url: 'modificarMarca',
			success: function(data) {
				if (data.CONFIRMACION == 'SI') {
					swal("¡Éxito!", data.MENSAJE, "success");
					setTimeout(function() {
						window.location = 'crudMarcas';
					}, 1500);
				} else {
					swal("¡Aviso!", data.MENSAJE, "warning");
				}
			},
			error: function() {
				swal("¡Error!", "¡Comunicate con el administrador!",
					"error");
			}
		});
	}
}

function eliminarMarca() {
	$.ajax({
		type: 'POST',
		data: $("#id_formEliminarMarca").serialize(),
		url: 'eliminarMarca',
		success: function(data) {
			if (data.CONFIRMACION == 'SI') {
				swal("¡Éxito!", data.MENSAJE, "success");
				setTimeout(function() {
					window.location = 'crudMarcas';
				}, 1500);
			} else {
				swal("¡Aviso!", data.MENSAJE, "warning");
			}
		},
		error: function() {
			swal("¡Error!", "¡Comunicate con el administrador!",
				"error");
		}
	});
}
// ------------------- Métodos del CRUD Marca ------------------- //







// ------------------- Métodos del CRUD Proveedor ------------------- //
function registrarProveedor() {
	var validator = $('#id_formRegistrarProveedor').data(
		'bootstrapValidator');
	validator.validate();
	if (validator.isValid()) {
		$.ajax({
			type: 'POST',
			data: $("#id_formRegistrarProveedor").serialize(),
			url: 'registrarProveedor',
			success: function(data) {
				if (data.CONFIRMACION == 'SI') {
					swal("¡Éxito!", data.MENSAJE, "success");
					setTimeout(function() {
						window.location = 'crudProveedores';
					}, 1500);
				} else {
					swal("¡Aviso!", data.MENSAJE, "warning");
				}
			},
			error: function() {
				swal("¡Error!", "¡Comunicate con el administrador!",
					"error");
			}
		});
	}
}

function modificarProveedor() {
	var validator = $('#id_formModificarProveedor').data(
		'bootstrapValidator');
	validator.validate();
	if (validator.isValid()) {
		$.ajax({
			type: 'POST',
			data: $("#id_formModificarProveedor").serialize(),
			url: 'modificarProveedor',
			success: function(data) {
				if (data.CONFIRMACION == 'SI') {
					swal("¡Éxito!", data.MENSAJE, "success");
					setTimeout(function() {
						window.location = 'crudProveedores';
					}, 1500);
				} else {
					swal("¡Aviso!", data.MENSAJE, "warning");
				}
			},
			error: function() {
				swal("¡Error!", "¡Comunicate con el administrador!",
					"error");
			}
		});
	}
}

function eliminarProveedor() {
	$.ajax({
		type: 'POST',
		data: $("#id_formEliminarProveedor").serialize(),
		url: 'eliminarProveedor',
		success: function(data) {
			if (data.CONFIRMACION == 'SI') {
				swal("¡Éxito!", data.MENSAJE, "success");
				setTimeout(function() {
					window.location = 'crudProveedores';
				}, 1500);
			} else {
				swal("¡Aviso!", data.MENSAJE, "warning");
			}
		},
		error: function() {
			swal("¡Error!", "¡Comunicate con el administrador!",
				"error");
		}
	});
}
// ------------------- Métodos del CRUD Proveedor ------------------- //







// ------------------- Métodos del CRUD Producto ------------------- //
function registrarProducto() {
	var c = "SI";
	if ($("#id_imagen1Registrar").val() === "") {
		$('#id_mensajeImagen1Registrar').show();
		var c = "NO";
	}
	if ($("#id_imagen2Registrar").val() === "") {
		$('#id_mensajeImagen2Registrar').show();
		var c = "NO";
	}
	if ($("#id_imagen3Registrar").val() === "") {
		$('#id_mensajeImagen3Registrar').show();
		var c = "NO";
	}
	if (CKEDITOR.instances['editor1'].document.getBody().getText() == ""
		|| CKEDITOR.instances['editor1'].document.getBody()
			.getText().length <= 30) {
		$('#id_mensajeDescripcionLargaRegistrar').show();
		var c = "NO";
	}
	var validator = $('#id_formRegistrarProducto').data(
		'bootstrapValidator');
	validator.validate();
	if (validator.isValid() && c === "SI") {
		var formData = new FormData($("#id_formRegistrarProducto")[0]);
		formData.append('imagen1ProductoRegistrar', $(
			'#id_imagen1Registrar').val());
		formData.append('imagen2ProductoRegistrar', $(
			'#id_imagen2Registrar').val());
		formData.append('imagen3ProductoRegistrar', $(
			'#id_imagen3Registrar').val());
		formData.append('descripcionLargaProducto', CKEDITOR.instances['editor1']
			.getData());
		$.ajax({
			type: 'POST',
			data: formData,
			enctype: 'multipart/form-data',
			url: 'registrarProducto',
			cache: false,
			contentType: false,
			processData: false,
			success: function(data) {
				if (data.CONFIRMACION == 'SI') {
					swal("¡Éxito!", data.MENSAJE, "success");
					setTimeout(function() {
						window.location = 'crudProductos';
					}, 1500);
				} else {
					swal("¡Aviso!", data.MENSAJE, "warning");
				}
			},
			error: function() {
				swal("¡Error!", "¡Comunicate con el administrador!",
					"error");
			}
		});
	}
}

function modificarProducto() {
	var c = "SI";
	if (CKEDITOR.instances['editor2'].document.getBody().getText() == ""
		|| CKEDITOR.instances['editor2'].document.getBody()
			.getText().length < 30) {
		$('#id_mensajeDescripcionLargaModificar').show();
		c = "NO";
	}
	var validator = $('#id_formModificarProducto').data(
		'bootstrapValidator');
	validator.validate();
	if (validator.isValid() && c === "SI") {
		var formData = new FormData($("#id_formModificarProducto")[0]);
		formData.append('imagen1ProductoModificar', $(
			'#id_imagen1Modificar').val());
		formData.append('imagen2ProductoModificar', $(
			'#id_imagen2Modificar').val());
		formData.append('imagen3ProductoModificar', $(
			'#id_imagen3Modificar').val());
		formData.append('descripcionLargaProducto', CKEDITOR.instances['editor2']
			.getData());
		$.ajax({
			type: 'POST',
			data: formData,
			enctype: 'multipart/form-data',
			url: 'modificarProducto',
			cache: false,
			contentType: false,
			processData: false,
			success: function(data) {
				if (data.CONFIRMACION == 'SI') {
					swal("¡Éxito!", data.MENSAJE, "success");
					setTimeout(function() {
						window.location = 'crudProductos';
					}, 1500);
				} else {
					swal("¡Aviso!", data.MENSAJE, "warning");
				}
			},
			error: function() {
				swal("¡Error!", "¡Comunicate con el administrador!",
					"error");
			}
		});
	}
}

function eliminarProducto() {
	$.ajax({
		type: 'POST',
		data: $("#id_formEliminarProducto").serialize(),
		url: 'eliminarProducto',
		success: function(data) {
			if (data.CONFIRMACION == 'SI') {
				swal("¡Éxito!", data.MENSAJE, "success");
				setTimeout(function() {
					window.location = 'crudProductos';
				}, 1500);
			} else {
				swal("¡Aviso!", data.MENSAJE, "warning");
			}
		},
		error: function() {
			swal("¡Error!", "¡Comunicate con el administrador!",
				"error");
		}
	});
}

// Funciones

function modificarTextArea(identificador, mensaje) {
	CKEDITOR
		.replace(
			identificador,
			{
				allowedContent: true,
				removePlugins: 'resize',
				language: 'es',
				toolbarGroups: [
					{
						name: 'clipboard',
						groups: ['undo', 'clipboard']
					},
					{
						name: 'editing',
						groups: ['find', 'selection',
							'spellchecker', 'editing']
					},
					{
						name: 'links',
						groups: ['links']
					},
					{
						name: 'insert',
						groups: ['insert']
					},
					{
						name: 'forms',
						groups: ['forms']
					},
					{
						name: 'tools',
						groups: ['tools']
					},
					{
						name: 'others',
						groups: ['others']
					},
					'/',
					{
						name: 'basicstyles',
						groups: ['basicstyles', 'cleanup']
					},
					{
						name: 'paragraph',
						groups: ['list', 'indent',
							'blocks', 'align', 'bidi',
							'paragraph']
					},
					{
						name: 'styles',
						groups: ['styles']
					},
					{
						name: 'colors',
						groups: ['colors']
					},
					{
						name: 'about',
						groups: ['about']
					},
					{
						name: 'document',
						groups: ['mode', 'document',
							'doctools']
					}],
				removeButtons: 'Subscript,About,Blockquote,Outdent,Indent,RemoveFormat,Strike,Table,Source',
				on: {
					change: function() {
						var des = CKEDITOR.instances[identificador].document
							.getBody().getText();
						if (des === '' || des.length <= 30) {
							$(
								'#id_mensajeDescripcionLarga'
								+ mensaje).show();
						} else {
							$(
								'#id_mensajeDescripcionLarga'
								+ mensaje).hide();
						}
					}
				}
			});
}


// ------------------- Métodos del CRUD Producto ------------------- //







// ------------------- Métodos del CRUD Servicio ------------------- //


// ------------------- CRUD para el Servicio ------------------- //
function registrarServicio() {
	var confirmHora = $("#id_ayudaHoraRegistrar").val();
	var c = "SI";
	if (confirmHora == "") {
		$('#id_mensajeHoraConfirmarRegistrar').show();
		var c = "NO";
	}
	if ($("#id_imagenRegistrar").val() === "") {
		$('#id_mensajeImagenRegistrar').show();
		var c = "NO";
	}
	var validator = $('#id_formRegistrarServicio').data(
		'bootstrapValidator');
	validator.validate();
	if (validator.isValid() && c === "SI") {
		var formData = new FormData($("#id_formRegistrarServicio")[0]);
		formData.append('imagenServicioRegistrar', $(
			'#id_imagenRegistrar').val());
		$.ajax({
			type: 'POST',
			data: formData,
			enctype: 'multipart/form-data',
			url: 'registrarServicio',
			cache: false,
			contentType: false,
			processData: false,
			success: function(data) {
				if (data.CONFIRMACION == 'SI') {
					swal("¡Éxito!", data.MENSAJE, "success");
					setTimeout(function() {
						window.location = 'crudServicios';
					}, 1500);
				} else {
					swal("¡Aviso!", data.MENSAJE, "warning");
				}
			},
			error: function() {
				swal("¡Error!", "¡Comunicate con el administrador!",
					"error");
			}
		});
	}
}

function modificarServicio() {
	var confirmHora = $("#id_ayudaHoraModificar").val();
	if (confirmHora == "") {
		$('#id_mensajeHoraConfirmarModificar').show();
		evt.preventDefault();
	}
	var validator = $('#id_formModificarServicio').data(
		'bootstrapValidator');
	validator.validate();
	if (validator.isValid() && confirmHora != "") {
		var formData = new FormData($("#id_formModificarServicio")[0]);
		formData.append('imagenServicioModificar', $(
			'#id_imagenModificar').val());
		$.ajax({
			type: 'POST',
			data: formData,
			enctype: 'multipart/form-data',
			url: 'modificarServicio',
			cache: false,
			contentType: false,
			processData: false,
			success: function(data) {
				if (data.CONFIRMACION == 'SI') {
					swal("¡Éxito!", data.MENSAJE, "success");
					setTimeout(function() {
						window.location = 'crudServicios';
					}, 1500);
				} else {
					swal("¡Aviso!", data.MENSAJE, "warning");
				}
			},
			error: function() {
				swal("¡Error!", "¡Comunicate con el administrador!",
					"error");
			}
		});
	}
}

function eliminarServicio() {
	$.ajax({
		type: 'POST',
		data: $("#id_formEliminarServicio").serialize(),
		url: 'eliminarServicio',
		success: function(data) {
			if (data.CONFIRMACION == 'SI') {
				swal("¡Éxito!", data.MENSAJE, "success");
				setTimeout(function() {
					window.location = 'crudServicios';
				}, 1500);
			} else {
				swal("¡Aviso!", data.MENSAJE, "warning");
			}
		},
		error: function() {
			swal("¡Error!", "¡Comunicate con el administrador!",
				"error");
		}
	});
}
// ------------------- CRUD para el Servicio ------------------- //


// ------------------- Funciones para el Servicio ------------------- //

// ------------------- Validar Fechas ------------------- //

function validarFechas() {
	$.ajax({
		type: 'GET',
		url: 'validarFechas',
		success: function(data) {
			if (data.CONFIRMACION == 'SI') {
				swal("¡Excelente!", data.MENSAJE, "success");
			} else {
				swal("¡Aviso!", data.MENSAJE, "warning");
			}
		},
		error: function() {
			swal("¡Error!", "¡Comunicate con el administrador!",
				"error");
		}
	});
}
// ------------------- Validar Fechas ------------------- //

// ------------------- Registrar Horarios ------------------- //
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
			swal("¡Aviso!", 'Solo se pueden agregar hasta 3 horarios de atención.', "warning");
		}
	} else if ((horaReg < 10) || (horaReg > 20)) {
		swal("¡Aviso!", 'El horario es desde las 10 Hrs hasta las 20 Hrs.', "warning");
	} else {
		swal("¡Aviso!", 'Solo se permiten números.', "warning");
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
// ------------------- Registrar Horarios ------------------- //


// ------------------- Modificar Horarios ------------------- //
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
			swal("¡Aviso!", 'Solo se pueden agregar hasta 3 horarios de atención.', "warning");
		}
	} else if ((horaMod < 10) || (horaMod > 20)) {
		swal("¡Aviso!", 'El horario es desde las 10 Hrs hasta las 20 Hrs.', "warning");
	} else {
		swal("¡Aviso!", 'Solo se permiten números.', "warning");
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
// ------------------- Modificar Horarios ------------------- //

// ------------------- Funciones para el Horario de Servicio ------------------- //


// ------------------- Métodos del CRUD Servicio ------------------- //







// ------------------- Métodos del CRUD Cliente ------------------- //
function registrarCliente() {
	var contra = $('#id_contrasenia').val();
	var contra2 = $('#id_contraseniaConfirmar').val();
	var validator = $('#id_formRegistrarCliente').data(
		'bootstrapValidator');
	validator.validate();
	if (validator.isValid() && (contra == contra2)) {
		$.ajax({
			type: 'POST',
			data: $("#id_formRegistrarCliente").serialize(),
			url: 'registrarCliente',
			success: function(data) {
				if (data.CONFIRMACION == 'SI') {
					swal("¡Éxito!", data.MENSAJE, "success");
					setTimeout(function() {
						window.location = 'datosMascotas';
					}, 1500);
				} else {
					swal("¡Aviso!", data.MENSAJE, "warning");
				}
			},
			error: function() {
				swal("¡Error!", "¡Comunicate con el administrador!",
					"error");
			}
		});
	}
}

function modificarCliente() {
	if ($("#id_contraseniaModificar").val() !== '') {
		$.ajax({
			type: 'POST',
			data: $("#id_formModificarClienteModal").serialize(),
			url: 'modificarCliente',
			success: function(data) {
				if (data.CONFIRMACION == 'SI') {
					swal("¡Éxito!", data.MENSAJE, "success");
					setTimeout(function() {
						window.location = 'datosMascotas';
					}, 1500);
				} else {
					swal("¡Aviso!", data.MENSAJE, "warning");
				}
			},
			error: function() {
				swal("¡Error!", "¡Comunicate con el administrador!",
					"error");
			}
		});
	}
}
// ------------------- Métodos del CRUD Cliente ------------------- //







// ------------------- Métodos del CRUD Mascota ------------------- //
function registrarMascota() {
	var c = "SI";
	if ($("#id_imagenRegistrar").val() == "") {
		$('#id_mensajeImagenRegistrar').show();
		c = "NO";
	}
	var validator = $('#id_formRegistrarMascota').data(
		'bootstrapValidator');
	validator.validate();
	if (validator.isValid() && c === "SI") {
		var formData = new FormData($("#id_formRegistrarMascota")[0]);
		formData.append('imagenMascotaRegistrar', $(
			'#id_imagenRegistrar').val());
		$.ajax({
			type: 'POST',
			data: formData,
			enctype: 'multipart/form-data',
			url: 'registrarMascota',
			cache: false,
			contentType: false,
			processData: false,
			success: function(data) {
				if (data.CONFIRMACION == 'SI') {
					swal("¡Éxito!", data.MENSAJE, "success");
					setTimeout(function() {
						window.location = 'datosMascotas';
					}, 1500);
				} else {
					swal("¡Aviso!", data.MENSAJE, "warning");
				}
			},
			error: function() {
				swal("¡Error!", "¡Comunicate con el administrador!",
					"error");
			}
		});
	}
}

function modificarMascota() {
	var validator = $('#id_formModificarMascota').data(
		'bootstrapValidator');
	validator.validate();
	if (validator.isValid()) {
		var formData = new FormData($("#id_formModificarMascota")[0]);
		formData.append('imagenMascotaModificar', $(
			'#id_imagenModificar').val());
		$.ajax({
			type: 'POST',
			data: formData,
			enctype: 'multipart/form-data',
			url: 'modificarMascota',
			cache: false,
			contentType: false,
			processData: false,
			success: function(data) {
				if (data.CONFIRMACION == 'SI') {
					swal("¡Éxito!", data.MENSAJE, "success");
					setTimeout(function() {
						window.location = 'datosMascotas';
					}, 1500);
				} else {
					swal("¡Aviso!", data.MENSAJE, "warning");
				}
			},
			error: function() {
				swal("¡Error!", "¡Comunicate con el administrador!",
					"error");
			}
		});
	}
}

function eliminarMascota() {
	$.ajax({
		type: 'POST',
		data: $("#id_formEliminarMascota").serialize(),
		url: 'eliminarMascota',
		success: function(data) {
			if (data.CONFIRMACION == 'SI') {
				swal("¡Éxito!", data.MENSAJE, "success");
				setTimeout(function() {
					window.location = 'datosMascotas';
				}, 1500);
			} else {
				swal("¡Aviso!", data.MENSAJE, "warning");
			}
		},
		error: function() {
			swal("¡Error!", "¡Comunicate con el administrador!",
				"error");
		}
	});
}
// ------------------- Métodos del CRUD Mascota ------------------- //