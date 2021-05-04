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
	<c:if test="${objCargo == 'Cliente'}">
		<div class="wrapper ">
			<jsp:include page="menuLateral.jsp" />
			<div class="main-panel">
				<jsp:include page="menuSuperior.jsp" />
				<div class="content">
					<div class="container-fluid">
						<div class="row">
							<div class="col-md-8">
								<div class="card">
									<div class="card-header card-header-primary">
										<h3 class="card-title">
											<i class="material-icons">pets</i> Datos Mascotas
										</h3>
									</div>
									<div class="card-body">
										<form accept-charset="UTF-8">
											<div class="row">
												<div class="col-md-12">
													<div class="card-header"
														style="border-bottom: #9c27b0 1px solid;">
														<h4 class="card-title" style="color: #9c27b0">
															<strong>Datos de Mascota</strong>
														</h4>
													</div>
													<div class="card-body" style="padding: 20px 10px;">
														<div class="row">
															<button type="button"
																onclick="verModalMascotaRegistra();"
																class="btn btn-primary pull-left">Registrar
																Mascota</button>
														</div>
														<br />
														<div class="row" style="overflow: auto;">
															<table id="tablaMascotas" class="table table-hover">
																<thead class="text-primary">
																	<tr>
																		<th>ID</th>
																		<th>Nombre</th>
																		<th>Tipo</th>
																		<th>Raza</th>
																		<th>Fecha Nac.</th>
																		<th>Sexo</th>
																		<th style="width: 8%">Editar</th>
																		<th style="width: 8%">Eliminar</th>
																	</tr>
																</thead>
																<tbody>
																	<c:forEach var="mascota" items="${mascotas}">
																		<tr>
																			<td>${mascota.idMascota}</td>
																			<td>${mascota.nombre}</td>
																			<td>${mascota.tipo}</td>
																			<td>${mascota.raza}</td>
																			<td>${mascota.fechaNacimiento}</td>
																			<td>${mascota.sexo}</td>
																			<td>
																				<button type='button'
																					onclick="verModalMascotaModifica('${mascota.idMascota}','${mascota.nombre}','${mascota.tipo}','${mascota.raza}','${mascota.fechaNacimiento}','${mascota.sexo}');"
																					class='btn btn-primary'>
																					<img src='images/edit.gif' width='auto'
																						height='auto' />
																				</button>
																			</td>
																			<td>
																				<button type='button'
																					onclick="verModalMascotaElimina('${mascota.idMascota}');"
																					class='btn btn-primary'>
																					<img src='images/delete.gif' width='auto'
																						height='auto' />
																				</button>
																			</td>
																		</tr>
																	</c:forEach>
																</tbody>
															</table>
														</div>
													</div>
												</div>
											</div>
										</form>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="card card-profile">
									<div class="card-avatar">
										<a href="javascript:;"> <img class="img"
											src="images/marc.jpg" />
										</a>
									</div>
									<div class="card-body">
										<h6 class="card-category text-gray">${clientes.idUsuario.cargo}</h6>
										<h4 class="card-title">${clientes.apellido},
											${clientes.nombre}</h4>
										<p class="card-description">${clientes.direccion}</p>
										<a href="javascript:;" class="btn btn-primary btn-round">Follow</a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<!-- Modal Mascota Registrar -->

			<div class="modal fade" id="idModalRegistraMascota"
				data-backdrop="static" tabindex="-1" role="dialog">
				<div class="modal-dialog" style="width: 40%; margin: 60px auto 0;">
					<!-- Modal content-->
					<div class="modal-content">
						<div class="card">
							<div class="card-header card-header-primary">
								<h3 class="card-title">Registrar Mascota</h3>
							</div>
							<div class="card-body" style="padding: 20px 18px;">
								<form id="id_formRegistrarMascota" accept-charset="UTF-8"
									action="registrarMascota" method="post"
									enctype="multipart/form-data">
									<div class="row" id="id_divNombreRegistrar">
										<div class="col-md-12">
											<div class="form-group">
												<label class="bmd-label-floating">Nombre</label> <input
													type="text" class="form-control"
													id="id_nombreMascotaRegistrar" name="nombre">
											</div>
										</div>
									</div>
									<div class="row" id="id_divTipoRegistrar">
										<div class="col-md-12">
											<div class="form-group">
												<label class="bmd-label">Tipo</label> <select
													id="id_tipoMascotaRegistrar" class="form-control"
													name="tipo">
													<option value="">[ Seleccionar ]</option>
													<option value="Perro">Perro</option>
													<option value="Gato">Gato</option>
												</select>
											</div>
										</div>
									</div>
									<div class="row" id="id_divRazaRegistrar">
										<div class="col-md-12">
											<div class="form-group">
												<label class="bmd-label-floating">Raza</label> <input
													type="text" id="id_razaMascotaRegistrar"
													class="form-control" name="raza">
											</div>
										</div>
									</div>
									<div class="row" id="id_divFechaNacRegistrar">
										<div class="col-md-12">
											<div class="form-group">
												<label class="bmd-label">Fecha de Nacimiento</label><br>
												<input type="date" id="id_fechaNacMascotaRegistrar"
													class="form-control" name="fechaNacimiento">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-12">
											<div class="form-group">
												<input type="radio" name="sexo" value="Macho" checked>
												Macho <input type="radio" name="sexo" value="Hembra">
												Hembra
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-12">
											<div class="form-group">
												<label class="bmd-label">Imagen</label>
											</div>
											<div class="invoiceBox">
												<label for="id_imagenRegistrar" id="boxFileRegistrar"
													class="boxFile" data-text="Seleccionar Imagen">
													Seleccionar Imagen </label> <input id="id_imagenRegistrar"
													name="imagenMascotaRegistrar" size="6000" type="file"
													accept="image/x-png,image/jpeg,image/jpg,image/tiff">
											</div>
											<small id="id_mensajeImagenRegistrar" style="color: #cc0000;">Seleccionar
												Imagen</small>
										</div>
									</div>
									<button type="button" onclick="cerrarModalMascotaRegistra();"
										class="btn btn-primary pull-right">Cancelar</button>
									<button id="id_btnRegistrarMascota" type="submit"
										class="btn btn-primary pull-right">Registrar</button>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>

			<!-- Modal Mascota Modificar -->
			<div class="modal fade" id="idModalModificaMascota"
				data-backdrop="static" tabindex="-1" role="dialog">
				<div class="modal-dialog" style="width: 40%; margin: 60px auto 0;">
					<!-- Modal content-->
					<div class="modal-content">
						<div class="card">
							<div class="card-header card-header-primary">
								<h3 class="card-title">Modificar Mascota</h3>
							</div>
							<div class="card-body" style="padding: 20px 18px;">
								<form id="id_formModificarMascota" accept-charset="UTF-8"
									action="modificarMascota" method="post"
									enctype="multipart/form-data">
									<div class="row" hidden="hidden">
										<div class="col-md-12">
											<div class="form-group">
												<input class="form-control" type="text"
													id="id_codigoMascotaModificar" name="idMascota">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-12">
											<div class="form-group" id="div_nombreMascotaModificar">
												<label class="bmd-label-floating">Nombre</label> <input
													type="text" id="id_nombreMascotaModificar"
													class="form-control" name="nombre">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-12">
											<div class="form-group">
												<label class="bmd-label">Tipo</label> <select
													id="id_tipoMascotaModificar" class="form-control"
													name="tipo">
													<option value="">[ Seleccionar ]</option>
													<option value="Perro">Perro</option>
													<option value="Gato">Gato</option>
												</select>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-12">
											<div class="form-group" id="div_razaMascotaModificar">
												<label class="bmd-label-floating">Raza</label> <input
													type="text" id="id_razaMascotaModificar"
													class="form-control" name="raza">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-12">
											<div class="form-group" id="div_fechaNacMascotaModificar">
												<label class="bmd-label">Fecha de Nacimiento</label><br>
												<input type="date" id="id_fechaNacMascotaModificar"
													class="form-control" name="fechaNacimiento">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-12">
											<div class="form-group" id="div_sexoMascotaModificar">
												<input type="radio" name="sexo" value="Macho" checked>
												Macho <input type="radio" name="sexo" value="Hembra">
												Hembra
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-12">
											<div class="form-group">
												<label class="bmd-label">Imagen</label>
											</div>
											<div class="invoiceBox">
												<label for="id_imagenModificar" id="boxFileModificar"
													class="boxFile" data-text="Seleccionar Imagen">
													Seleccionar Imagen </label> <input id="id_imagenModificar"
													name="imagenMascotaModificar" size="6000" type="file"
													accept="image/x-png,image/jpeg,image/jpg,image/tiff">
											</div>
										</div>
									</div>
									<button type="button" onclick="cerrarModalMascotaModifica();"
										class="btn btn-primary pull-right">Cancelar</button>
									<button id="id_btnModificarMascota" type="submit"
										class="btn btn-primary pull-right">Modificar</button>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>

			<!-- Modal Mascota Eliminar -->
			<div class="modal fade" id="idModalEliminaMascota"
				data-backdrop="static" tabindex="-1" role="dialog">
				<div class="modal-dialog" style="width: 25%; margin: 20% auto 0;">
					<!-- Modal content-->
					<div class="modal-content">
						<div class="card">
							<div class="card-header card-header-primary">
								<h3 class="card-title">Eliminar Mascota</h3>
							</div>
							<div class="card-body" style="padding: 20px 18px;">
								<form accept-charset="UTF-8" action="eliminarMascota"
									method="post">
									<div class="row" hidden="hidden">
										<div class="col-md-12">
											<div class="form-group">
												<input class="form-control" type="text"
													id="id_codigoMascotaEliminar" name="idMascota">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-12">
											<div class="form-group">
												<span class="pull-center">¿Desea eliminar la mascota
													seleccionada?</span>
											</div>
										</div>
									</div>
									<button type="button" onclick="cerrarModalMascotaElimina();"
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
	<c:if test="${objCargo != 'Cliente'}">
		<div class="container-login100"
			style="background-image: url('images/error403.jpg');"></div>
	</c:if>

	<!-- Restricción de Acceso -->
	<script type="text/javascript">
		$("#id_menuClientes").addClass("active");
		$('#id_mensajeImagenRegistrar').hide();
		imagen('#id_imagenRegistrar', '#boxFileRegistrar',
				'#id_mensajeImagenRegistrar');
		imagen('#id_imagenModificar', '#boxFileModificar', null);

		function verModalMascotaRegistra() {
			$('#boxFileRegistrar').text("Seleccionar Imagen");
			$('#boxFileRegistrar').removeClass("attached");
			$('#idModalRegistraMascota').modal("show");
		}

		function cerrarModalMascotaRegistra() {
			$('#idModalRegistraMascota').modal("hide");
			$("#idModalRegistraMascota input[type='text']").val("");
			$("#idModalRegistraMascota input[type='file']").val("");
			$("#idModalRegistraMascota div.form-group").removeClass(
					"is-filled has-success");
			$('#id_formRegistrarMascota').data('bootstrapValidator')
					.resetForm();
			$('#id_mensajeImagenRegistrar').hide();
		}

		function verModalMascotaModifica(id, nombre, tipo, raza, fecha, sexo) {
			$("#id_codigoMascotaModificar").val(id);
			$("#id_nombreMascotaModificar").val(nombre);
			$("#div_nombreMascotaModificar").addClass("is-filled");
			$("#id_tipoMascotaModificar").val(tipo);
			$("#id_razaMascotaModificar").val(raza);
			$("#idModalModificaMascota input[name=sexo][value='" + sexo + "']")
					.prop("checked", true);
			$("#div_razaMascotaModificar").addClass("is-filled");
			$("#id_fechaNacMascotaModificar").val(fecha);
			$("#div_fechaNacMascotaModificar").addClass("is-filled");
			$("#idModalModificaMascota").modal("show");
		}

		function cerrarModalMascotaModifica() {
			$('#idModalModificaMascota').modal("hide");
			$("#idModalModificaMascota input[type='text']").val("");
			$("#idModalModificaMascota input[type='file']").val("");
			$("#idModalModificaMascota div.form-group").removeClass(
					"is-filled has-success");
			$('#boxFileModificar').text("Seleccionar Imagen");
			$('#boxFileModificar').removeClass("attached");
			$("#idModalModificaMascota input[name=sexo]")
					.attr("checked", false);
			$('#id_formModificarMascota').data('bootstrapValidator')
					.resetForm();
		}

		function verModalMascotaElimina(id) {
			$("#id_codigoMascotaEliminar").val(id);
			$('#idModalEliminaMascota').modal("show");
		}

		function cerrarModalMascotaElimina() {
			$('#idModalEliminaMascota').modal("hide");
		}
	</script>

	<script type="text/javascript">
		$("#id_formRegistrarMascota").on(
				'submit',
				function(evt) {
					$("#id_btnRegistrarMascota").attr("disabled", false);
					if ($("#id_imagenRegistrar").val() == "") {
						$('#id_mensajeImagenRegistrar').show();
						evt.preventDefault();
					} else {
						var validator = $('#id_formRegistrarMascota').data(
								'bootstrapValidator');
						if (validator.isValid()) {
							swal("¡Éxito!",
									"Mascota registrada correctamente.",
									"success");
						}
					}
				});

		$("#id_formModificarMascota").on(
				'submit',
				function(evt) {
					var validator = $('#id_formModificarMascota').data(
							'bootstrapValidator');
					if (validator.isValid()) {
						swal("¡Éxito!", "Mascota actualizada correctamente.",
								"success");
					}
				});
	</script>


	<!-- Validaciones de Registrar -->
	<script type="text/javascript">
		$(document)
				.ready(
						function() {
							$('#id_formRegistrarMascota')
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
														selector : "#id_nombreMascotaRegistrar",
														validators : {
															notEmpty : {
																message : 'El nombre es obligatorio'
															},
															stringLength : {
																max : 40,
																message : 'El nombre es de 40 caracteres como máximo'
															},
														}
													},
													tipo : {
														selector : "#id_tipoMascotaRegistrar",
														validators : {
															notEmpty : {
																message : 'El tipo de mascota es obligatorio'
															},
														}
													},
													raza : {
														selector : "#id_razaMascotaRegistrar",
														validators : {
															notEmpty : {
																message : 'La raza es obligatoria'
															},
														},
														stringLength : {
															max : 40,
															message : 'El nombre es de 40 caracteres como máximo'
														},
													},
													fecha : {
														selector : "#id_fechaNacMascotaRegistrar",
														validators : {
															notEmpty : {
																message : 'La fecha es obligatoria'
															},
														}
													},
												}
											});
						});
	</script>


	<!-- Validaciones de Registrar -->
	<script type="text/javascript">
		$(document)
				.ready(
						function() {
							$('#id_formModificarMascota')
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
														selector : "#id_nombreMascotaModificar",
														validators : {
															notEmpty : {
																message : 'El nombre es obligatorio'
															},
															stringLength : {
																max : 40,
																message : 'El nombre es de 40 caracteres como máximo'
															},
														}
													},
													tipo : {
														selector : "#id_tipoMascotaModificar",
														validators : {
															notEmpty : {
																message : 'El tipo de mascota es obligatorio'
															},
														}
													},
													raza : {
														selector : "#id_razaMascotaModificar",
														validators : {
															notEmpty : {
																message : 'La raza es obligatoria'
															},
														},
														stringLength : {
															max : 40,
															message : 'El nombre es de 40 caracteres como máximo'
														},
													},
													fecha : {
														selector : "#id_fechaNacMascotaModificar",
														validators : {
															notEmpty : {
																message : 'La fecha es obligatoria'
															},
														}
													},
												}
											});
						});
	</script>

</body>

</html>




