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

<link rel="stylesheet" type="text/css" href="vendor/main.css">
<link rel="stylesheet" href="css/bootstrapValidator.css" />
<style type="text/css">
.caja {
	margin-top: 10px;
	border: 1px solid #d9d9d9;
	overflow: hidden;
	position: relative;
	color: #AAAAAA;
}

.estilo-select {
	background: transparent;
	border: none;
	font-size: 14px;
	height: 30px;
	padding-left: 5px;
	width: 100%;
	color: #AAAAAA;
}

.estilo-select:focus {
	outline: none;
}

.caja::after {
	content: "\025be";
	display: table-cell;
	padding-top: 5px;
	text-align: center;
	width: 30px;
	height: 31px;
	background-color: #d9d9d9;
	position: absolute;
	top: 0;
	right: 0px;
	pointer-events: none;
}
</style>
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
											<i class="material-icons">inventory_2</i> Datos de Producto
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
																		onclick="verModalProductoRegistra();"
																		class="btn btn-primary pull-left">Registrar
																		Producto</button>
																</div>
																<br />
																<div class="row">
																	<table id="tablaProductos" class="table table-hover">
																		<thead class="text-primary">
																			<tr>
																				<th>ID</th>
																				<th>Nombre</th>
																				<th>Precio</th>
																				<th>Stock</th>
																				<th>Serie</th>
																				<th>Marca</th>
																				<th>Proveedor</th>
																				<th>Descripción</th>
																				<th>Imagen</th>
																				<th style="width: 102.4px;">Editar</th>
																				<th style="width: 102.4px;">Eliminar</th>
																			</tr>
																		</thead>
																		<tbody>
																			<c:forEach items="${productos}" var="producto">
																				<tr>
																					<td>${producto.idProducto}</td>
																					<td>${producto.nombre}</td>
																					<td>${producto.precio}</td>
																					<td>${producto.stock}</td>
																					<td>${producto.serie}</td>
																					<td>${producto.idMarca.nombre}</td>
																					<td>${producto.idProveedor.razonSocial}</td>
																					<td>${producto.descripcion}</td>
																					<td><img
																						src="images/productos/${producto.imagen}"
																						alt="img" width="50px" height="50px"></td>
																					<td>
																						<button type="button"
																							onclick="verModalProductoModifica('${producto.idProducto}','${producto.nombre}','${producto.precio}','${producto.stock}','${producto.serie}','${producto.idMarca.idMarca}','${producto.idProveedor.idProveedor}','${producto.descripcion}');"
																							class="btn btn-primary">
																							<img src="images/edit.gif" width="auto"
																								height="auto" />
																						</button>
																					</td>
																					<td>
																						<button type="button"
																							onclick="verModalProductoElimina('${producto.idProducto}');"
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




			<!-- Modal de Registro de Producto -->

			<div class="modal fade" id="idModalRegistraProducto"
				data-backdrop="static" tabindex="-1" role="dialog">
				<div class="modal-dialog" style="width: 45%; margin: 60px auto 0;">
					<!-- Modal content-->
					<div class="modal-content">
						<div class="card">
							<div class="card-header card-header-primary">
								<h3 class="card-title">Registrar Producto</h3>
							</div>
							<div class="card-body" style="padding: 20px 18px;">
								<form accept-charset="UTF-8" id="id_formRegistrarProducto"
									action="registrarProducto" method="post"
									enctype="multipart/form-data">
									<div class="row">
										<div class="col-md-12">
											<div class="form-group">
												<label class="bmd-label-floating">Nombre de Artículo</label>
												<input class="form-control" type="text"
													id="id_nombreRegistrar" name="nombre">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-12">
											<div class="form-group">
												<label class="bmd-label-floating">Precio</label> <input
													class="form-control" type="text" id="id_precioRegistrar"
													name="precio">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-12">
											<div class="form-group">
												<label class="bmd-label-floating">Stock</label> <input
													class="form-control" type="text" id="id_stockRegistrar"
													name="stock">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-12">
											<div class="form-group">
												<label class="bmd-label-floating">Serie</label> <input
													class="form-control" type="text" id="id_serieRegistrar"
													name="serie">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-12">
											<div class="caja">
												<select id="id_marcaRegistrar" class="estilo-select"
													name="idMarca.idMarca">
													<option value="">[ SELECCIONAR MARCA ]</option>
													<c:forEach var="marca" items="${marcas}">
														<option value="${marca.idMarca}">${marca.nombre}</option>
													</c:forEach>
												</select>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-12">
											<div class="caja">
												<select id="id_proveedorRegistrar" class="estilo-select"
													name="idProveedor.idProveedor">
													<option value="">[ SELECCIONAR PROVEEDOR ]</option>
													<c:forEach var="proveedor" items="${proveedores}">
														<option value="${proveedor.idProveedor}">${proveedor.razonSocial}</option>
													</c:forEach>
												</select>
											</div>
										</div>
									</div>
									<div class="row" style="margin-top: 15px;">
										<div class="col-md-12">
											<div class="form-group">
												<label class="bmd-label-floating">Descripción</label> <input
													class="form-control" type="text"
													id="id_descripcionRegistrar" name="descripcion">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-12">
											<div class="form-group">
												<label class="bmd-label">Imagen</label>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-12">
											<input class="form-control-imagen" type="file"
												id="id_imagenRegistrar" name="imagenProductoRegistrar">
										</div>
									</div>
									<button type="button" onclick="cerrarModalProductoRegistra();"
										class="btn btn-primary pull-right">Cancelar</button>
									<button id="id_btnRegistrarProducto" type="submit"
										class="btn btn-primary pull-right">Registrar</button>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>

			<!-- Modal de Registro de Producto -->



			<!-- Modal de Modificar Producto -->

			<div class="modal fade" id="idModalModificaProducto"
				data-backdrop="static" tabindex="-1" role="dialog">
				<div class="modal-dialog" style="width: 45%; margin: 60px auto 0;">
					<!-- Modal content-->
					<div class="modal-content">
						<div class="card">
							<div class="card-header card-header-primary">
								<h3 class="card-title">Modificar Producto</h3>
							</div>
							<div class="card-body" style="padding: 20px 18px;">
								<form accept-charset="UTF-8" id="id_formModificarProducto"
									action="modificarProducto" method="post"
									enctype="multipart/form-data">
									<div class="row" hidden="hidden">
										<div class="col-md-12">
											<div class="form-group">
												<input class="form-control" type="text"
													id="id_codigoModificar" name="idProducto">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-12">
											<div class="form-group" id="div_nombreModificar">
												<label class="bmd-label-floating">Nombre de Artículo</label>
												<input class="form-control" type="text"
													id="id_nombreModificar" name="nombre">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-12">
											<div class="form-group" id="div_precioModificar">
												<label class="bmd-label-floating">Precio</label> <input
													class="form-control" type="text" id="id_precioModificar"
													name="precio">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-12">
											<div class="form-group" id="div_stockModificar">
												<label class="bmd-label-floating">Stock</label> <input
													class="form-control" type="text" id="id_stockModificar"
													name="stock">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-12">
											<div class="form-group" id="div_serieModificar">
												<label class="bmd-label-floating">Serie</label> <input
													class="form-control" type="text" id="id_serieModificar"
													name="serie">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-12">
											<div class="caja">
												<select id="id_marcaModificar" class="estilo-select"
													name="idMarca.idMarca">
													<option value="">[ SELECCIONAR MARCA ]</option>
													<c:forEach var="marca" items="${marcas}">
														<option value="${marca.idMarca}">${marca.nombre}</option>
													</c:forEach>
												</select>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-12">
											<div class="caja">
												<select id="id_proveedorModificar" class="estilo-select"
													name="idProveedor.idProveedor">
													<option value="">[ SELECCIONAR PROVEEDOR ]</option>
													<c:forEach var="proveedor" items="${proveedores}">
														<option value="${proveedor.idProveedor}">${proveedor.razonSocial}</option>
													</c:forEach>
												</select>
											</div>
										</div>
									</div>
									<div class="row" style="margin-top: 15px;">
										<div class="col-md-12">
											<div class="form-group" id="div_descripcionModificar">
												<label class="bmd-label-floating">Descripción</label> <input
													class="form-control" type="text"
													id="id_descripcionModificar" name="descripcion">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-12">
											<div class="form-group">
												<label class="bmd-label">Imagen</label>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-12">
											<input class="form-control-imagen" type="file"
												id="id_imagenModificar" name="imagenProductoModificar">
										</div>
									</div>
									<button type="button" onclick="cerrarModalProductoModifica();"
										class="btn btn-primary pull-right">Cancelar</button>
									<button id="id_btnModificarProducto" type="submit"
										class="btn btn-primary pull-right">Actualizar</button>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>

			<!-- Modal de Modificar Producto -->



			<!-- Modal de Eliminar Producto -->

			<div class="modal fade" id="idModalEliminaProducto"
				data-backdrop="static" tabindex="-1" role="dialog">
				<div class="modal-dialog" style="width: 25%; margin: 20% auto 0;">
					<!-- Modal content-->
					<div class="modal-content">
						<div class="card">
							<div class="card-header card-header-primary">
								<h3 class="card-title">Eliminar Producto</h3>
							</div>
							<div class="card-body" style="padding: 20px 18px;">
								<form accept-charset="UTF-8" action="eliminarProducto"
									method="post">
									<div class="row" hidden="hidden">
										<div class="col-md-12">
											<div class="form-group">
												<input class="form-control" type="text"
													id="id_codigoEliminar" name="idProducto">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-12">
											<div class="form-group">
												<span class="pull-center">¿Desea eliminar el producto
													seleccionado?</span>
											</div>
										</div>
									</div>
									<button type="button" onclick="cerrarModalProductoElimina();"
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

	<!-- Validación de Registrar  -->
	<script type="text/javascript">
		$(document)
				.ready(
						function() {
							$('#id_formRegistrarProducto')
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
															},
														}
													},
													precio : {
														selector : "#id_precioRegistrar",
														validators : {
															notEmpty : {
																message : 'El precio es obligatorio'
															},
															regexp : {
																regexp : /^[0-9]*\.?[0-9]+$/,
																message : 'El precio debe ser real'
															},
														}
													},
													stock : {
														selector : "#id_stockRegistrar",
														validators : {
															notEmpty : {
																message : 'El stock es obligatorio'
															},
															regexp : {
																regexp : /^[0-9]+$/,
																message : 'El stock debe ser un número entero'
															}
														}
													},
													serie : {
														selector : "#id_serieRegistrar",
														validators : {
															notEmpty : {
																message : 'La serie es obligatoria'
															},
														}
													},
													marca : {
														selector : "#id_marcaRegistrar",
														validators : {
															notEmpty : {
																message : 'La marca es obligatoria'
															},
														}
													},
													proveedor : {
														selector : "#id_proveedorRegistrar",
														validators : {
															notEmpty : {
																message : 'El proveedor es obligatorio'
															},
														}
													},
													descripcion : {
														selector : "#id_descripcionRegistrar",
														validators : {
															notEmpty : {
																message : 'El descripción es obligatorio'
															},
														}
													},
													imagen : {
														selector : "#id_imagenRegistrar",
														validators : {
															notEmpty : {
																message : 'La imagen es obligatoria'
															},
														}
													},
												}
											});
						});
	</script>

	<!-- Validación de Modificar  -->
	<script type="text/javascript">
		$(document)
				.ready(
						function() {
							$('#id_formModificarProducto')
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
															},
														}
													},
													precio : {
														selector : "#id_precioModificar",
														validators : {
															notEmpty : {
																message : 'El precio es obligatorio'
															},
														}
													},
													stock : {
														selector : "#id_stockModificar",
														validators : {
															notEmpty : {
																message : 'El stock es obligatorio'
															},
															regexp : {
																regexp : /^[0-9]+$/,
																message : 'El stock debe ser un número entero'
															}
														}
													},
													serie : {
														selector : "#id_serieModificar",
														validators : {
															notEmpty : {
																message : 'La serie es obligatoria'
															},
														}
													},
													marca : {
														selector : "#id_marcaModificar",
														validators : {
															notEmpty : {
																message : 'La marca es obligatoria'
															},
														}
													},
													proveedor : {
														selector : "#id_proveedorModificar",
														validators : {
															notEmpty : {
																message : 'El proveedor es obligatorio'
															},
														}
													},
													descripcion : {
														selector : "#id_descripcionModificar",
														validators : {
															notEmpty : {
																message : 'El descripción es obligatorio'
															},
														}
													},
												}
											});
						});
	</script>

	<!-- Script de Modal's  -->
	<script type="text/javascript">
		$('#id_menuCrudProductos').addClass('active');

		function verModalProductoRegistra() {
			$('#idModalRegistraProducto').modal("show");
		}

		function cerrarModalProductoRegistra() {
			$('#idModalRegistraProducto').modal("hide");
			$("#idModalRegistraProducto input").val("");
			$("#idModalRegistraProducto small").css("display", "none");
			$("#idModalRegistraProducto div.form-group").removeClass(
					"is-filled has-success");
			$("#id_btnRegistrarProducto").attr("disabled", false);
		}

		function verModalProductoModifica(id, nombre, precio, stock, serie,
				marca, proveedor, descripcion) {
			$("#id_codigoModificar").val(id);
			$("#id_nombreModificar").val(nombre);
			$("#div_nombreModificar").addClass('is-filled');
			$("#id_precioModificar").val(precio);
			$("#div_precioModificar").addClass('is-filled');
			$("#id_stockModificar").val(stock);
			$("#div_stockModificar").addClass('is-filled');
			$("#id_serieModificar").val(serie);
			$("#div_serieModificar").addClass('is-filled');
			$("#id_marcaModificar").val(marca);
			$("#div_marcaModificar").addClass('is-filled');
			$("#id_proveedorModificar").val(proveedor);
			$("#div_proveedorModificar").addClass('is-filled');
			$("#id_descripcionModificar").val(descripcion);
			$("#div_descripcionModificar").addClass('is-filled');
			$('#idModalModificaProducto').modal("show");
		}

		function cerrarModalProductoModifica() {
			$('#idModalModificaProducto').modal("hide");
			$("#idModalModificaProducto input").val("");
			$("#idModalModificaProducto small").css("display", "none");
			$("#idModalModificaProducto div.form-group").removeClass(
					"is-filled has-success");
			$("#id_btnModificarProducto").attr("disabled", false);
		}

		function verModalProductoElimina(id) {
			$("#id_codigoEliminar").val(id);
			$('#idModalEliminaProducto').modal("show");
		}

		function cerrarModalProductoElimina() {
			$('#idModalEliminaProducto').modal("hide");
		}
	</script>
</body>

</html>




