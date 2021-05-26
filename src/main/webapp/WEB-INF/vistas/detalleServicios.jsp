<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html lang="esS">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

<title>Proyecto Integrador</title>

<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/bootstrapValidator.js"></script>
<script type="text/javascript" src="datepicker/jquery-ui.js"></script>
<script type="text/javascript"
	src="datepicker/jquery.ui.datepicker-es.js"></script>

<link rel="stylesheet" href="datepicker/jquery-ui.css" />
<link rel="stylesheet" href="css/bootstrapValidator.css" />
</head>

<body class="">
	<div class="wrapper ">
		<jsp:include page="menuLateral.jsp" />
		<div class="main-panel">
			<jsp:include page="menuSuperior.jsp" />
			<div class="content">
				<div class="container-fluid">
					<div class="row">
						<div class="col-md-12">
							<div class="card">
								<div class="card-header card-header-primary">
									<h3 class="card-title">Detalles de Servicio</h3>
								</div>
								<div class="card-body">
									<form accept-charset="UTF-8" id="id_formRegistrarReserva"
										action="registrarReserva" method="post"
										enctype="multipart/form-data">
										<div class="row">
											<div class="col-md-12">
												<div class="row" hidden="hidden">
													<input class="form-control" type="text" id="id_idServicio"
														name="idServicio" value="${servicio.idServicio}">
													<input class="form-control" type="text" id="id_diaServicio"
														name="dia" value="${objNumeroDia}">
												</div>
												<div class="card-header"
													style="border-bottom: #9c27b0 1px solid;">
													<h2 class="card-title" style="color: #9c27b0">
														<strong>${servicio.nombre}</strong>
													</h2>
												</div>
												<div class="card-body" style="padding: 20px 10px;">
													<div class="row">
														<div class="col-md-8">
															<div class="form-group" id="div_stockModificar">
																<h5 class="card-title">
																	<strong>${servicio.descripcion}</strong>
																</h5>
															</div>
														</div>
														<div class="col-md-4">
															<img src="images/servicios/${servicio.imagen}"
																width="300px" height="300px" />
														</div>
													</div>
													<c:if test="${objIdCliente != null}">
														<div class="form-header header-primary">
															<h3>
																<i class="fa fa-calendar"> </i> Reserva del Servicio
																para tu Mascota
															</h3>
														</div>
														<div class="row">
															<div class="col-md-6">
																<label class="bmd-label">Mascota</label>
																<div class="caja">
																	<select id="id_mascotaReserva" class="estilo-select"
																		name="idMascota.idMascota">
																		<option value="">[ SELECCIONAR MASCOTA ]</option>
																		<c:forEach var="mascota" items="${mascotas}">
																			<option value="${mascota.idMascota}">${mascota.nombre}</option>
																		</c:forEach>
																	</select>

																</div>
																<button type="button"
																	onclick="verModalMascotaRegistra()"
																	class="btn btn-primary pull-right">Registrar
																	Nueva Mascota</button>
															</div>
														</div>
														<div class="row" style="margin-bottom: 10px;">
															<div class="col-md-12">
																<div class="row" style="padding-left: 15px;">
																	<div style="width: 240px; height: auto;">
																		<div class="form-group">
																			<label class="bmd-label">Separa tu Cita : </label> <br>
																			<input class="form-control" type="text"
																				id="id_fechaReserva" name="fecha"
																				readonly="readonly"> <small
																				id="id_mensajeFechaReserva" style="color: #cc0000;">La
																				fecha es obligatoria</small>
																		</div>
																		<div class="form-group" hidden="hidden">
																			<input type="text" id="id_horarioReserva"
																				name="horario" readonly="readonly">
																		</div>
																		<div id="datepicker"></div>
																	</div>
																	<div id="id_listadoHorarios"
																		style="width: 100px; height: auto; padding-top: 75px;">
																	</div>
																</div>
																<div class="row" style="padding-left: 15px;">
																	<small id="id_mensajeHorarioReserva"
																		style="color: #cc0000;">El horario es
																		obligatorio</small>
																</div>
															</div>
														</div>
													</c:if>
													<button type="button" onclick="history.go(-1)"
														class="btn btn-primary pull-left">Regresar</button>
													<c:if test="${objIdCliente == null}">
														<a href="login">
															<button type="button" class="btn btn-primary pull-left">Realizar
																Reserva</button>
														</a>
													</c:if>
													<c:if test="${objIdCliente != null}">
														<button type="submit" id="id_btnRegistrarReserva"
															class="btn btn-primary pull-left">Reservar
															Servicio</button>
													</c:if>
												</div>
											</div>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="RegistraMascota.jsp" />
	</div>

	<script type="text/javascript">
		$('#id_menuServicios').addClass('active');
		$('#id_mensajeHorarioReserva').hide();
		$('#id_mensajeFechaReserva').hide();

		$(function() {
			var ayuda = $("#id_diaServicio").val();
			var id = $("#id_idServicio").val();
			$("#datepicker")
					.datepicker(
							{
								minDate : 0,
								maxDate : "+1M",
								dateFormat : 'dd/mm/yy',
								dayNamesMin : [ "Do", "Lu", "Ma", "Mi", "Ju",
										"Vi", "Sa" ],
								dayNamesShort : [ "Dom", "Lun", "Mar", "Mie",
										"Jue", "Vie", "Sab" ],
								monthNames : [ "Enero", "Febrero", "Marzo",
										"Abril", "Mayo", "Junio", "Julio",
										"Agosto", "Septiembre", "Octubre",
										"Noviembre", "Diciembre" ],
								monthNamesShort : [ "Ene", "Feb", "Mar", "Abr",
										"May", "Jun", "Jul", "Ago", "Sep",
										"Oct", "Nov", "Dic" ],
								beforeShowDay : function(day) {
									var day = day.getDay();
									if (day == ayuda) {
										return [ true, "someothercssclass" ]
									} else {
										return [ false, "somecssclass" ]
									}
								},
								onSelect : function(selectedDate) {
									$("#id_fechaReserva").val(selectedDate);
									$("#id_listadoHorarios div").remove();
									$('#id_mensajeFechaReserva').hide();
									$("#id_btnRegistrarReserva").attr(
											'disabled', false);
									$
											.getJSON(
													'fechas',
													{
														"fecha" : selectedDate,
														"idServicio" : id
													},
													function(data) {
														$
																.each(
																		data,
																		function(
																				index,
																				item) {
																			if (item.estado == 'libre') {
																				$(
																						"#id_listadoHorarios")
																						.append(
																								"<div class='col-md-12'>"
																										+ "<div class='form-group'>"
																										+ "<input class='btn btn-primary' type='button'"
																										+ "style='font-size:14px;' value='"
																										+ item.idHorariosServicios.horario
																										+ "' onclick=\"agregarHorarioReserva('"
																										+ item.idHorariosServicios.horario
																										+ "');\">"
																										+ "</div></div>");
																			} else {
																				$(
																						"#id_listadoHorarios")
																						.append(
																								"<div class='col-md-12'>"
																										+ "<div class='form-group'>"
																										+ "<input class='btn btn-primary' type='button'"
																				+ "style='font-size:14px;' disabled='diabled' value='"
																				+ item.idHorariosServicios.horario
																				+ "'>"
																										+ "</div></div>");
																			}
																		});
													});
								}
							});
		});

		function agregarHorarioReserva(horario) {
			$('#id_mensajeHorarioReserva').hide();
			$("#id_horarioReserva").val(horario);
			$("#id_btnRegistrarReserva").attr('disabled', false);
		}

		$("#id_formRegistrarReserva").on(
				'submit',
				function(evt) {
					evt.preventDefault();
					var idServicio = $("#id_idServicio").val();
					var horario = $("#id_horarioReserva").val();
					var fecha = $("#id_fechaReserva").val();
					var idMascota = $("#id_mascotaReserva option:selected")
							.val();

					var validator = $('#id_formRegistrarReserva').data(
							'bootstrapValidator');
					if (validator.isValid()) {
						var confirmar = 'SI';
						if (horario == '') {
							$('#id_mensajeHorarioReserva').show();
							$("#id_btnRegistrarReserva")
									.attr('disabled', false);
							confirmar = "NO";
						}
						if (fecha == '') {
							$('#id_mensajeFechaReserva').show();
							$("#id_btnRegistrarReserva")
									.attr('disabled', false);
							confirmar = "NO";
						}
						if (confirmar == 'SI') {
							$.ajax({
								type : 'POST',
								data : {
									'idMascota' : idMascota,
									'idServicio' : idServicio,
									'fecha' : fecha,
									'horario' : horario
								},
								url : 'validacionReservaServicio',
								success : function(data) {
									if (data.CONFIRMACION === 'SI') {
										swal("¡Registrado con éxito!",
												data.MENSAJE, "success");
										setTimeout(function() {
											evt.target.submit();
										}, 500);
									} else {
										swal("¡Error!", data.MENSAJE, "error");
									}
								},
								error : function() {
									swal("¡Error!", "", "error");
								}
							});
						}
					}
				});
	</script>

	<script type="text/javascript">
		$(document).ready(function() {
			$('#id_formRegistrarReserva').bootstrapValidator({
				message : 'This value is not valid',
				feedbackIcons : {
					valid : 'glyphicon glyphicon-ok',
					invalid : 'glyphicon glyphicon-remove',
					validating : 'glyphicon glyphicon-refresh'
				},
				fields : {
					mascota : {
						selector : "#id_mascotaReserva",
						validators : {
							notEmpty : {
								message : 'La mascota es obligatoria'
							}
						}
					}
				}
			});
		});
	</script>


</body>
</html>