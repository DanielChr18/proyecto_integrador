<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html lang="esS">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

<link rel="icon" type="image/png" href="images/logo.png">
<title>Proyecto Integrador</title>

<script type="text/javascript" src="js/core/jquery.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/bootstrapValidator.js"></script>
<script type="text/javascript" src="ckeditor/ckeditor.js"></script>

<link rel="stylesheet" href="css/estilo1.1.css" />
<link rel="stylesheet" type="text/css" href="vendor/main.css" />
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
									<h3 class="card-title">
										<i class="material-icons">leaderboard</i> Historial de Mascota
									</h3>
								</div>
								<div class="card-body">
									<div class="row">
										<div class="col-md-12">
											<div class="card" style="margin-top: 20px;">
												<div
													class="card-header card-header-tabs card-header-primary">
													<div class="nav-tabs-navigation">
														<div class="nav-tabs-wrapper">
															<ul class="nav nav-tabs" data-tabs="tabs">
																<c:if test="${objCargo == 'Veterinario'}">
																	<li class="nav-item" style="margin-right: 10px;"><a
																		class="nav-link active" href="#historiales"
																		data-toggle="tab"> <i class="material-icons">history_edu</i>Historial
																			de Mascotas
																	</a></li>
																	<li class="ripple-container"></li>
																	<li class="nav-item"><a class="nav-link"
																		href="#reservas" data-toggle="tab"> <i
																			class="material-icons">book_online</i>Reservas
																	</a></li>
																</c:if>
																<c:if test="${objCargo == 'Cliente'}">
																	<li class="nav-item"><a class="nav-link active"
																		href="#historiales" data-toggle="tab"> <i
																			class="material-icons">history_edu</i>Historial de
																			Mascotas
																	</a></li>
																</c:if>
															</ul>
														</div>
													</div>
												</div>
												<div class="card-body">
													<div class="tab-content">
														<div class="tab-pane active" id="historiales">

															<c:if test="${objCargo == 'Cliente'}">
																<div class="row" style="margin: 10px 0px;">
																	<div class="col-md-9">
																		<div class="form-group" style="padding-left: 10px;">
																			<label class="bmd-label-floating">Nombre de
																				la Mascota </label> <input type="text" class="form-control"
																				id="id_nombreMascotaP">
																		</div>
																	</div>
																	<div class="col-md-1 offset-1">
																		<button onclick="buscarMascota();" type="button"
																			id="id_btnBuscar" class="btn btn-primary pull-right">Buscar</button>
																	</div>
																</div>
															</c:if>

															<c:if test="${objCargo == 'Veterinario'}">
																<div class="row" style="margin: 10px 0px;">
																	<div class="col-md-9">
																		<div class="form-group" style="padding-left: 10px;">
																			<label class="bmd-label-floating">Nombre del
																				Cliente </label> <input type="text" class="form-control"
																				id="id_nombreClienteHistorial">
																		</div>
																	</div>
																	<div class="col-md-1 offset-1">
																		<button onclick="buscarClienteHistorial();"
																			type="button" id="id_btnBuscar"
																			class="btn btn-primary pull-right">Buscar</button>
																	</div>
																</div>
															</c:if>
															<c:if test="${historiales != null}">
																<table id="tablaHistoriales" class="table table-hover">
																	<thead class="text-primary">
																		<tr>
																			<th style="width: 40px;">ID</th>
																			<c:if test="${objCargo == 'Veterinario'}">
																				<th>Cliente</th>
																			</c:if>
																			<th>Mascota</th>
																			<th>Fecha</th>
																			<th>Hora</th>
																			<th>Observación</th>

																		</tr>
																	</thead>
																	<tbody>
																		<c:forEach items="${historiales}" var="h">
																			<tr>
																				<td>${h.idHistorialMascota}</td>
																				<c:if test="${objCargo == 'Veterinario'}">
																					<td>${h.idReserva.idCliente.nombre}</td>
																				</c:if>
																				<td>${h.idReserva.idMascota.nombre}</td>
																				<td>${h.fecha}</td>
																				<td>${h.hora}</td>
																				<c:if test="${objCargo == 'Cliente'}">
																					<td><button
																							onclick="verModalHistorialMascota('${h.idHistorialMascota}','${h.idReserva.idServicio.nombre}','${h.idTrabajador.nombre}');"
																							type="button" id="id_btnBuscar"
																							class="btn btn-primary">Ver</button></td>
																				</c:if>
																				<c:if test="${objCargo == 'Veterinario'}">
																					<td><button
																							onclick="verModalHistorialVeterinario('${h.idHistorialMascota}','${h.idReserva.idMascota.nombre}','${h.fecha}','${h.hora}');"
																							type="button" id="id_btnBuscar"
																							class="btn btn-primary">Ver</button></td>

																				</c:if>

																			</tr>
																		</c:forEach>
																	</tbody>
																</table>
															</c:if>
															<c:if test="${historiales == null}">
																<h4>No hay historiales de tus mascotas.</h4>
															</c:if>
														</div>
														<div class="tab-pane" id="reservas">
															<c:if test="${objCargo == 'Veterinario'}">
																<div class="row" style="margin: 10px 0px;">
																	<div class="col-md-9">
																		<div class="form-group" style="padding-left: 10px;">
																			<label class="bmd-label-floating">Nombre del
																				Cliente </label> <input type="text" class="form-control"
																				id="id_nombreClienteHistorialReserva">
																		</div>
																	</div>
																	<div class="col-md-1 offset-1">
																		<button onclick="buscarClienteHistorialReserva();"
																			type="button" id="id_btnBuscar"
																			class="btn btn-primary pull-right">Buscar</button>
																	</div>
																</div>
															</c:if>
															<c:if test="${reservas != null}">
																<table id="tablaReservas" class="table table-hover">
																	<thead class="text-primary">
																		<tr>
																			<th style="width: 40px;">ID</th>
																			<th>Cliente</th>
																			<th>Mascota</th>
																			<th>Fecha</th>
																			<th>Hora</th>
																			<th>Atender</th>
																		</tr>
																	</thead>
																	<tbody>
																		<c:forEach items="${reservas}" var="h">
																			<tr>
																				<td>${h.idReserva}</td>
																				<td>${h.idCliente.nombre}</td>
																				<td>${h.idMascota.nombre}</td>
																				<td>${h.fecha}</td>
																				<td>${h.horario}</td>
																				<c:if test="${objCargo == 'Veterinario'}">
																					<td><button
																							onclick="verModalHistorialReserva('${h.idReserva}','${h.idMascota.nombre}','${h.fecha}','${h.horario}');"
																							type="button" id="id_btnBuscar"
																							class="btn btn-primary">Ver</button></td>

																				</c:if>
																			</tr>
																		</c:forEach>
																	</tbody>
																</table>
															</c:if>
															<c:if test="${reservas == null}">
																<h4>No hay reservas para atender.</h4>
															</c:if>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- Modal de Filtro Historial Mascota de Cliente -->
		<div class="modal fade" id="idModalHistorialMascota"
			data-backdrop="static" tabindex="-1" role="dialog">
			<div class="modal-dialog" style="width: 55%;">
				<!-- Modal content-->
				<div class="modal-content">
					<div class="card">
						<div class="card-header card-header-primary">
							<h3 class="card-title">Observación</h3>
						</div>
						<div class="card-body" style="padding: 20px 18px;">
							<form accept-charset="UTF-8" id="id_formHistorialMascota">
								<div class="row">
									<input class="form-control" type="text"
										id="id_idHistorialMascota" hidden="hidden" name="idReserva">
									<div class="col-md-12">
										<div class="form-group">
											<label class="bmd-label-floating">Servicio</label> <input
												class="form-control" type="text"
												id="id_nombreServicioHistorialMascota" readonly="readonly">
										</div>
									</div>
									<div class="col-md-12">
										<div class="form-group">
											<label class="bmd-label-floating">Veterinario</label> <input
												class="form-control" type="text"
												id="id_nombreVeterinarioHistorialMascota"
												readonly="readonly">
										</div>
									</div>
									<div class="col-md-12">
										<label class="bmd-label-floating"></label>
										<textarea id="editor4" disabled="disabled"
											name="descripcionLarga" readonly="readonly"></textarea>
										<small id="id_mensajeDescripcionLargaConsMascota"></small>
									</div>
								</div>
								<button type="button" onclick="cerrarModalHistorialMascota();"
									class="btn btn-primary pull-right">Cerrar</button>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>


		<!-- Modal de Historial Veterinario-->
		<div class="modal fade" id="idModalHistorialVeterinario"
			data-backdrop="static" tabindex="-1" role="dialog">
			<div class="modal-dialog" style="width: 55%;">
				<!-- Modal content-->
				<div class="modal-content">
					<div class="card">
						<div class="card-header card-header-primary">
							<h3 class="card-title">Historial Veterinario</h3>
						</div>
						<div class="card-body" style="padding: 20px 18px;">
							<form accept-charset="UTF-8" id="id_formHistorialVeterinario">
								<div class="row">
									<input class="form-control" type="text"
										id="id_idHistorialVeterinario" hidden="hidden"
										name="idReserva">
									<div class="col-md-12">
										<div class="form-group">
											<label class="bmd-label-floating">Mascota</label> <input
												class="form-control" type="text"
												id="id_nombreMascotaHistorialVeterinario"
												readonly="readonly">
										</div>
									</div>
									<div class="col-md-12">
										<div class="form-group">
											<label class="bmd-label-floating">Fecha</label> <input
												class="form-control" type="text"
												id="id_fechaHistorialVeterinario" readonly="readonly">
										</div>
									</div>
									<div class="col-md-12">
										<div class="form-group">
											<label class="bmd-label-floating">Horario</label> <input
												class="form-control" type="text"
												id="id_horarioHistorialVeterinario" readonly="readonly">
										</div>
									</div>
									<div class="col-md-12">
										<label class="bmd-label-floating">Observación</label>
										<textarea id="editor5" name="descripcionLarga"
											readonly="readonly"></textarea>
										<small id="id_mensajeDescripcionLargaConsCliente"></small>
									</div>
								</div>
								<button type="button"
									onclick="cerrarModalHistorialVeterinario();"
									class="btn btn-primary pull-right">Cerrar</button>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- Modal de Historial Reserva-->
		<div class="modal fade" id="idModalHistorialReserva"
			data-backdrop="static" tabindex="-1" role="dialog">
			<div class="modal-dialog" style="width: 55%;">
				<!-- Modal content-->
				<div class="modal-content">
					<div class="card">
						<div class="card-header card-header-primary">
							<h3 class="card-title">Historial Reserva</h3>
						</div>
						<div class="card-body" style="padding: 20px 18px;">
							<form accept-charset="UTF-8" id="id_formHistorialReserva">
								<div class="row">
									<input class="form-control" type="text"
										id="id_idHistorialReserva" hidden="hidden" name="idReserva">
									<div class="col-md-12">
										<div class="form-group">
											<label class="bmd-label-floating">Mascota</label> <input
												class="form-control" type="text"
												id="id_nombreMascotaHistorialReserva" readonly="readonly">
										</div>
									</div>
									<div class="col-md-12">
										<div class="form-group">
											<label class="bmd-label-floating">Fecha</label> <input
												class="form-control" type="text"
												id="id_fechaHistorialReserva" readonly="readonly">
										</div>
									</div>
									<div class="col-md-12">
										<div class="form-group">
											<label class="bmd-label-floating">Horario</label> <input
												class="form-control" type="text"
												id="id_horarioHistorialReserva" readonly="readonly">
										</div>
									</div>
									<div class="col-md-12">
										<label class="bmd-label-floating">Observación</label>
										<textarea id="editor6" name="descripcionLarga"></textarea>
										<small id="id_mensajeDescripcionLargaConsReserva"
											style="color: #cc0000;">La observación debe tener 30
											caracteres como mínimo</small>
									</div>
								</div>
								<button type="button" onclick="cerrarModalHistorialReserva();"
									class="btn btn-primary pull-right">Cerrar</button>
								<button id="id_btnRegistrarCita"
									onclick="registrarHistorialMascota();" type="button"
									class="btn btn-primary pull-right">Registrar</button>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Modal Historial Mascota -->
	<script type="text/javascript">
		function verModalHistorialMascota(id, nombreServicio, nombreVeterinario) {
			$("#id_idHistorialMascota").val(id);
			$("#id_nombreServicioHistorialMascota").val(nombreServicio);
			$("#id_nombreVeterinarioHistorialMascota").val(nombreVeterinario);
			CKEDITOR.instances['editor4'].setData("");
			$.getJSON('obtenerHtmlHistorialMascota', {
				"idHistorialMascota" : id
			}, function(data) {
				CKEDITOR.instances['editor4'].setData(data.descripcion);
				$("#id_idHistorialMascota").val(data.idHistorialMascota);
			});
			$("#id_formHistorialMascota .col-md-12 .form-group").addClass(
					"is-filled");
			$("#idModalHistorialMascota").modal("show");
		}

		function cerrarModalHistorialMascota() {
			$("#idModalHistorialMascota").modal("hide");
		}
	</script>


	<!-- Modal Historial Veterinario -->
	<script type="text/javascript">
		function verModalHistorialVeterinario(id, nombreMascota, fecha, horario) {
			$("#id_idHistorialVeterinario").val(id);
			$("#id_nombreMascotaHistorialVeterinario").val(nombreMascota);
			$("#id_fechaHistorialVeterinario").val(fecha);
			$("#id_horarioHistorialVeterinario").val(horario);
			CKEDITOR.instances['editor5'].setData("");
			$.getJSON('obtenerHtmlHistorialMascota', {
				"idHistorialMascota" : id
			}, function(data) {
				CKEDITOR.instances['editor5'].setData(data.descripcion);
				$("#id_idHistorialVeterinario").val(data.idHistorialMascota);
			});
			$("#id_formHistorialVeterinario .col-md-12 .form-group").addClass(
					"is-filled");
			$("#idModalHistorialVeterinario").modal("show");
		}

		function cerrarModalHistorialVeterinario() {
			$("#idModalHistorialVeterinario").modal("hide");
		}
	</script>

	<!-- Modal Historial Reserva -->
	<script type="text/javascript">
		function verModalHistorialReserva(id, nombreMascota, fecha, horario) {
			$("#id_idHistorialReserva").val(id);
			$("#id_nombreMascotaHistorialReserva").val(nombreMascota);
			$("#id_fechaHistorialReserva").val(fecha);
			$("#id_horarioHistorialReserva").val(horario);
			$("#id_formHistorialReserva .col-md-12 .form-group").addClass(
					"is-filled");
			$("#idModalHistorialReserva").modal("show");
		}

		function cerrarModalHistorialReserva() {
			$("#idModalHistorialReserva").modal("hide");
		}
	</script>


	<!-- Script de TextArea  -->
	<script type="text/javascript">
		$(document).ready(function() {
			$('#id_mensajeDescripcionLargaConsReserva').hide();
			$('#id_menuHistorialMascotas').addClass('active');
			modificarTextArea('editor4', 'ConsMascota');
			modificarTextArea('editor5', 'ConsCliente');
			modificarTextArea('editor6', 'ConsReserva');
		});
	</script>

	<script type="text/javascript">
		function registrarHistorialMascota() {
			var c = "SI";
			if (CKEDITOR.instances['editor6'].document.getBody().getText() == ""
					|| CKEDITOR.instances['editor6'].document.getBody()
							.getText().length < 30) {
				$('#id_mensajeDescripcionLargaConsReserva').show();
				c = "NO";
			}
			if (c === 'SI') {
				$.ajax({
					type : 'POST',
					data : {
						'idReserva' : $("#id_idHistorialReserva").val(),
						'descripcionLarga' : CKEDITOR.instances['editor6']
								.getData()
					},
					url : 'registrarHistorialMascota',
					success : function(data) {
						if (data.CONFIRMACION == 'SI') {
							swal("¡Éxito!", data.MENSAJE, "success");
							setTimeout(function() {
								window.location = 'historialMascotas';
							}, 1500);
						} else {
							swal("¡Error!", data.MENSAJE, "error");
						}
					},
					error : function() {
						swal("¡Error!", "¡Comunicate con el administrador!",
								"error");
					}
				});
			}
		}
	</script>

	<script type="text/javascript">
		$("#id_nombreMascotaP").on("keypress", function(event) {
			if (event.which == 13) {
				buscarMascota();
			}
		});

		function buscarMascota() {
			var nom = $("#id_nombreMascotaP").val();
			$("#tablaHistoriales tbody tr").remove();
			$
					.getJSON(
							'listarHistorialMascotaNombre',
							{
								"nombreMascotaP" : nom
							},
							function(data) {
								$
										.each(
												data,
												function(index, item) {
													$("#tablaHistoriales")
															.append(
																	"<tr><td>"
																			+ item.idHistorialMascota
																			+ "</td>"
																			+ "<td>"
																			+ item.idReserva.idMascota.nombre
																			+ "</td>"
																			+ "<td>"
																			+ item.fecha
																			+ "</td>"
																			+ "<td>"
																			+ item.hora
																			+ "</td>"
																			+ "<td>"
																			+ "<button type='button' onclick=\"verModalHistorialMascota('"
																			+ item.idHistorialMascota
																			+ "','"
																			+ item.idReserva.idServicio.nombre
																			+ "','"
																			+ item.idTrabajador.nombre
																			+ "');\" class='btn btn-primary'> Ver </button>"
																			+ "</td></tr>");
												});
							});
		}
	</script>


	<!-- HISTORIAL cosultar YA ESTAA -->
	<script type="text/javascript">
		$("#id_nombreClienteHistorial").on("keypress", function(event) {
			if (event.which == 13) {
				buscarClienteHistorial();
			}
		});

		function buscarClienteHistorial() {
			var nom = $("#id_nombreClienteHistorial").val();
			$("#tablaHistoriales tbody tr").remove();
			$
					.getJSON(
							'listarHistorialClienteNombre',
							{
								"nombreClienteHistorial" : nom
							},
							function(data) {
								$
										.each(
												data,
												function(index, item) {
													$("#tablaHistoriales")
															.append(
																	"<tr><td>"
																			+ item.idHistorialMascota
																			+ "</td>"
																			+ "<td>"
																			+ item.idReserva.idCliente.nombre
																			+ "</td>"
																			+ "<td>"
																			+ item.idReserva.idMascota.nombre
																			+ "</td>"
																			+ "<td>"
																			+ item.fecha
																			+ "</td>"
																			+ "<td>"
																			+ item.hora
																			+ "</td>"
																			+ "<td>"
																			+ "<button type='button' onclick=\"verModalHistorialVeterinario('"
																			+ item.idHistorialMascota
																			+ "','"
																			+ item.idReserva.idMascota.nombre
																			+ "','"
																			+ item.fecha
																			+ "','"
																			+ item.hora
																			+ "');\" class='btn btn-primary'> Ver </button>"
																			+ "</td></tr>");
												});
							});
		}
	</script>

	<script type="text/javascript">
		$("#id_nombreClienteHistorialReserva").on("keypress", function(event) {
			if (event.which == 13) {
				buscarClienteHistorialReserva();
			}
		});

		function buscarClienteHistorialReserva() {
			var nom = $("#id_nombreClienteHistorialReserva").val();
			$("#tablaReservas tbody tr").remove();
			$
					.getJSON(
							'listarReservasCliente',
							{
								"nombreClienten" : nom
							},
							function(data) {
								$
										.each(
												data,
												function(index, item) {
													$("#tablaReservas")
															.append(
																	"<tr><td>"
																			+ item.idReserva
																			+ "</td>"
																			+ "<td>"
																			+ item.idCliente.nombre
																			+ "</td>"
																			+ "<td>"
																			+ item.idMascota.nombre
																			+ "</td>"
																			+ "<td>"
																			+ item.fecha
																			+ "</td>"
																			+ "<td>"
																			+ item.horario
																			+ "</td>"
																			+ "<td>"
																			+ "<button type='button' onclick=\"verModalHistorialReserva('"
																			+ item.idReserva
																			+ "','"
																			+ item.idMascota.nombre
																			+ "','"
																			+ item.fecha
																			+ "','"
																			+ item.horario
																			+ "');\" class='btn btn-primary'> Ver </button>"
																			+ "</td></tr>");
												});
							});
		}
	</script>

</body>
</html>