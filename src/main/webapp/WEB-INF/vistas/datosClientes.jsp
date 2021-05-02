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
<link rel="icon" type="image/png" href="images/icons/favicon.ico" />
<link rel="stylesheet" href="css/bootstrapValidator.css" />

</head>
<body class="">
	<c:if test="${objCargo == null}">
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
											<i class="material-icons">person</i> Registro
										</h3>
									</div>
									<div class="card-body">
										<form id="form_crearCliente" accept-charset="UTF-8"
											action="registrarCliente" method="post"
											onsubmit="funcionSubmitRegistrar(event);">
											<div class="row">
												<div class="col-md-12">
													<div class="card-header"
														style="border-bottom: #9c27b0 1px solid;">
														<h4 class="card-title" style="color: #9c27b0">
															<strong>Datos del Cliente</strong>
														</h4>
													</div>
													<div class="card-body" style="padding: 20px 10px;">
														<div class="row">
															<div class="col-md-6">
																<div class="form-group">
																	<label class="bmd-label-floating">Nombre</label> <input
																		id="id_nombre" type="text" class="form-control"
																		name="nombre">
																</div>
															</div>
															<div class="col-md-6">
																<div class="form-group">
																	<label class="bmd-label-floating">Apellido</label> <input
																		id="id_apellido" type="text" class="form-control"
																		name="apellido">
																</div>
															</div>
														</div>
														<div class="row">
															<div class="col-md-8">
																<div class="form-group">
																	<label class="bmd-label-floating">Dirección</label> <input
																		id="id_direccion" type="text" class="form-control"
																		name="direccion">
																</div>
															</div>
															<div class="col-md-4">
																<div class="caja">
																	<select id="id_distrito" class="estilo-select"
																		name="idDistrito.idDistrito">
																		<option value="">[ SELECCIONAR DISTRITO ]</option>
																		<c:forEach var="distrito" items="${distritos}">
																			<option value="${distrito.idDistrito}">${distrito.nombre}</option>
																		</c:forEach>
																	</select>
																</div>
															</div>
														</div>
														<div class="row">
															<div class="col-md-4">
																<div class="form-group">
																	<label class="bmd-label-floating">Teléfono</label> <input
																		id="id_telefono" type="text" class="form-control"
																		name="telefono">
																</div>
															</div>
															<div class="col-md-4">
																<div class="form-group">
																	<label class="bmd-label-floating">Celular</label> <input
																		id="id_celular" type="text" class="form-control"
																		name="celular">
																</div>
															</div>
															<div class="col-md-4">
																<div class="form-group">
																	<label class="bmd-label-floating">D.N.I.</label> <input
																		id="id_dni" type="text" class="form-control"
																		name="dni">
																</div>
															</div>
														</div>
														<div class="row">
															<div class="col-md-8">
																<div class="form-group">
																	<label class="bmd-label-floating">Email</label> <input
																		id="id_email" type="text" class="form-control"
																		name="email">
																</div>
															</div>
														</div>
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-md-12">
													<div class="card-header"
														style="border-bottom: #9c27b0 1px solid;">
														<h4 class="card-title" style="color: #9c27b0">
															<strong>Datos de Usuario</strong>
														</h4>
													</div>
													<div class="card-body" style="padding: 20px 10px;">
														<div class="row" hidden="hidden">
															<div class="col-md-12">
																<div class="form-group">
																	<input class="form-control" type="text"
																		name="idUsuario.cargo" value="Cliente">
																</div>
															</div>
														</div>
														<div class="row">
															<div class="col-md-6">
																<div class="form-group">
																	<label class="bmd-label-floating">Usuario</label> <input
																		id="id_usuario" type="text" class="form-control"
																		name="idUsuario.nomUsuario">
																</div>
															</div>
														</div>
														<div class="row">
															<div class="col-md-6">
																<div class="form-group">
																	<label class="bmd-label-floating">Contraseña</label> <input
																		id="id_contrasenia" type="password"
																		class="form-control" name="idUsuario.contrasenia">
																</div>
															</div>
														</div>
														<div class="row">
															<div class="col-md-6">
																<div class="form-group">
																	<label class="bmd-label-floating">Confirmar
																		Contraseña</label> <input type="password" class="form-control"
																		id="id_contraseniaConfirmar"><small
																		id="mensaje_errorConfirmar" style="color: #cc0000;">Las
																		contraseñas no coinciden</small>
																</div>
															</div>
														</div>
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-md-12">
													<button type="button" onclick="history.go(-1)"
														class="btn btn-primary pull-right">Cancelar</button>
													<button id="id_crearCliente" type="submit"
														class="btn btn-primary pull-right">Crear Cliente</button>
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
	</c:if>

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
											<i class="material-icons">person</i> Editar Cliente
										</h3>
									</div>
									<div class="card-body">
										<form id="form_modificarCliente" accept-charset="UTF-8">
											<div class="row">
												<div class="col-md-12">
													<div class="card-header"
														style="border-bottom: #9c27b0 1px solid;">
														<h4 class="card-title" style="color: #9c27b0">
															<strong>Datos del Cliente</strong>
														</h4>
													</div>
													<div class="card-body" style="padding: 20px 10px;">
														<div class="row">
															<div class="col-md-6">
																<div class="form-group">
																	<label class="bmd-label-floating">Nombre</label> <input
																		id="id_nombreModificar" type="text"
																		class="form-control" value="${clientes.nombre}">
																</div>
															</div>
															<div class="col-md-6">
																<div class="form-group">
																	<label class="bmd-label-floating">Apellido</label> <input
																		id="id_apellidoModificar" type="text"
																		class="form-control" value="${clientes.apellido}">
																</div>
															</div>
														</div>
														<div class="row">
															<div class="col-md-8">
																<div class="form-group">
																	<label class="bmd-label-floating">Dirección</label> <input
																		id="id_direccionModificar" type="text"
																		class="form-control" value="${clientes.direccion}">
																</div>
															</div>
															<div class="col-md-4">
																<div class="caja">
																	<select id="id_distritoModificar" class="estilo-select">
																		<option value="">[ SELECCIONAR DISTRITO ]</option>
																		<c:forEach var="distrito" items="${distritos}">
																			<c:if
																				test="${clientes.idDistrito.idDistrito == distrito.idDistrito}">
																				<option value="${distrito.idDistrito}"
																					selected="selected">${distrito.nombre}</option>
																			</c:if>
																			<c:if
																				test="${clientes.idDistrito.idDistrito != distrito.idDistrito}">
																				<option value="${distrito.idDistrito}">${distrito.nombre}</option>
																			</c:if>
																		</c:forEach>
																	</select>
																</div>
															</div>
														</div>
														<div class="row">
															<div class="col-md-4">
																<div class="form-group">
																	<label class="bmd-label-floating">Teléfono</label> <input
																		id="id_telefonoModificar" type="text"
																		class="form-control" value="${clientes.telefono}">
																</div>
															</div>
															<div class="col-md-4">
																<div class="form-group">
																	<label class="bmd-label-floating">Celular</label> <input
																		id="id_celularModificar" type="text"
																		class="form-control" value="${clientes.celular}">
																</div>
															</div>
															<div class="col-md-4">
																<div class="form-group">
																	<label class="bmd-label-floating">D.N.I.</label> <input
																		id="id_dniModificar" type="text" class="form-control"
																		value="${clientes.dni}">
																</div>
															</div>
														</div>
														<div class="row">
															<div class="col-md-8">
																<div class="form-group">
																	<label class="bmd-label-floating">Email</label> <input
																		id="id_emailModificar" type="text"
																		class="form-control" value="${clientes.email}">
																</div>
															</div>
														</div>
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-md-12">
													<button type="button" onclick="history.go(-1)"
														class="btn btn-primary pull-right">Cancelar</button>
													<button type="button" class="btn btn-primary pull-right"
														onclick="verModalConfirmarContrasenia();">Editar
														Cliente</button>
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
		<div class="modal fade" id="idModalConfirmarContrasenia"
			data-backdrop="static" tabindex="-1" role="dialog">
			<div class="modal-dialog" style="width: 30%; margin: 15% auto 0;">
				<!-- Modal content-->
				<div class="modal-content">
					<div class="card">
						<div class="card-header card-header-primary">
							<h3 class="card-title">Confirmar Contraseña</h3>
						</div>
						<div class="card-body" style="padding: 20px 18px;">
							<form accept-charset="UTF-8" action="modificarCliente"
								method="post" onsubmit="funcionSubmitModificar(event)">
								<div class="row" hidden="hidden">
									<div class="col-md-12">
										<input class="form-control" type="text" name="idCliente"
											value="${clientes.idCliente}">
									</div>
									<div class="col-md-12">
										<input id="ayuda_modificarClienteNombre" class="form-control"
											type="text" name="nombre">
									</div>
									<div class="col-md-12">
										<input id="ayuda_modificarClienteApellido"
											class="form-control" type="text" name="apellido">
									</div>
									<div class="col-md-12">
										<input id="ayuda_modificarClienteDireccion"
											class="form-control" type="text" name="direccion">
									</div>
									<div class="col-md-12">
										<input id="ayuda_modificarClienteDistrito"
											class="form-control" type="text" name="idDistrito.idDistrito">
									</div>
									<div class="col-md-12">
										<input id="ayuda_modificarClienteTelefono"
											class="form-control" type="text" name="telefono">
									</div>
									<div class="col-md-12">
										<input id="ayuda_modificarClienteCelular" class="form-control"
											type="text" name="celular">
									</div>
									<div class="col-md-12">
										<input id="ayuda_modificarClienteDni" class="form-control"
											type="text" name="dni">
									</div>
									<div class="col-md-12">
										<input id="ayuda_modificarClienteEmail" class="form-control"
											type="text" name="email">
									</div>
								</div>
								<div class="row">
									<div class="col-md-12">
										<div class="form-group">
											<h4 class="card-title"
												style="color: #9c27b0; font-family: emoji; font-size: 25px;">Ingrese
												su Contraseña</h4>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12">
										<div class="form-group">
											<label class="bmd-label-floating">Contraseña</label> <input
												id="id_contraseniaModificar" type="password"
												class="form-control" name="idUsuario.contrasenia">
										</div>
									</div>
								</div>
								<button type="button"
									onclick="cerrarModalConfirmarContrasenia();"
									class="btn btn-primary pull-right">Cancelar</button>
								<button id="id_modificarCliente" type="submit"
									class="btn btn-primary pull-right">Confirmar</button>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</c:if>

	<!-- Restricción de Acceso -->

	<c:if test="${objCargo == 'Personal de Ventas'}">
		<div class="container-login100"
			style="background-image: url('images/error403.jpg');"></div>
	</c:if>

	<script type="text/javascript">
		function verModalConfirmarContrasenia() {
			var validator = $('#form_modificarCliente').data(
					'bootstrapValidator');
			validator.validate();
			if (validator.isValid()) {
				$("#idModalConfirmarContrasenia").modal("show");
				$("#ayuda_modificarClienteNombre").val(
						$("#id_nombreModificar").val());
				$("#ayuda_modificarClienteApellido").val(
						$("#id_apellidoModificar").val());
				$("#ayuda_modificarClienteDireccion").val(
						$("#id_direccionModificar").val());
				$("#ayuda_modificarClienteDistrito").val(
						$("#id_distritoModificar option:selected").val());
				$("#ayuda_modificarClienteTelefono").val(
						$("#id_telefonoModificar").val());
				$("#ayuda_modificarClienteCelular").val(
						$("#id_celularModificar").val());
				$("#ayuda_modificarClienteDni")
						.val($("#id_dniModificar").val());
				$("#ayuda_modificarClienteEmail").val(
						$("#id_emailModificar").val());
			}
		}

		function cerrarModalConfirmarContrasenia() {
			$("#id_contraseniaModificar").val("");
			$("#idModalConfirmarContrasenia div.form-group").removeClass(
					"is-filled has-success");
			$("#idModalConfirmarContrasenia").modal("hide");
		}

		function funcionSubmitModificar(event) {
			event.preventDefault();
			$("#id_modificarCliente").attr("disabled", false);
			var contra = $('#id_contraseniaModificar').val();
			$.ajax({
				type : 'POST',
				data : {
					'con_usuario' : contra
				},
				url : 'validacionContrasenia',
				success : function(data) {
					if (data.CONFIRMACION == 'SI') {
						swal("Éxito!", data.MENSAJE, "success");
						setTimeout(function() {
							event.target.submit();
						}, 1000);
					} else {
						swal("Error!", data.MENSAJE, "error");
					}
				},
				error : function() {
				}
			});
		}
	</script>

	<!-- Validar Contraseña de Registrar Usuario -->
	<script type="text/javascript">
		$("#id_menuClientes").addClass("active");
		$(document).ready(function() {
			$('#mensaje_errorConfirmar').hide();
		});

		var comfirmarPassRegistrar = function() {
			var cont = $('#id_contrasenia').val();
			var cont2 = $('#id_contraseniaConfirmar').val();
			if (cont2.length > 0) {
				if (cont == cont2) {
					$('#mensaje_errorConfirmar').hide();
				} else {
					$('#mensaje_errorConfirmar').show();
				}
			} else {
				$('#mensaje_errorConfirmar').hide();
			}
		}

		$("#id_contrasenia").on('keyup', comfirmarPassRegistrar);
		$("#id_contraseniaConfirmar").on('keyup', comfirmarPassRegistrar);

		function funcionSubmitRegistrar(event) {
			var contra = $('#id_contrasenia').val();
			var contra2 = $('#id_contraseniaConfirmar').val();
			var usuario = $('#id_usuario').val();

			event.preventDefault();

			if ((contra == contra2) && (usuario != '') && (contra != '')
					&& (contra2 != '')) {
				$.ajax({
					type : 'POST',
					data : {
						'nom_usuario' : usuario
					},
					url : 'validacionUsuario',
					success : function(data) {
						if (data.CONFIRMACION == 'SI') {
							swal("Registrado con éxito!", data.MENSAJE,
									"success");
							setTimeout(function() {
								event.target.submit();
							}, 1000);
						} else {
							swal("Error!", data.MENSAJE, "error");
						}
					},
					error : function() {
						swal("Error!", "", "error");
					}
				});
			}
		}
	</script>

	<!-- Validaciones de Registrar -->
	<script type="text/javascript">
		$(document).ready(function() {
			$('#form_crearCliente').bootstrapValidator({
				message : 'This value is not valid',
				feedbackIcons : {
					valid : 'glyphicon glyphicon-ok',
					invalid : 'glyphicon glyphicon-remove',
					validating : 'glyphicon glyphicon-refresh'
				},
				fields : {
					nombre : {
						selector : "#id_nombre",
						validators : {
							notEmpty : {
								message : 'El nombre es obligatorio'
							},
							stringLength : {
								min : 3,
								max : 40,
								message : 'El nombre es de 3 a 40 caracteres'
							},
						}
					},
					apellido : {
						selector : "#id_apellido",
						validators : {
							notEmpty : {
								message : 'El apellido es obligatorio'
							},
							stringLength : {
								min : 3,
								max : 40,
								message : 'El apellido es de 3 a 40 caracteres'
							},
						}
					},
					direccion : {
						selector : "#id_direccion",
						validators : {
							notEmpty : {
								message : 'El direccion es obligatorio'
							},
						}
					},
					distrito : {
						selector : "#id_distrito",
						validators : {
							notEmpty : {
								message : 'El distrito es obligatorio'
							},
						}
					},
					telefono : {
						selector : "#id_telefono",
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
						selector : "#id_celular",
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
					dni : {
						selector : "#id_dni",
						validators : {
							notEmpty : {
								message : 'El dni es obligatorio'
							},
							regexp : {
								regexp : /^[0-9]{8}$/,
								message : 'El dni es 8 dígitos'
							}
						}
					},
					email : {
						selector : "#id_email",
						validators : {
							notEmpty : {
								message : 'El correo es obligatorio'
							},
							emailAddress : {
								message : 'El correo no es valido'
							}
						}
					},
					usuario : {
						selector : "#id_usuario",
						validators : {
							notEmpty : {
								message : 'El usuario es obligatorio'
							},
							stringLength : {
								min : 3,
								max : 40,
								message : 'El usuario es de 3 a 40 caracteres'
							},
						}
					},
					contraseña : {
						selector : "#id_contrasenia",
						validators : {
							notEmpty : {
								message : 'La contraseña es obligatoria'
							},
							stringLength : {
								min : 8,
								message : 'La contraseña es muy corta'
							},
						}
					},
					confirmarContraseña : {
						selector : "#id_contraseniaConfirmar",
						validators : {
							notEmpty : {
								message : 'Confirmar contraseña'
							},
						}
					},
				}
			});
		});
	</script>

	<!-- Validaciones de Modificar -->
	<script type="text/javascript">
		$(document).ready(function() {
			$('#form_modificarCliente').bootstrapValidator({
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
								max : 40,
								message : 'El nombre es de 3 a 40 caracteres'
							},
						}
					},
					apellido : {
						selector : "#id_apellidoModificar",
						validators : {
							notEmpty : {
								message : 'El apellido es obligatorio'
							},
							stringLength : {
								min : 3,
								max : 40,
								message : 'El apellido es de 3 a 40 caracteres'
							},
						}
					},
					direccion : {
						selector : "#id_direccionModificar",
						validators : {
							notEmpty : {
								message : 'El direccion es obligatorio'
							},
						}
					},
					distrito : {
						selector : "#id_distritoModificar",
						validators : {
							notEmpty : {
								message : 'El distrito es obligatorio'
							},
						}
					},
					telefono : {
						selector : "#id_telefonoModificar",
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
						selector : "#id_celularModificar",
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
					dni : {
						selector : "#id_dniModificar",
						validators : {
							notEmpty : {
								message : 'El dni es obligatorio'
							},
							regexp : {
								regexp : /^[0-9]{8}$/,
								message : 'El dni es 8 dígitos'
							}
						}
					},
					email : {
						selector : "#id_emailModificar",
						validators : {
							notEmpty : {
								message : 'El correo es obligatorio'
							},
							emailAddress : {
								message : 'El correo no es valido'
							}
						}
					},
				}
			});
		});
	</script>

</body>

</html>




