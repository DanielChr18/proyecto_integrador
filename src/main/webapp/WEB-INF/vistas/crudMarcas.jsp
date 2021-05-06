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
											<i class="material-icons">content_paste</i> Datos de Marca
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
																		onclick="verModalMarcaRegistra();"
																		class="btn btn-primary pull-left">Registrar
																		Marca</button>
																</div>
																<br />
																<div class="row" style="overflow: auto;">
																	<div class="col-md-12">
																		<table id="tablaMarcas" class="table table-hover">
																			<thead class="text-primary">
																				<tr>
																					<th style="width: 40px;">ID</th>
																					<th>Nombre</th>
																					<th style="width: 102.4px;">Editar</th>
																					<th style="width: 102.4px;">Eliminar</th>
																				</tr>
																			</thead>
																			<tbody>
																				<c:forEach items="${marcas}" var="marca">
																					<tr>
																						<td>${marca.idMarca}</td>
																						<td>${marca.nombre}</td>
																						<td>
																							<button type="button"
																								onclick="verModalMarcaModifica('${marca.idMarca}','${marca.nombre}');"
																								class="btn btn-primary">
																								<img src="images/edit.gif" width="auto"
																									height="auto" />
																							</button>
																						</td>
																						<td>
																							<button type="button"
																								onclick="verModalMarcaElimina('${marca.idMarca}');"
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

			<!-- Modal de Registro de Marca -->
			<div class="modal fade" id="idModalRegistraMarca"
				data-backdrop="static" tabindex="-1" role="dialog">
				<div class="modal-dialog" style="width: 45%;">
					<!-- Modal content-->
					<div class="modal-content">
						<div class="card">
							<div class="card-header card-header-primary">
								<h3 class="card-title">Registrar Marca</h3>
							</div>
							<div class="card-body" style="padding: 20px 18px;">
								<form accept-charset="UTF-8" id="id_formRegistrarMarca"
									action="registrarMarca" method="post"
									enctype="multipart/form-data">
									<div class="row">
										<div class="col-md-12">
											<div class="form-group">
												<label class="bmd-label-floating">Nombre de Marca</label> <input
													class="form-control" type="text" id="id_nombreRegistrar"
													name="nombre">
											</div>
										</div>
									</div>
									<button type="button" onclick="cerrarModalMarcaRegistra();"
										class="btn btn-primary pull-right">Cancelar</button>
									<button id="id_btnRegistrarMarca" type="submit"
										class="btn btn-primary pull-right">Registrar</button>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>

			<!-- Modal de Modificar Servicio -->
			<div class="modal fade" id="idModalModificaMarca"
				data-backdrop="static" tabindex="-1" role="dialog">
				<div class="modal-dialog" style="width: 45%;">
					<!-- Modal content-->
					<div class="modal-content">
						<div class="card">
							<div class="card-header card-header-primary">
								<h3 class="card-title">Modificar Marca</h3>
							</div>
							<div class="card-body" style="padding: 20px 18px;">
								<form accept-charset="UTF-8" id="id_formModificarMarca"
									action="modificarMarca" method="post"
									enctype="multipart/form-data">
									<div class="row" hidden="hidden">
										<div class="col-md-12">
											<div class="form-group">
												<input class="form-control" type="text"
													id="id_codigoModificar" name="idMarca">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-12">
											<div class="form-group" id="div_nombreModificar">
												<label class="bmd-label-floating">Nombre de Marca</label> <input
													class="form-control" type="text" id="id_nombreModificar"
													name="nombre">
											</div>
										</div>
									</div>
									<button type="button" onclick="cerrarModalMarcaModifica();"
										class="btn btn-primary pull-right">Cancelar</button>
									<button id="id_btnModificarMarca" type="submit"
										class="btn btn-primary pull-right">Actualizar</button>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>

			<!-- Modal de Eliminar Servicio -->
			<div class="modal fade" id="idModalEliminaMarca"
				data-backdrop="static" tabindex="-1" role="dialog">
				<div class="modal-dialog" style="width: 25%;">
					<!-- Modal content-->
					<div class="modal-content">
						<div class="card">
							<div class="card-header card-header-primary">
								<h3 class="card-title">Eliminar Marca</h3>
							</div>
							<div class="card-body" style="padding: 20px 18px;">
								<form id="id_formEliminarMarca" accept-charset="UTF-8"
									action="eliminarMarca" method="post">
									<div class="row" hidden="hidden">
										<div class="col-md-12">
											<div class="form-group">
												<input class="form-control" type="text"
													id="id_codigoEliminar" name="idMarca">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-12">
											<div class="form-group">
												<span class="pull-center">¿Desea eliminar la Marca
													seleccionada?</span>
											</div>
										</div>
									</div>
									<button type="button" onclick="cerrarModalMarcaElimina();"
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

	<script type="text/javascript">
		$("#id_formRegistrarMarca").on(
				'submit',
				function(evt) {
					$("#id_btnRegistrarMarca").attr("disabled", false);
					var validator = $('#id_formRegistrarMarca').data(
							'bootstrapValidator');
					if (validator.isValid()) {
						swal("¡Éxito!", "Marca registrada correctamente.",
								"success");
					}
				});

		$("#id_formModificarMarca").on(
				'submit',
				function(evt) {
					$("#id_btnModificarMarca").attr("disabled", false);
					var validator = $('#id_formModificarMarca').data(
							'bootstrapValidator');
					if (validator.isValid()) {
						swal("¡Éxito!", "Marca modificada correctamente.",
								"success");
					}
				});

		$("#id_formEliminarMarca").on('submit', function(evt) {
			swal("¡Éxito!", "Marca eliminada correctamente.", "success");
		});
	</script>

	<!-- Validación de Modal Registrar -->
	<script type="text/javascript">
		$(document)
				.ready(
						function() {
							$('#id_formRegistrarMarca')
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
														selector : "#id_nombreRegistrar",
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

	<!-- Validación de Modal Modificar -->
	<script type="text/javascript">
		$(document)
				.ready(
						function() {
							$('#id_formModificarMarca')
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

	<!-- Script's Modal -->
	<script type="text/javascript">
		$("#id_menuCrudMarcas").addClass("active");

		function verModalMarcaRegistra() {
			$("#idModalRegistraMarca").modal("show");
		}

		function cerrarModalMarcaRegistra() {
			$("#idModalRegistraMarca").modal("hide");
			$("#idModalRegistraMarca input").val("");
			$("#idModalRegistraMarca div.form-group").removeClass(
					"is-filled has-success");
			$('#id_formRegistrarMarca').data('bootstrapValidator').resetForm();
		}

		function verModalMarcaModifica(id, nombre) {
			$("#id_codigoModificar").val(id);
			$("#id_nombreModificar").val(nombre);
			$("#div_nombreModificar").addClass("is-filled");
			$("#idModalModificaMarca").modal("show");
		}

		function cerrarModalMarcaModifica() {
			$('#idModalModificaMarca').modal("hide");
			$("#idModalModificaMarca input").val("");
			$("#idModalModificaMarca div.form-group").removeClass(
					"is-filled has-success");
			$('#id_formModificarMarca').data('bootstrapValidator').resetForm();
		}

		function verModalMarcaElimina(id) {
			$("#id_codigoEliminar").val(id);
			$("#idModalEliminaMarca").modal("show");
		}

		function cerrarModalMarcaElimina() {
			$("#idModalEliminaMarca").modal("hide");
		}
	</script>
</body>
</html>




