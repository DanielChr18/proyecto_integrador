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
<script type="text/javascript" src="ckeditor/ckeditor.js"></script>

<link rel="stylesheet" href="css/bootstrapValidator.css" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" />

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
																<div class="row" style="overflow: auto;">
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
																				<th>Acción</th>
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
																						src="images/productos/${producto.imagen1}"
																						alt="img" width="50px" height="50px"></td>
																					<td>
																						<button type="button"
																							onclick="verModalProductoModifica('${producto.idProducto}','${producto.nombre}','${producto.precio}','${producto.stock}','${producto.serie}','${producto.idMarca.idMarca}','${producto.idProveedor.idProveedor}','${producto.descripcion}');">
																							<span class="material-icons"> edit </span>
																						</button>
																						<button type="button"
																							onclick="verModalProductoElimina('${producto.idProducto}');">
																							<span class="material-icons"> delete </span>
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
				<div class="modal-dialog" style="width: 55%; margin: 60px auto 0;">
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
									<div class="row" id="id_divNombreRegistrar">
										<div class="col-md-12">
											<div class="form-group">
												<label class="bmd-label-floating">Nombre de Artículo</label>
												<input class="form-control" type="text"
													id="id_nombreRegistrar" name="nombre">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-4" id="id_divPrecioRegistrar">
											<div class="form-group">
												<label class="bmd-label-floating">Precio</label> <input
													class="form-control" type="text" id="id_precioRegistrar"
													name="precio">
											</div>
										</div>
										<div class="col-md-4" id="id_divStockRegistrar">
											<div class="form-group">
												<label class="bmd-label-floating">Stock</label> <input
													class="form-control" type="text" id="id_stockRegistrar"
													name="stock">
											</div>
										</div>
										<div class="col-md-4" id="id_divSerieRegistrar">
											<div class="form-group">
												<label class="bmd-label-floating">Serie</label> <input
													class="form-control" type="text" id="id_serieRegistrar"
													name="serie">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-6" id="id_divMarcaRegistrar">
											<label class="bmd-label">Marca</label>
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
										<div class="col-md-6" id="id_divProveedorRegistrar">
											<label class="bmd-label">Proveedor</label>
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
									<div class="row" id="id_divDescripcionRegistrar"
										style="margin-top: 15px;">
										<div class="col-md-12">
											<div class="form-group">
												<label class="bmd-label-floating">Descripción Corta</label>
												<input class="form-control" type="text"
													id="id_descripcionRegistrar" name="descripcion">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-12">
											<label class="bmd-label-floating">Descripción Larga</label>
											<textarea id="editor1" name="descripcionLarga"></textarea>
											<small id="id_mensajeDescripcionLargaRegistrar"
												style="color: #cc0000;">La descripción larga no
												puede estar vacía</small>
										</div>
									</div>
									<div class="row">
										<div class="col-md-12">
											<div class="form-group">
												<label class="bmd-label">Imagen 1</label>
											</div>
											<div class="invoiceBox">
												<label for="id_imagen1Registrar" id="boxFile1Registrar"
													class="boxFile" data-text="Seleccionar Imagen">
													Seleccionar Imagen </label> <input id="id_imagen1Registrar"
													name="imagen1ProductoRegistrar" size="6000" type="file"
													accept="image/x-png,image/jpeg,image/jpg,image/tiff">
											</div>
											<small id="id_mensajeImagen1Registrar"
												style="color: #cc0000;">Seleccionar Imagen</small>
										</div>
									</div>
									<div class="row">
										<div class="col-md-12">
											<div class="form-group">
												<label class="bmd-label">Imagen 2</label>
											</div>
											<div class="invoiceBox">
												<label for="id_imagen2Registrar" id="boxFile2Registrar"
													class="boxFile" data-text="Seleccionar Imagen">
													Seleccionar Imagen </label> <input id="id_imagen2Registrar"
													name="imagen2ProductoRegistrar" size="6000" type="file"
													accept="image/x-png,image/jpeg,image/jpg,image/tiff">
											</div>
											<small id="id_mensajeImagen2Registrar"
												style="color: #cc0000;">Seleccionar Imagen</small>
										</div>
									</div>
									<div class="row">
										<div class="col-md-12">
											<div class="form-group">
												<label class="bmd-label">Imagen 3</label>
											</div>
											<div class="invoiceBox">
												<label for="id_imagen3Registrar" id="boxFile3Registrar"
													class="boxFile" data-text="Seleccionar Imagen">
													Seleccionar Imagen </label> <input id="id_imagen3Registrar"
													name="imagen3ProductoRegistrar" size="6000" type="file"
													accept="image/x-png,image/jpeg,image/jpg,image/tiff">
											</div>
											<small id="id_mensajeImagen3Registrar"
												style="color: #cc0000;">Seleccionar Imagen</small>
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

			<!-- Modal de Modificar Producto -->
			<div class="modal fade" id="idModalModificaProducto"
				data-backdrop="static" tabindex="-1" role="dialog">
				<div class="modal-dialog" style="width: 55%; margin: 60px auto 0;">
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
										<input class="form-control" type="text"
											id="id_codigoModificar" name="idProducto">
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
										<div class="col-md-4">
											<div class="form-group" id="div_precioModificar">
												<label class="bmd-label-floating">Precio</label> <input
													class="form-control" type="text" id="id_precioModificar"
													name="precio">
											</div>
										</div>
										<div class="col-md-4">
											<div class="form-group" id="div_stockModificar">
												<label class="bmd-label-floating">Stock</label> <input
													class="form-control" type="text" id="id_stockModificar"
													name="stock">
											</div>
										</div>
										<div class="col-md-4">
											<div class="form-group" id="div_serieModificar">
												<label class="bmd-label-floating">Serie</label> <input
													class="form-control" type="text" id="id_serieModificar"
													name="serie">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-6">
											<label class="bmd-label">Marca</label>
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
										<div class="col-md-6">
											<label class="bmd-label">Proveedor</label>
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
											<label class="bmd-label-floating">Descripción Larga</label>
											<textarea id="editor2" name="descripcionLarga"></textarea>
											<small id="id_mensajeDescripcionLargaModificar"
												style="color: #cc0000;">La descripción larga no
												puede estar vacía</small>
										</div>
									</div>
									<div class="row">
										<div class="col-md-12">
											<div class="form-group">
												<label class="bmd-label">Imagen 1</label>
											</div>
											<div class="img" id="imagen1"></div>
											<div class="invoiceBox">
												<label for="id_imagen1Modificar" id="boxFile1Modificar"
													class="boxFile" data-text="Seleccionar Imagen">
													Seleccionar Imagen </label> <input id="id_imagen1Modificar"
													name="imagen1ProductoModificar" size="6000" type="file"
													accept="image/x-png,image/jpeg,image/jpg,image/tiff">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-12">
											<div class="form-group">
												<label class="bmd-label">Imagen 2</label>
											</div>
											<div class="img" id="imagen2"></div>
											<div class="invoiceBox">
												<label for="id_imagen2Modificar" id="boxFile2Modificar"
													class="boxFile" data-text="Seleccionar Imagen">
													Seleccionar Imagen </label> <input id="id_imagen2Modificar"
													name="imagen2ProductoModificar" size="6000" type="file"
													accept="image/x-png,image/jpeg,image/jpg,image/tiff">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-12">
											<div class="form-group">
												<label class="bmd-label">Imagen 3</label>
											</div>
											<div class="img" id="imagen3"></div>
											<div class="invoiceBox">
												<label for="id_imagen3Modificar" id="boxFile3Modificar"
													class="boxFile" data-text="Seleccionar Imagen">
													Seleccionar Imagen </label> <input id="id_imagen3Modificar"
													name="imagen3ProductoModificar" size="6000" type="file"
													accept="image/x-png,image/jpeg,image/jpg,image/tiff">
											</div>
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


	<script type="text/javascript">
		imagen('#id_imagen1Registrar', '#boxFile1Registrar',
				'#id_mensajeImagen1Registrar');
		imagen('#id_imagen2Registrar', '#boxFile2Registrar',
				'#id_mensajeImagen2Registrar');
		imagen('#id_imagen3Registrar', '#boxFile3Registrar',
				'#id_mensajeImagen3Registrar');
		imagen('#id_imagen1Modificar', '#boxFile1Modificar', null);
		imagen('#id_imagen2Modificar', '#boxFile2Modificar', null);
		imagen('#id_imagen3Modificar', '#boxFile3Modificar', null);
		$('#id_mensajeImagen1Registrar').hide();
		$('#id_mensajeImagen2Registrar').hide();
		$('#id_mensajeImagen3Registrar').hide();
		$('#id_mensajeDescripcionLargaRegistrar').hide();
		$('#id_mensajeDescripcionLargaModificar').hide();
	</script>


	<script type="text/javascript">
		$("#id_formRegistrarProducto")
				.on(
						'submit',
						function(evt) {
							if ($("#id_nombreRegistrar").val() == "")
								$(
										"#id_divNombreRegistrar small[data-bv-validator='notEmpty']")
										.css("display", "inline");
							if ($("#id_precioRegistrar").val() == "")
								$(
										"#id_divPrecioRegistrar small[data-bv-validator='notEmpty']")
										.css("display", "inline");
							if ($("#id_stockRegistrar").val() == "")
								$(
										"#id_divStockRegistrar small[data-bv-validator='notEmpty']")
										.css("display", "inline");
							if ($("#id_serieRegistrar").val() == "")
								$(
										"#id_divSerieRegistrar small[data-bv-validator='notEmpty']")
										.css("display", "inline");
							if ($("#id_marcaRegistrar").val() == "")
								$(
										"#id_divMarcaRegistrar small[data-bv-validator='notEmpty']")
										.css("display", "inline");
							if ($("#id_proveedorRegistrar").val() == "")
								$(
										"#id_divProveedorRegistrar small[data-bv-validator='notEmpty']")
										.css("display", "inline");
							if ($("#id_descripcionRegistrar").val() == "")
								$(
										"#id_divDescripcionRegistrar small[data-bv-validator='notEmpty']")
										.css("display", "inline");
							if ($("#id_imagen1Registrar").val() === "") {
								$("#id_btnRegistrarProducto").attr("disabled",
										false);
								$('#id_mensajeImagen1Registrar').show();
								evt.preventDefault();
							}
							if ($("#id_imagen2Registrar").val() === "") {
								$("#id_btnRegistrarProducto").attr("disabled",
										false);
								$('#id_mensajeImagen2Registrar').show();
								evt.preventDefault();
							}
							if ($("#id_imagen3Registrar").val() === "") {
								$("#id_btnRegistrarProducto").attr("disabled",
										false);
								$('#id_mensajeImagen3Registrar').show();
								evt.preventDefault();
							}
							if (CKEDITOR.instances['editor1'].getData() == "") {
								$("#id_btnRegistrarProducto").attr("disabled",
										false);
								$('#id_mensajeDescripcionLargaRegistrar')
										.show();
								evt.preventDefault();
							}
						});

		$("#id_formModificarProducto").on('submit', function(evt) {
			if (CKEDITOR.instances['editor2'].getData() == "") {
				$("#id_btnModificarProducto").attr("disabled", false);
				$('#id_mensajeDescripcionLargaModificar').show();
				evt.preventDefault();
			}
		});
	</script>

	<!-- Script de Modal's  -->
	<script type="text/javascript">
		$('#id_menuCrudProductos').addClass('active');

		function verModalProductoRegistra() {
			$('#boxFile1Registrar').text("Seleccionar Imagen");
			$('#boxFile1Registrar').removeClass("attached");
			$('#boxFile2Registrar').text("Seleccionar Imagen");
			$('#boxFile2Registrar').removeClass("attached");
			$('#boxFile3Registrar').text("Seleccionar Imagen");
			$('#boxFile3Registrar').removeClass("attached");
			$('#idModalRegistraProducto').modal("show");
		}

		function cerrarModalProductoRegistra() {
			$("#idModalRegistraProducto input").val("");
			CKEDITOR.instances['editor1'].setData('');
			$("#idModalRegistraProducto small").css("display", "none");
			$("#idModalRegistraProducto div.form-group").removeClass(
					"is-filled has-success");
			$("#id_btnRegistrarProducto").attr("disabled", false);
			$('#idModalRegistraProducto').modal("hide");
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
			$
					.getJSON(
							'obtenerHtmlProducto',
							{
								"idProducto" : id
							},
							function(data) {
								CKEDITOR.instances['editor2']
										.setData(data.descripcionLarga);
								$("#imagen1")
										.html(
												"<img src='images/productos/" + data.imagen1 +"' alt='img'>");
								$("#imagen2")
										.html(
												"<img src='images/productos/" + data.imagen2 +"' alt='img'>");
								$("#imagen3")
										.html(
												"<img src='images/productos/" + data.imagen3 +"' alt='img'>");
							});
			$('#idModalModificaProducto').modal("show");
		}

		function cerrarModalProductoModifica() {
			$('#idModalModificaProducto').modal("hide");
			$("#idModalModificaProducto input").val("");
			$("#idModalModificaProducto small").css("display", "none");
			$("#idModalModificaProducto div.form-group").removeClass(
					"is-filled has-success");
			$("#id_btnModificarProducto").attr("disabled", false);
			$('#boxFile1Modificar').text("Seleccionar Imagen");
			$('#boxFile1Modificar').removeClass("attached");
			$('#boxFile2Modificar').text("Seleccionar Imagen");
			$('#boxFile2Modificar').removeClass("attached");
			$('#boxFile3Modificar').text("Seleccionar Imagen");
			$('#boxFile3Modificar').removeClass("attached");
		}

		function verModalProductoElimina(id) {
			$("#id_codigoEliminar").val(id);
			$('#idModalEliminaProducto').modal("show");
		}

		function cerrarModalProductoElimina() {
			$('#idModalEliminaProducto').modal("hide");
		}
	</script>


	<!-- Script de TextArea  -->
	<script type="text/javascript">
		$(document).ready(function() {
			modificarTextArea('editor1', 'Registrar');
			modificarTextArea('editor2', 'Modificar');
		});

		function modificarTextArea(identificador, mensaje) {
			CKEDITOR
					.replace(
							identificador,
							{
								allowedContent : true,
								removePlugins : 'resize',
								language : 'es',
								toolbarGroups : [
										{
											name : 'clipboard',
											groups : [ 'undo', 'clipboard' ]
										},
										{
											name : 'editing',
											groups : [ 'find', 'selection',
													'spellchecker', 'editing' ]
										},
										{
											name : 'links',
											groups : [ 'links' ]
										},
										{
											name : 'insert',
											groups : [ 'insert' ]
										},
										{
											name : 'forms',
											groups : [ 'forms' ]
										},
										{
											name : 'tools',
											groups : [ 'tools' ]
										},
										{
											name : 'others',
											groups : [ 'others' ]
										},
										'/',
										{
											name : 'basicstyles',
											groups : [ 'basicstyles', 'cleanup' ]
										},
										{
											name : 'paragraph',
											groups : [ 'list', 'indent',
													'blocks', 'align', 'bidi',
													'paragraph' ]
										},
										{
											name : 'styles',
											groups : [ 'styles' ]
										},
										{
											name : 'colors',
											groups : [ 'colors' ]
										},
										{
											name : 'about',
											groups : [ 'about' ]
										},
										{
											name : 'document',
											groups : [ 'mode', 'document',
													'doctools' ]
										} ],
								removeButtons : 'Subscript,About,Blockquote,Outdent,Indent,RemoveFormat,Strike,Table,Source',
								on : {
									change : function() {
										var des = CKEDITOR.instances[identificador]
												.getData();
										if (des === '') {
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
	</script>

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
																message : 'La descripción es obligatoria'
															},
														}
													}
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
																message : 'La descripción es obligatorio'
															},
														}
													},
												}
											});
						});
	</script>

</body>

</html>




