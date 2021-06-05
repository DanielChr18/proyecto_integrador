<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html lang="esS">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

<title>Proyecto Integrador</title>

<script type="text/javascript" src="js/core/jquery.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/bootstrapValidator.js"></script>

<link rel="stylesheet" href="css/estilo1.1.css" />
<link rel="stylesheet" type="text/css" href="vendor/main.css" />
<link rel="stylesheet" href="css/bootstrapValidator.css" />

</head>
<body class="">
	<c:if test="${objCargo == 'Cliente'}">
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
																			class="material-icons">inventory_2</i> Productos
																			<div class="ripple-container"></div>
																	</a></li>
																	<li class="nav-item"><a class="nav-link"
																		href="#servicios" data-toggle="tab"> <i
																			class="material-icons">medical_services</i> Servicios
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
																				<th style="width: 102.4px;">Detalle</th>
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
																					<td>
																						<button type="button"
																							onclick="verModalDetalleBoleta('${p.idBoleta}');"
																							class="btn btn-primary">
																							<img src="images/edit.gif" width="auto"
																								height="auto" />
																						</button>
																					</td>
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
																				<th>Mascota</th>
																				<th>Fecha</th>
																				<th>Horario</th>
																				<th>Estado</th>
																				<th style="width: 102.4px;">pagar</th>
																			</tr>
																		</thead>
																		<tbody>
																			<c:forEach items="${servicios}" var="s">
																				<tr>
																					<td>${s.idReserva}</td>
																					<td>${s.idMascota.nombre}</td>
																					<td>${s.fecha}</td>
																					<td>${s.horario}</td>
																					<td>${s.estado}</td>
																					<td>
																						<button type="button"
																							onclick="verModalMetodoPago('${s.idReserva}');"
																							class="btn btn-primary">
																							<img src="images/edit.gif" width="auto"
																								height="auto" />
																						</button>
																					</td>
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

			<!-- Modal de Detalle de Pedido -->
			<div class="modal fade" id="idModalMetodoPago"
				data-backdrop="static" tabindex="-1" role="dialog">
				<div class="modal-dialog" style="width: 50%;">
					<!-- Modal content-->
					<div class="modal-content">
						<div class="card">
						<div class="card-header card-header-primary">
							<h3 class="card-title">Realizar Pago</h3>
						</div>
							<div class="card-body" style="padding: 20px 18px;">
								<form action="RealizarPago">
						
										<div class="dropdown-divider"></div>
										<div class="row">
											<div class="col-md-12" style="margin-top: 5px;">
												<div class="form-group">
													<label>Número de Tarjeta</label> <input
														class="form-control number" type="text" ng-model="ncard"
														maxlength="19" id="id_numTarjeta" placeholder="XXXX-XXXX-XXXX-XXXX"
														onkeypress='return event.charCode >= 48 && event.charCode <= 57' />
												</div>
											</div>
											<div class="col-md-12" style="margin-top: 5px;">
												<div class="form-group">
													<label>Fecha de Vencimiento</label> <input
														class="form-control expire" id="id_fechaVencimiento"
														type="text" placeholder="MM / YYYY" maxlength="9" />
												</div>
											</div>
											<div class="col-md-12" style="margin-top: 5px;">
												<div class="form-group">
													<label>Número de Seguridad</label> <input
														class="form-control ccv" type="text" placeholder="CVC"
														maxlength="3" id="id_numSeguridad"
														onkeypress='return event.charCode >= 48 && event.charCode <= 57' />
												</div>
											</div>
										</div>
										<div class="snipcart-details" style="margin-top: 12px">
											<button id="btn_aceptar" type="submit"
												class="button w3l-cart" data-id="cart-8">ACEPTAR</button>
										</div>
									
									</form>
								<button type="button" onclick="cerrarModalMetodoPago();"
									class="btn btn-primary pull-right">Cerrar</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</c:if>

	<!-- Restricción de Acceso -->
	<c:if test="${objCargo != 'Cliente'}">
		<div class="container-login100"
			style="background-image: url('images/error403.jpg');"></div>
	</c:if>

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
			$("#idModalMetodoPago").modal("show");
		}

		function cerrarModalMetodoPago() {
			$("#idModalMetodoPago").modal("hide");
		}
		

		$('#id_menuTrackingClientes').addClass('active');
	</script>
	
	<script type="text/javascript">
	$(function() {
		var month = 0;
		var html = document.getElementsByTagName('html')[0];
		var number = "";
		var selected_card = -1;

		$(document).click(
				function(e) {
					if (!$(e.target).is(".ccv")
							|| !$(e.target).closest(".ccv").length) {
						$(".seccode").css("color", "var(--text-color)");
					}
					if (!$(e.target).is(".expire")
							|| !$(e.target).closest(".expire").length) {
						$(".date_value").css("color", "var(--text-color)");
					}
					if (!$(e.target).is(".number")
							|| !$(e.target).closest(".number").length) {
						$(".card_number").css("color", "var(--text-color)");
					}
				});

		//Card number input
		$(".number")
				.keyup(
						function(event) {
							$(".card_number").text($(this).val());
							number = $(this).val();
							if ($(".card_number").text().length === 0) {
								$(".card_number")
										.html(
												"&#x25CF;&#x25CF;&#x25CF;&#x25CF; &#x25CF;&#x25CF;&#x25CF;&#x25CF; &#x25CF;&#x25CF;&#x25CF;&#x25CF; &#x25CF;&#x25CF;&#x25CF;&#x25CF;");
							}
						}).focus(function() {
					$(".card_number").css("color", "white");
				}).on(
						"keydown input",
						function() {
							$(".card_number").text($(this).val());
							if (event.key >= 0 && event.key <= 9) {
								if ($(this).val().length === 4
										|| $(this).val().length === 9
										|| $(this).val().length === 14) {
									$(this).val($(this).val() + " ");
								}
							}
						});

		//Security code Input
		$(".ccv").focus(function() {
			$(".seccode").css("color", "white");
		}).keyup(function() {
			$(".seccode").text($(this).val());
			if ($(this).val().length === 0) {
				$(".seccode").html("&#x25CF;&#x25CF;&#x25CF;");
			}
		}).focusout(function() {
			$(".seccode").css("color", "var(--text-color)");
		});

		//Date expire input
		$(".expire").keypress(
				function(event) {
					if (event.charCode >= 48 && event.charCode <= 57) {
						if ($(this).val().length === 1) {
							$(this).val($(this).val() + event.key + " / ");
						} else if ($(this).val().length === 0) {
							if (event.key == 1 || event.key == 0) {
								month = event.key;
								return event.charCode;
							} else {
								$(this).val(0 + event.key + " / ");
							}
						} else if ($(this).val().length > 2
								&& $(this).val().length < 9) {
							return event.charCode;
						}
					}
					return false;
				}).keyup(function(event) {
			$(".date_value").html($(this).val());
			if (event.keyCode == 8 && $(".expire").val().length == 4) {
				$(this).val(month);
			}
			if ($(this).val().length === 0) {
				$(".date_value").text("MM / YYYY");
			}
		}).keydown(function() {
			$(".date_value").html($(this).val());
		}).focus(function() {
			$(".date_value").css("color", "white");
		});
	});
</script>

<!-- Validación de Modal Detalle Pedido -->
<script type="text/javascript">
	$(document).ready(function() {
		$('#form_boletaCompra').bootstrapValidator({
			message : 'This value is not valid',
			feedbackIcons : {
				valid : 'glyphicon glyphicon-ok',
				invalid : 'glyphicon glyphicon-remove',
				validating : 'glyphicon glyphicon-refresh'
			},
			fields : {
				numTarjeta : {
					selector : "#id_numTarjeta",
					validators : {
						notEmpty : {
							message : 'Ingrese el número de tarjeta'
						},
						stringLength : {
							min : 19,
							message : 'Ingrese el número de tarjeta completo'
						}
					}
				},
				fechaVencimiento : {
					selector : "#id_fechaVencimiento",
					validators : {
						notEmpty : {
							message : 'Ingrese la Fec. Vencimiento'
						},
						stringLength : {
							min : 9,
							message : 'Ingrese la Fec. Vencimiento completa'
						}
					}
				},
				numSeguridad : {
					selector : "#id_numSeguridad",
					validators : {
						notEmpty : {
							message : 'Ingrese el número de seguridad'
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