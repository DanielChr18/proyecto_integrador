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

<link rel="stylesheet" type="text/css" href="vendor/main.css" />
<link rel="stylesheet" href="css/bootstrapValidator.css" />
</head>

<body class="">
	<c:if test="${objCargo == 'Personal de Ventas'}">
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
											<i class="material-icons">content_paste</i> Datos de
											Proveedor
										</h3>
										<p class="card-category">Mantenimiento</p>
									</div>
									<div class="card-body">
										<div class="row">
											<div class="col-md-12">
												<div class="row">
													<div class="col-md-12">
														<form accept-charset="UTF-8">
															<div class="card-body" style="padding: 20px 10px;">
																<div class="row">
																	<button type="button"
																		onclick="verModalProveedorRegistra();"
																		class="btn btn-primary pull-left">Registrar
																		Proveedor</button>
																</div>
																<br />
																<div class="row" style="overflow: auto;">
																	<table id="tablaProveedores" class="table table-hover">
																		<thead class="text-primary">
																			<tr>
																				<th style="width: 40px;">ID</th>
																				<th>Razon Social</th>
																				<th>RUC</th>
																				<th>Direccion</th>
																				<th>Telefono</th>
																				<th>Celular</th>
																				<th>Contacto</th>

																				<th style="width: 102.4px;">Editar</th>
																				<th style="width: 102.4px;">Eliminar</th>
																			</tr>
																		</thead>
																		<tbody>
																			<c:forEach items="${proveedores}" var="proveedor">
																				<tr>
																					<td>${proveedor.idProveedor}</td>
																					<td>${proveedor.razonSocial}</td>
																					<td>${proveedor.ruc}</td>
																					<td>${proveedor.direccion}</td>
																					<td>${proveedor.telefono}</td>
																					<td>${proveedor.celular}</td>
																					<td>${proveedor.contacto}</td>
																					<td>
																						<button type="button"
																							onclick="verModalProveedorModifica('${proveedor.idProveedor}','${proveedor.razonSocial}','${proveedor.ruc}','${proveedor.direccion}','${proveedor.telefono}','${proveedor.celular}','${proveedor.contacto}');"
																							class="btn btn-primary">
																							<img src="images/edit.gif" width="auto"
																								height="auto" />
																						</button>
																					</td>
																					<td>
																						<button type="button"
																							onclick="verModalProveedorElimina('${proveedor.idProveedor}');"
																							class="btn btn-primary">
																							<img src="images/delete.gif" width="auto"
																								height="auto" />
																						</button>
																					</td>
																				</tr>
																			</c:forEach>
																		</tbody>
																	</table>
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
						</div>
					</div>
				</div>
			</div>

			<!-- Modal de Registro de Proveedor -->
			<div class="modal fade" id="idModalRegistraProveedor"
				data-backdrop="static" tabindex="-1" role="dialog">
				<div class="modal-dialog" style="width: 45%;">
					<!-- Modal content-->
					<div class="modal-content">
						<div class="card">
							<div class="card-header card-header-primary">
								<h3 class="card-title">Registrar Proveedor</h3>
							</div>
							<div class="card-body" style="padding: 20px 18px;">
								<form accept-charset="UTF-8" id="id_formRegistrarProveedor"
									action="registrarProveedor" method="post"
									enctype="multipart/form-data">
									<div class="row">
										<div class="col-md-12">
											<div class="form-group">
												<label class="bmd-label-floating">Razon Social</label> <input
													class="form-control" type="text"
													id="id_razonSocialRegistrar" name="razonSocial">
											</div>
										</div>
										<div class="col-md-12">
											<div class="form-group">
												<label class="bmd-label-floating">RUC</label> <input
													class="form-control" type="text" id="id_rucRegistrar"
													name="ruc">
											</div>
										</div>
										<div class="col-md-12">
											<div class="form-group">
												<label class="bmd-label-floating">Direccion</label> <input
													class="form-control" type="text" id="id_direccionRegistrar"
													name="direccion">
											</div>
										</div>
										<div class="col-md-12">
											<div class="form-group">
												<label class="bmd-label-floating">Telefono</label> <input
													class="form-control" type="text" id="id_telefonoRegistrar"
													name="telefono">
											</div>
										</div>
										<div class="col-md-12">
											<div class="form-group">
												<label class="bmd-label-floating">Celular</label> <input
													class="form-control" type="text" id="id_celularRegistrar"
													name="Celular">
											</div>
										</div>
										<div class="col-md-12">
											<div class="form-group">
												<label class="bmd-label-floating">Contacto</label> <input
													class="form-control" type="text" id="id_contactoRegistrar"
													name="Contacto">
											</div>
										</div>
									</div>
									<button type="button" onclick="cerrarModalProveedorRegistra();"
										class="btn btn-primary pull-right">Cancelar</button>
									<button id="id_btnRegistrarServicio" type="submit"
										class="btn btn-primary pull-right">Registrar</button>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>

			<!-- Modal de Modificar Servicio -->
			<div class="modal fade" id="idModalModificaProveedor"
				data-backdrop="static" tabindex="-1" role="dialog">
				<div class="modal-dialog" style="width: 45%;">
					<!-- Modal content-->
					<div class="modal-content">
						<div class="card">
							<div class="card-header card-header-primary">
								<h3 class="card-title">Modificar Proveedor</h3>
							</div>
							<div class="card-body" style="padding: 20px 18px;">
								<form accept-charset="UTF-8" id="id_formModificarProveedor"
									action="modificarProveedor" method="post"
									enctype="multipart/form-data">
									<div class="row" hidden="hidden">
										<div class="col-md-12">
											<div class="form-group">
												<input class="form-control" type="text"
													id="id_codigoModificar" name="idProveedor">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-12">
											<div class="form-group" id="div_razonSocialModificar">
												<label class="bmd-label-floating">Razon Social</label> <input
													class="form-control" type="text"
													id="id_razonSocialModificar" name="razonSocial">
											</div>
										</div>
										<div class="col-md-12">
											<div class="form-group" id="div_rucModificar">
												<label class="bmd-label-floating">RUC</label> <input
													class="form-control" type="text" id="id_rucModificar"
													name="ruc">
											</div>
										</div>
										<div class="col-md-12">
											<div class="form-group" id="div_direccionModificar">
												<label class="bmd-label-floating">Direccion</label> <input
													class="form-control" type="text" id="id_direccionModificar"
													name="direccion">
											</div>
										</div>
										<div class="col-md-12">
											<div class="form-group" id="div_telefonoModificar">
												<label class="bmd-label-floating">Telefono</label> <input
													class="form-control" type="text" id="id_telefonoModificar"
													name="telefono">
											</div>
										</div>
										<div class="col-md-12">
											<div class="form-group" id="div_celularModificar">
												<label class="bmd-label-floating">Celular</label> <input
													class="form-control" type="text" id="id_celularModificar"
													name="celular">
											</div>
										</div>
										<div class="col-md-12">
											<div class="form-group" id="div_contactoModificar">
												<label class="bmd-label-floating">Contacto</label> <input
													class="form-control" type="text" id="id_contactoModificar"
													name="contacto">
											</div>
										</div>
									</div>
									<button type="button" onclick="cerrarModalProveedorModifica();"
										class="btn btn-primary pull-right">Cancelar</button>
									<button id="id_btnModificarServicio" type="submit"
										class="btn btn-primary pull-right">Actualizar</button>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>

			<!-- Modal de Eliminar Servicio -->
			<div class="modal fade" id="idModalEliminaProveedor"
				data-backdrop="static" tabindex="-1" role="dialog">
				<div class="modal-dialog" style="width: 25%;">
					<!-- Modal content-->
					<div class="modal-content">
						<div class="card">
							<div class="card-header card-header-primary">
								<h3 class="card-title">Eliminar Proveedor</h3>
							</div>
							<div class="card-body" style="padding: 20px 18px;">
								<form id="id_formEliminarProveedor" accept-charset="UTF-8"
									action="eliminarProveedor" method="post">
									<div class="row" hidden="hidden">
										<div class="col-md-12">
											<div class="form-group">
												<input class="form-control" type="text"
													id="id_codigoEliminar" name="idProveedor">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-12">
											<div class="form-group">
												<span class="pull-center">¿Desea eliminar el
													Proveedor seleccionado?</span>
											</div>
										</div>
									</div>
									<button type="button" onclick="cerrarModalProveedorElimina();"
										class="btn btn-primary pull-right">NO</button>
									<button type="submit" class="btn btn-primary pull-left">SI</button>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</c:if>

	<!-- Restricción de Acceso -->
	<c:if test="${objCargo != 'Personal de Ventas'}">
		<div class="container-login100"
			style="background-image: url('images/error403.jpg');"></div>
	</c:if>

	<!-- Script's Modal -->
	<script type="text/javascript">
		$("#id_menuCrudProveedores").addClass("active");

		function verModalProveedorRegistra() {
			$("#idModalRegistraProveedor").modal("show");
		}

		function cerrarModalProveedorRegistra() {
			$("#idModalRegistraProveedor").modal("hide");
			$("#idModalRegistraProveedor input").val("");
			$("#idModalRegistraProveedor div.form-group").removeClass(
					"is-filled has-success");
			$('#id_formRegistrarProveedor').data('bootstrapValidator')
					.resetForm();
		}

		function verModalProveedorModifica(id, razonSocial, ruc, direccion,
				telefono, celular, contacto) {
			$("#id_codigoModificar").val(id);
			$("#id_razonSocialModificar").val(razonSocial);
			$("#id_rucModificar").val(ruc);
			$("#id_direccionModificar").val(direccion);
			$("#id_telefonoModificar").val(telefono);
			$("#id_celularModificar").val(celular);
			$("#id_contactoModificar").val(contacto);
			$("#id_codigoModificar").addClass("is-filled");
			$("#id_razonSocialModificar").addClass("is-filled");
			$("#id_rucModificar").addClass("is-filled");
			$("#id_direccionModificar").addClass("is-filled");
			$("#id_telefonoModificar").addClass("is-filled");
			$("#id_celularModificar").addClass("is-filled");
			$("#id_contactoModificar").addClass("is-filled");
			$("#idModalModificaProveedor").modal("show");
		}

		function cerrarModalProveedorModifica() {
			$('#idModalModificaProveedor').modal("hide");
			$("#idModalModificaProveedor input").val("");
			$("#idModalModificaProveedor div.form-group").removeClass(
					"is-filled has-success");
			$('#id_formModificarProveedor').data('bootstrapValidator')
					.resetForm();
		}

		function verModalProveedorElimina(id) {
			$("#id_codigoEliminar").val(id);
			$("#idModalEliminaProveedor").modal("show");
		}

		function cerrarModalProveedorElimina() {
			$("#idModalEliminaProveedor").modal("hide");
		}
	</script>


	<script type="text/javascript">
		$("#id_formRegistrarProveedor").on(
				'submit',
				function(evt) {
					$("#id_btnRegistrarProveedor").attr("disabled", false);
					var validator = $('#id_formRegistrarProveedor').data(
							'bootstrapValidator');
					if (validator.isValid()) {
						swal("¡Éxito!", "Proveedor registrado correctamente.",
								"success");
					}
				});

		$("#id_formModificarProveedor").on(
				'submit',
				function(evt) {
					$("#id_btnModificarProveedor").attr("disabled", false);
					var validator = $('#id_formModificarProveedor').data(
							'bootstrapValidator');
					if (validator.isValid()) {
						swal("¡Éxito!", "Proveedor modificado correctamente.",
								"success");
					}
				});

		$("#id_formEliminarProveedor").on('submit', function(evt) {
			swal("¡Éxito!", "Proveedor eliminado correctamente.", "success");
		});
	</script>



	<!-- Validación de Modal Registrar -->
	<script type="text/javascript">
		$(document)
				.ready(
						function() {
							$('#id_formRegistrarProveedor')
									.bootstrapValidator(
											{
												message : 'This value is not valid',
												feedbackIcons : {
													valid : 'glyphicon glyphicon-ok',
													invalid : 'glyphicon glyphicon-remove',
													validating : 'glyphicon glyphicon-refresh'
												},
												fields : {
													razonSocial : {
														selector : "#id_razonSocialRegistrar",
														validators : {
															notEmpty : {
																message : 'El campo es obligatorio'
															},
															stringLength : {
																min : 3,
																message : 'El campo debe ser más de 3 caracteres'
															}
														}
													},
													ruc : {
														selector : "#id_rucRegistrar",
														validators : {
															notEmpty : {
																message : 'El ruc es obligatorio'
															},
															regexp : {
																regexp : /^[0-9]{11}$/,
																message : 'El ruc es de 11 dígitos'
															}
														}
													},
													direccion : {
														selector : "#id_direccionRegistrar",
														validators : {
															notEmpty : {
																message : 'El direccion es obligatorio'
															},
														}
													},
													telefono : {
														selector : "#id_telefonoRegistrar",
														validators : {
															notEmpty : {
																message : 'El telefono es obligatorio'
															},
															regexp : {
																regexp : /^[0-9]{7}$/,
																message : 'El telefono es 7 dígitos'
															}
														}
													},
													celular : {
														selector : "#id_celularRegistrar",
														validators : {
															notEmpty : {
																message : 'El celular es obligatorio'
															},
															regexp : {
																regexp : /^[0-9]{9}$/,
																message : 'El celular es 9 dígitos'
															}
														}
													},
													contacto : {
														selector : "#id_contactoRegistrar",
														validators : {
															notEmpty : {
																message : 'El contacto es obligatorio'
															},
															stringLength : {
																min : 3,
																message : 'El contacto debe ser más de 3 caracteres'
															}
														}
													}
												}

											});
						});
	</script>

	<!-- Validación de Modal Modificar -->
	<script type="text/javascript">
		$(document)
				.ready(
						function() {
							$('#id_formModificarProveedor')
									.bootstrapValidator(
											{
												message : 'This value is not valid',
												feedbackIcons : {
													valid : 'glyphicon glyphicon-ok',
													invalid : 'glyphicon glyphicon-remove',
													validating : 'glyphicon glyphicon-refresh'
												},
												fields : {
													nombre : {
														selector : "#id_nombreModificar",
														validators : {
															notEmpty : {
																message : 'El nombre es obligatorio'
															},
															stringLength : {
																min : 3,
																message : 'El nombre debe ser más de 3 caracteres'
															}
														}
													}

												}
											});
						});
	</script>
</body>
</html>




