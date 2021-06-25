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
	<c:if
		test="${objCargo == 'Cliente' || objCargo == 'Personal de Ventas'||objCargo == 'Veterinario'}">
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
											<i class="material-icons">leaderboard</i> Transacciones
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
																	<li class="nav-item"><a class="nav-link active"
																		href="#productos" data-toggle="tab"> <i
																			class="material-icons">inventory_2</i> <c:if
																				test="${objCargo == 'Cliente'}">Productos</c:if> <c:if
																				test="${objCargo == 'Personal de Ventas'}">Boletas</c:if>
																			<div class="ripple-container"></div>
																	</a></li>
																	<li class="nav-item"><a class="nav-link"
																		href="#servicios" data-toggle="tab"> <i
																			class="material-icons">medical_services</i> <c:if
																				test="${objCargo == 'Cliente'}">Servicios</c:if> <c:if
																				test="${objCargo == 'Personal de Ventas'|| objCargo == 'Veterinario'}">Reservas</c:if>
																			<div class="ripple-container"></div>
																	</a></li>
																</ul>
															</div>
														</div>
													</div>
													<div class="card-body">
														<div class="tab-content">
															<div class="tab-pane active" id="productos">
																<c:if test="${pedidos != null}">
																	<table id="tablaPedidos" class="table table-hover">
																		<thead class="text-primary">
																			<tr>
																				<th style="width: 40px;">ID</th>
																				<th>Número</th>
																				<th>Nombre</th>
																				<th>DNI</th>
																				<th>Monto</th>
																				<th>Fecha</th>
																				<th>Estado</th>
																				<c:if test="${objCargo == 'Cliente'}">
																					<th style="width: 102.4px;">Detalle</th>
																				</c:if>
																				<c:if test="${objCargo == 'Personal de Ventas'}">
																					<th style="width: 102.4px;">Editar</th>
																				</c:if>



																			</tr>
																		</thead>
																		<tbody>
																			<c:forEach items="${pedidos}" var="p">
																				<tr>
																					<td>${p.idBoleta}</td>
																					<td>${p.numero}</td>
																					<td>${p.nombre}</td>
																					<td>${p.dni}</td>
																					<td>${p.monto}</td>
																					<td>${p.fecha}</td>
																					<td>${p.estado}</td>
																					<c:if test="${objCargo == 'Cliente'}">
																						<td>
																							<button type="button"
																								onclick="verModalDetalleBoleta('${p.idBoleta}');"
																								class="btn btn-primary">
																								<span class="material-icons">
																									receipt_long </span>
																							</button>
																						</td>
																					</c:if>
																					<c:if test="${objCargo == 'Personal de Ventas'}">
																						<td>
																							<button type="button"
																								onclick="verModalEditarBoleta('${p.idBoleta}','${p.numero}','${p.nombre}','${p.dni}','${p.monto}','${p.estado}');"
																								class="btn btn-primary">
																								<img src="images/edit.gif" width="auto"
																									height="auto" />
																							</button>
																						</td>
																					</c:if>
																				</tr>
																			</c:forEach>
																		</tbody>
																	</table>
																</c:if>
																<c:if test="${pedidos == null}">
																	<h4>No tienes pedidos realizados.</h4>
																</c:if>
															</div>
															<div class="tab-pane" id="servicios">
																<c:if test="${servicios != null}">
																	<table id="tablaServicios" class="table table-hover">
																		<thead class="text-primary">
																			<tr>
																				<th style="width: 40px;">ID</th>
																				<c:if test="${objCargo == 'Personal de Ventas'}">
																					<th>Cliente</th>
																				</c:if>
																				<c:if test="${objCargo == 'Veterinario'}">
																					<div class="row">
																						<div class="col-md-6">
																							<div class="form-group">
																								<select id="id_cliente" name="idCliente"
																									class='form-control'>
																									<option value="-1">[Todos]</option>
																								</select>
																							</div>
																						</div>
																						<div class="col-md-3">
																							<div class="form-group">
																								<button id="id_filtrar" type="button"
																									class="btn btn-primary">Filtrar</button>
																							</div>
																						</div>
																					</div>
																					
																				</c:if>

																				<th>Mascota</th>
																				<th>Fecha</th>
																				<th>Horario</th>
																				<th>Estado</th>
																				<c:if test="${objCargo == 'Cliente'}">
																					<th style="width: 102.4px;">Pagar</th>
																				</c:if>
																				<c:if test="${objCargo == 'Personal de Ventas'}">
																					<th style="width: 102.4px;">Editar</th>
																				</c:if>
																				<c:if test="${objCargo == 'Veterinario'}">
																					<th style="width: 102.4px;">Atender</th>
																				</c:if>

																			</tr>
																		</thead>
																		<tbody>
																			<c:forEach items="${servicios}" var="s">
																				<tr>
																					<td>${s.idReserva}</td>
																					<c:if test="${objCargo == 'Personal de Ventas'}">
																						<td>${s.idCliente.nombre}</td>
																					</c:if>
																					<td>${s.idMascota.nombre}</td>
																					<td>${s.fecha}</td>
																					<td>${s.horario}</td>
																					<td>${s.estado}</td>
																					<c:if
																						test="${objCargo == 'Cliente' && s.estado == 'pendiente de pago'}">
																						<td>
																							<button type="button"
																								onclick="verModalMetodoPago('${s.idReserva}');"
																								class="btn btn-primary">
																								<span class="material-icons"> paid </span>
																							</button>
																						</td>
																					</c:if>
																					<c:if
																						test="${objCargo == 'Cliente' && s.estado != 'pendiente de pago'}">
																						<td>
																							<button type="button" disabled="disabled"
																								onclick="verModalMetodoPago('${s.idReserva}');"
																								class="btn btn-primary">
																								<span class="material-icons"> paid </span>
																							</button>
																						</td>
																					</c:if>
																					<c:if test="${objCargo == 'Personal de Ventas'}">
																						<td>
																							<button type="button"
																								onclick="verModalEditarReserva('${s.idReserva}','${s.idCliente.nombre}','${s.idMascota.nombre}','${s.fecha}','${s.horario}','${s.estado}');"
																								class="btn btn-primary">
																								<img src="images/edit.gif" width="auto"
																									height="auto" />
																							</button>
																						</td>
																					</c:if>

																					<c:if test="${objCargo == 'Veterinario'}">
																						<td>
																							<button type="button" 
																							onclick="verModalVeterinario('${s.idReserva}','${s.idCliente.nombre}','${s.idMascota.nombre}','${s.fecha}','${s.horario}','${s.estado}');"
																							class="btn btn-primary">
																								<img src="images/edit.gif" width="auto"
																									height="auto" />
																							</button>
																						</td>
																					</c:if>
																				</tr>
																			</c:forEach>
																		</tbody>
																	</table>
																</c:if>
																<c:if test="${servicios == null}">
																	<h4>No tienes reservas realizadas.</h4>
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

			<!-- Modal de Editar Boleta -->
			<div class="modal fade" id="idModalEditarBoleta"
				data-backdrop="static" tabindex="-1" role="dialog">
				<div class="modal-dialog" style="width: 50%;">
					<!-- Modal content-->
					<div class="modal-content">
						<div class="card">
							<div class="card-header card-header-primary">
								<h3 class="card-title">Editar Boleta</h3>
							</div>
							<div class="card-body" style="padding: 20px 18px;">
								<form accept-charset="UTF-8" id="id_formEditarBoleta">
									<div class="row">
										<input class="form-control" type="text" id="id_idBoletaEditar"
											hidden="hidden" name="idBoleta">
										<div class="col-md-12">
											<div class="form-group">
												<label class="bmd-label-floating">Número</label> <input
													class="form-control" type="text" id="id_numeroBoletaEditar"
													name="numero" readonly="readonly">
											</div>
										</div>
										<div class="col-md-12">
											<div class="form-group">
												<label class="bmd-label-floating">Nombre</label> <input
													class="form-control" type="text" id="id_nombreBoletaEditar"
													name="nombre" readonly="readonly">
											</div>
										</div>
										<div class="col-md-12">
											<div class="form-group">
												<label class="bmd-label-floating">DNI</label> <input
													class="form-control" type="text" id="id_dniBoletaEditar"
													name="dni" readonly="readonly">
											</div>
										</div>
										<div class="col-md-12">
											<div class="form-group">
												<label class="bmd-label-floating">Monto</label> <input
													class="form-control" type="text" id="id_montoBoletaEditar"
													name="monto" readonly="readonly">
											</div>
										</div>
										<div class="col-md-12">
											<div class="form-group">
												<label class="bmd-label">Estado</label>
												<div class="caja">
													<select class="estilo-select" id="id_estadoBoletaEditar"
														name="estado">
														<option value="En Proceso">En Proceso</option>
														<option value="Enviado">Enviado</option>
														<option value="Entregado">Entregado</option>
													</select>
												</div>
											</div>
										</div>
									</div>
									<button type="button" onclick="cerrarModalEditarBoleta();"
										class="btn btn-primary pull-right">Cerrar</button>
									<button id="id_btnEditarBoleta" onclick="editarBoleta();"
										type="button" class="btn btn-primary pull-right">Editar</button>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>

			<!-- Modal de Editar Reserva-->
			<div class="modal fade" id="idModalEditarReserva"
				data-backdrop="static" tabindex="-1" role="dialog">
				<div class="modal-dialog" style="width: 50%;">
					<!-- Modal content-->
					<div class="modal-content">
						<div class="card">
							<div class="card-header card-header-primary">
								<h3 class="card-title">Editar Reserva</h3>
							</div>
							<div class="card-body" style="padding: 20px 18px;">
								<form accept-charset="UTF-8" id="id_formEditarReserva">
									<div class="row">
										<input class="form-control" type="text"
											id="id_idReservaEditar" hidden="hidden" name="idReserva">
										<div class="col-md-12">
											<div class="form-group">
												<label class="bmd-label-floating">Nombre Cliente</label> <input
													class="form-control" type="text"
													id="id_nombreClienteReservaEditar" readonly="readonly">
											</div>
										</div>
										<div class="col-md-12">
											<div class="form-group">
												<label class="bmd-label-floating">Nombre Mascota</label> <input
													class="form-control" type="text"
													id="id_nombreMascotaClienteReservaEditar"
													readonly="readonly">
											</div>
										</div>
										<div class="col-md-12">
											<div class="form-group">
												<label class="bmd-label-floating">Fecha</label> <input
													class="form-control" type="text" id="id_fechaReservaEditar"
													readonly="readonly">
											</div>
										</div>
										<div class="col-md-12">
											<div class="form-group">
												<label class="bmd-label-floating">Horario</label> <input
													class="form-control" type="text"
													id="id_horarioReservaEditar" readonly="readonly">
											</div>
										</div>
										<div class="col-md-12">
											<div class="form-group">
												<label class="bmd-label">Estado</label>
												<div class="caja">
													<select class="estilo-select" id="id_estadoReservaEditar"
														name="estado">
														<option value="pendiente de pago">pendiente de
															pago</option>
														<option value="pagado">pagado</option>
														<option value="realizado">realizado</option>
													</select>
												</div>
											</div>
										</div>
									</div>
									<button type="button" onclick="cerrarModalEditarReserva();"
										class="btn btn-primary pull-right">Cerrar</button>
									<button id="id_btnEditarBoleta" onclick="editarReserva();"
										type="button" class="btn btn-primary pull-right">Editar</button>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>

			<!-- Modal de Detalle de Pedido -->
			<div class="modal fade" id="idModalDetalleBoleta"
				data-backdrop="static" tabindex="-1" role="dialog">
				<div class="modal-dialog" style="width: 50%;">
					<!-- Modal content-->
					<div class="modal-content">
						<div class="card">
							<div class="card-header card-header-primary">
								<h3 class="card-title">Detalle Pedido</h3>
							</div>
							<div class="card-body" style="padding: 20px 18px;">
								<table id="tablaDetallePedido" class="table table-hover">
									<thead class="text-primary">
										<tr>
											<th style="width: 40px;">ID</th>
											<th>Producto</th>
											<th>Cantidad</th>
											<th>Costo</th>
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
								<button type="button" onclick="cerrarModalDetalleBoleta();"
									class="btn btn-primary pull-right">Cerrar</button>
							</div>
						</div>
					</div>
				</div>
			</div>

			<!-- Modal de Pago de Reserva -->
			<div class="modal fade" id="idModalMetodoPago" data-backdrop="static"
			
				tabindex="-1" role="dialog">
				<div class="modal-dialog" style="width: 50%;">
					<!-- Modal content-->
					<div class="modal-content">
						<div class="card">
							<div class="card-header card-header-primary">
								<h3 class="card-title">Realizar Pago</h3>
							</div>
							<input class="form-control" type="text" id="id_idReservaPagar"
								hidden="hidden">
							<div class="card-body" style="padding: 20px 18px;">
								<form accept-charset="UTF-8" id="id_formRealizarPago">

									<div class="dropdown-divider"></div>
									<div class="row">
										<div class="col-md-12" style="margin-top: 5px;">
											<div class="form-group">
												<label>Número de Tarjeta</label> <input
													class="form-control number" type="text" ng-model="ncard"
													maxlength="19" id="id_numTarjetaPagoServicio"
													placeholder="XXXX-XXXX-XXXX-XXXX"
													onkeypress='return event.charCode >= 48 && event.charCode <= 57' />
											</div>
										</div>
										<div class="col-md-12" style="margin-top: 5px;">
											<div class="form-group">
												<label>Fecha de Vencimiento</label> <input
													class="form-control expire"
													id="id_fechaVencimientoPagoServicio" type="text"
													placeholder="MM / YYYY" maxlength="9" />
											</div>
										</div>
										<div class="col-md-12" style="margin-top: 5px;">
											<div class="form-group">
												<label>Número de Seguridad</label> <input
													class="form-control ccv" type="text" placeholder="CVC"
													maxlength="3" id="id_numSeguridadPagoServicio"
													onkeypress='return event.charCode >= 48 && event.charCode <= 57' />
											</div>
										</div>
									</div>
									<div class="snipcart-details" style="margin-top: 12px">
										<button id="btn_aceptar" type="button" class="button w3l-cart"
											data-id="cart-8" onclick="pagarReserva();">ACEPTAR</button>
									</div>
								</form>
								<button type="button" onclick="cerrarModalMetodoPago();"
									class="btn btn-primary pull-right">Cerrar</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		
			<!-- Modal de Veterinario-->
			<div class="modal fade" id="idModalVeterinario"
				data-backdrop="static" tabindex="-1" role="dialog">
				<div class="modal-dialog" style="width: 55%;">
					<!-- Modal content-->
					<div class="modal-content">
						<div class="card">
							<div class="card-header card-header-primary">
								<h3 class="card-title">Veterinario</h3>
							</div>
							<div class="card-body" style="padding: 20px 18px;">
								<form accept-charset="UTF-8" id="id_formEditarReserva2">
									<div class="row">
										<input class="form-control" type="text"
											id="id_idReservaEditar2" hidden="hidden" name="idReserva">
										<div class="col-md-12">
											<div class="form-group">
												<label class="bmd-label-floating">Nombre Mascota</label> <input
													class="form-control" type="text"
													id="id_nombreMascotaClienteReservaEditar2"
													readonly="readonly">
											</div>
										</div>
										<div class="col-md-12">
											<div class="form-group">
												<label class="bmd-label-floating">Fecha</label> <input
													class="form-control" type="text" id="id_fechaReservaEditar2"
													readonly="readonly">
											</div>
										</div>
										<div class="col-md-12">
											<div class="form-group">
												<label class="bmd-label-floating">Horario</label> <input
													class="form-control" type="text"
													id="id_horarioReservaEditar2" readonly="readonly">
											</div>
										</div>
									<div class="col-md-12">
										<label class="bmd-label-floating">Observacion</label>
										<textarea id="editor3" name="descripcionLarga"></textarea>
										<small id="id_mensajeDescripcionLargaConsVeterinario"
											style="color: #cc0000;">El campo no puede estar vacio</small>
									</div>
										<div class="col-md-12">
											<div class="form-group">
												<label class="bmd-label">Estado</label>
												<div class="caja">
													<select class="estilo-select" id="id_estadoReservaEditar2"
														name="estado" disabled="disabled">
														<option value="pendiente de pago">pendiente de
															pago</option>
														<option value="pagado">pagado</option>
														<option value="realizado">realizado</option>
													</select>
												</div>
											</div>
										</div>
									</div>
									<button type="button" onclick="cerrarModalVeterinario();"
										class="btn btn-primary pull-right">Cerrar</button>
									<button id="id_btnRegistrarCita" onclick="registrarHistorialMascota();"
										type="button" class="btn btn-primary pull-right">Registrar</button>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		
		
		
		
		
		
		</div>
	</c:if>

	<!-- Restricción de Acceso -->
	<c:if test="${objCargo == null || objCargo == 'Veterinario'}">
		<div class="container-login100"
			style="background-image: url('images/error403.jpg');"></div>
	</c:if>


	<script type="text/javascript">
		function pagarReserva() {
			var validator = $('#id_formRealizarPago')
					.data('bootstrapValidator');
			validator.validate();
			if (validator.isValid()) {
				$.ajax({
					type : 'POST',
					data : {
						'idReserva' : $("#id_idReservaPagar").val()
					},
					url : 'pagarReserva',
					success : function(data) {
						if (data.CONFIRMACION == 'SI') {
							swal("¡Éxito!", data.MENSAJE, "success");
							setTimeout(function() {
								window.location = 'trackingCliente';
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
		function editarBoleta() {
			$.ajax({
				type : 'POST',
				data : {
					'idBoleta' : $("#id_idBoletaEditar").val(),
					'estado' : $("#id_estadoBoletaEditar").val()
				},
				url : 'editarBoleta',
				success : function(data) {
					if (data.CONFIRMACION == 'SI') {
						swal("¡Éxito!", data.MENSAJE, "success");
						setTimeout(function() {
							window.location = 'trackingCliente';
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
	</script>

	<script type="text/javascript">
		function editarReserva() {
			
			
			$.ajax({
				type : 'POST',
				data : {
					'idReserva' : $("#id_idReservaEditar").val(),
					'estado' : $("#id_estadoReservaEditar").val()
				},
				url : 'editarReserva',
				success : function(data) {
					if (data.CONFIRMACION == 'SI') {
						swal("¡Éxito!", data.MENSAJE, "success");
						setTimeout(function() {
							window.location = 'trackingCliente';
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
	</script>
	
	<script type="text/javascript">
		function registrarHistorialMascota() {
			$.ajax({
				type : 'POST',
				data : {
					'idReserva' : $("#id_idReservaEditar2").val(),
					'descripcionLarga' : CKEDITOR.instances['editor3'].getData()
					
					
				},
				url : 'registrarHistorialMascota',
				success : function(data) {
					if (data.CONFIRMACION == 'SI') {
						swal("¡Éxito!", data.MENSAJE, "success");
						setTimeout(function() {
							window.location = 'trackingCliente';
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
	</script>

	<script type="text/javascript">
		function verModalDetalleBoleta(id) {
			$("#tablaDetallePedido tbody tr").remove();
			$.getJSON('listadoDetalleBoleta', {
				"idBoleta" : id
			}, function(data) {
				$.each(data, function(index, item) {
					$('#tablaDetallePedido').append(
							"<tr>" + "<td>" + item.idDetalleBoleta + "</td>"
									+ "<td>" + item.idProducto.nombre + "</td>"
									+ "<td>" + item.cantidad + "</td>"
									+ "<td> S/. " + item.costo + "</td>"
									+ +"</tr>");
				});
			});
			$("#idModalDetalleBoleta").modal("show");
		}

		function cerrarModalDetalleBoleta() {
			$("#idModalDetalleBoleta").modal("hide");
		}

		function verModalMetodoPago(id) {
			$("#id_idReservaPagar").val(id);
			$("#idModalMetodoPago").modal("show");
		}

		function cerrarModalMetodoPago() {
			$("#idModalMetodoPago").modal("hide");
		}

		function verModalEditarBoleta(id, numero, nombre, dni, monto, estado) {
			$("#id_idBoletaEditar").val(id);
			$("#id_numeroBoletaEditar").val(numero);
			$("#id_nombreBoletaEditar").val(nombre);
			$("#id_dniBoletaEditar").val(dni);
			$("#id_montoBoletaEditar").val(monto);
			$("#id_estadoBoletaEditar").val(estado);
			$("#id_formEditarBoleta .col-md-12 .form-group").addClass(
					"is-filled");
			$("#idModalEditarBoleta").modal("show");
		}

		function cerrarModalEditarBoleta() {
			$("#idModalEditarBoleta").modal("hide");
		}

		function verModalEditarReserva(id, nomCliente, nomMascota, fecha,
				horario, estado) {
			$("#id_idReservaEditar").val(id);
			$("#id_nombreClienteReservaEditar").val(nomCliente);
			$("#id_nombreMascotaClienteReservaEditar").val(nomMascota);
			$("#id_fechaReservaEditar").val(fecha);
			$("#id_horarioReservaEditar").val(horario);
			$("#id_estadoReservaEditar").val(estado);
			$("#id_formEditarReserva .col-md-12 .form-group").addClass(
					"is-filled");
			$("#idModalEditarReserva").modal("show");
		}

		function cerrarModalEditarReserva() {
			$("#idModalEditarReserva").modal("hide");
		}

		$('#id_menuTrackingClientes').addClass('active');
		$('#id_menuCrudTracking').addClass('active');
		

		function verModalVeterinario(id, nomCliente, nomMascota, fecha,
				horario, estado) {
			$("#id_idReservaEditar2").val(id);
			$("#id_nombreClienteReservaEditar2").val(nomCliente);
			$("#id_nombreMascotaClienteReservaEditar2").val(nomMascota);
			$("#id_fechaReservaEditar2").val(fecha);
			$("#id_horarioReservaEditar2").val(horario);
		
			$("#id_estadoReservaEditar2").val(estado);
			$("#id_formEditarReserva2 .col-md-12 .form-group").addClass(
					"is-filled");
			$("#idModalVeterinario").modal("show");
		}

		function cerrarModalVeterinario() {
			$("#idModalVeterinario").modal("hide");
	
		}

	</script>
	
	<!-- Script de TextArea  -->
		<script type="text/javascript">
			$(document).ready(function() {
				
				modificarTextArea('editor3', 'ConsVeterinario');
			});
		</script>
	

	<!-- Validación de Modal Detalle Pedido -->
	<script type="text/javascript">
		$(document)
				.ready(
						function() {
							$('#id_formRealizarPago')
									.bootstrapValidator(
											{
												message : 'This value is not valid',
												feedbackIcons : {
													valid : 'glyphicon glyphicon-ok',
													invalid : 'glyphicon glyphicon-remove',
													validating : 'glyphicon glyphicon-refresh'
												},
												fields : {
													numTarjeta : {
														selector : "#id_numTarjetaPagoServicio",
														validators : {
															notEmpty : {
																message : 'Ingrese el número de tarjeta'
															},
															regexp : {
																regexp : /^[1-9][0-9]{3}[\s][0-9]{4}[\s][0-9]{4}[\s][0-9]{4}$/,
																message : 'Número de tarjeta no válida'
															},
															stringLength : {
																min : 19,
																message : 'Ingrese el número de tarjeta completo'
															}
														}
													},
													fechaVencimiento : {
														selector : "#id_fechaVencimientoPagoServicio",
														validators : {
															notEmpty : {
																message : 'Ingrese la Fec. Vencimiento'
															},
															regexp : {
																regexp : /^[0-1][0-9][\s][/][\s][0-9]{4}$/,
																message : 'Fecha de vencimiento no válida'
															},
															stringLength : {
																min : 9,
																message : 'Ingrese la Fec. Vencimiento completa'
															}
														}
													},
													numSeguridad : {
														selector : "#id_numSeguridadPagoServicio",
														validators : {
															notEmpty : {
																message : 'Ingrese el número de seguridad'
															},
															regexp : {
																regexp : /^[0-9]{3}$/,
																message : 'Número de seguridad no válida'
															},
															stringLength : {
																min : 3,
																message : 'Ingrese el número de seguridad completo'
															}
														}
													}
												}
											});
						});
	</script>
</body>
</html>