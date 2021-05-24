<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<nav
	class="navbar navbar-expand-lg navbar-transparent navbar-absolute fixed-top"
	id="id_compras1">
	<div class="container-fluid">
		<div class="navbar-wrapper"></div>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			aria-controls="navigation-index" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="sr-only">Toggle navigation</span> <span
				class="navbar-toggler-icon icon-bar"></span> <span
				class="navbar-toggler-icon icon-bar"></span> <span
				class="navbar-toggler-icon icon-bar"></span>
		</button>
		<div class="collapse navbar-collapse justify-content-end">
			<form class="navbar-form"></form>
			<ul class="navbar-nav">
				<c:if test="${objCargo == 'Cliente' || objCargo == null}">
					<li class="nav-item dropdown" id="id_compras2"><a
						class="nav-link" href="http://example.com"
						id="navbarDropdownMenuLink" data-toggle="dropdown"
						aria-haspopup="true" aria-expanded="false"> <i
							class="material-icons">storefront</i> <c:if
								test="${objContadorProductos != null}">
								<span class="notification"> ${objContadorProductos} </span>
							</c:if> <c:if test="${objContadorProductos == null}">
								<span class="notification">0</span>
							</c:if>
							<p class="d-lg-none d-md-block">Compras</p>
					</a>
						<div class="dropdown-menu dropdown-menu-right"
							aria-labelledby="navbarDropdownMenuLink">
							<c:if test="${objListaProductosTexto == null}">
								<a class="dropdown-item" href="#"> No tienes productos
									seleccionados </a>
							</c:if>
							<c:if test="${objListaProductosTexto != null}">
								<div
									style="width: 240px; max-height: 240px; padding-right: 20px; overflow: auto;">
									<c:forEach var="x" items="${objListaProductosEntidad}">
										<div class="row">
											<div class="col-md-4">
												<img src="images/productos/${x.imagen1}" alt="img"
													style="width: 50px; height: 75px">
											</div>
											<div class="col-md-8">
												<div class="row">
													<ul class="info" style="margin: 0;">
														<li style="font-size: 11px; height: auto; width: 100%;">${x.nombre}</li>
														<li style="font-size: 11px;">S/ ${x.precio}</li>
													</ul>
												</div>
											</div>
										</div>
										<c:if test="${objUltimoProducto != x.idProducto}">
											<div class="dropdown-divider"></div>
										</c:if>
									</c:forEach>
								</div>
								<div style="margin-top: 10px">
									<button type="button" class="dropdown-item"
										onclick="verModalDetallePedido();">IR AL CARRITO</button>
								</div>
							</c:if>
						</div></li>
				</c:if>
				<li class="nav-item dropdown"><a class="nav-link"
					href="javascript:;" id="navbarDropdownProfile"
					data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						<i class="material-icons">person</i>
						<p class="d-lg-none d-md-block">Cuenta</p>
				</a>
					<div class="dropdown-menu dropdown-menu-right"
						aria-labelledby="navbarDropdownProfile">
						<c:if test="${objCargo != null}">
							<c:if test="${objCargo == 'Cliente'}">
								<a class="dropdown-item" href="datosClientes">Perfil</a>
							</c:if>
							<c:if test="${objCargo != 'Cliente'}">
								<a class="dropdown-item" href="#">Perfil</a>
							</c:if>
							<a class="dropdown-item" href="#">Configuración</a>
							<div class="dropdown-divider"></div>
							<a class="dropdown-item" href="salir">Salir</a>
						</c:if>
						<c:if test="${objCargo == null}">
							<a class="dropdown-item" href="login">Ingresar</a>
						</c:if>
					</div></li>
			</ul>
		</div>
	</div>
</nav>

<div class="modal fade" id="idModalDetallePedido" data-backdrop="static"
	tabindex="-1" role="dialog">
	<div class="modal-dialog" style="width: 80%;">
		<!-- Modal content-->
		<div class="modal-content">
			<div class="card">
				<div class="card-header card-header-primary">
					<h3 class="card-title">Detalle Pedido</h3>
				</div>
				<div class="card-body" style="padding: 20px 18px;">
					<div class="row">
						<div class="col-md-9" id="id_modalDetallePedido">
							<c:forEach var="x" items="${objListaProductosEntidad}">
								<div class="row">
									<div class="col-md-2">
										<img src="images/productos/${x.imagen1}" alt="img"
											style="width: 115px; height: 150px">
									</div>
									<div class="col-md-10">
										<div class="row">
											<div class="col-md-12">
												<div class="row">
													<div class="col-md-3 pull-right">
														<div class="caja">
															<select id="id_cantidadProducto${x.idProducto}"
																class="estilo-select"
																onchange="agregarQuitarCantidad('${x.idProducto}');">
																<option value="1">1</option>
																<option value="2">2</option>
																<option value="3">3</option>
																<option value="4">4</option>
															</select>
														</div>
													</div>
												</div>
											</div>
											<div class="col-md-12">
												<ul class="info" style="margin: 0;">
													<li style="font-size: 11px; height: auto; width: 100%;">${x.nombre}</li>
													<li style="font-size: 11px; height: auto; width: 100%;">${x.descripcion}</li>
													<li style="font-size: 11px; height: auto; width: 100%;">${x.descripcionLarga}</li>
													<li style="font-size: 11px;">S/ ${x.precio}</li>
												</ul>
											</div>
											<div class="col-md-12">
												<button type="button"
													onclick="eliminarProducto('${x.idProducto}');"
													class="btn btn-primary pull-right">Eliminar</button>
											</div>
										</div>
									</div>
								</div>
								<c:if test="${objUltimoProducto != x.idProducto}">
									<div class="dropdown-divider"></div>
								</c:if>
							</c:forEach>
						</div>
						<div class="col-md-3">
							<form action="agregarBoleta" id="form_boletaCompra"
								accept-charset="UTF-8">
								<div class="row">
									<input id="id_montoBoleta" hidden="hidden" class="form-control"
										type="text" name="monto">
								</div>
								<div class="cart-grid" id="cart-8"
									style="width: 100%; margin: 0;">
									<h4>RESUMEN DE PEDIDO</h4>
									<div class="dropdown-divider"></div>
									<h5 id="totalPrecio"></h5>
									<div class="dropdown-divider"></div>
									<h5 id="fechaDetallePedido"></h5>
									<div class="snipcart-details">
										<button id="id_btnRealizarCompra" type="submit"
											class="button w3l-cart" data-id="cart-8">Realizar
											Compra</button>
									</div>
								</div>
							</form>
						</div>
					</div>
					<div class="row">
						<div class="col-md-12">
							<button type="button" onclick="cerrarModalDetallePedido();"
								class="btn btn-primary pull-left">Cancelar</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>


<script type="text/javascript">
	function verModalDetallePedido() {
		$.ajax({
			type : 'POST',
			data : {},
			url : 'detalleBoleta',
			success : function(data) {
				$("#totalPrecio").text("TOTAL : " + data.TOTAL);
				$("#fechaDetallePedido").text("FECHA : " + data.FECHA);
				$("#id_montoBoleta").val(data.TOTAL);
				$("#id_modalDetallePedido").load(" #id_modalDetallePedido");
			},
			error : function() {
			}
		});
		$("#idModalDetallePedido").modal("show");
	}

	function cerrarModalDetallePedido() {
		$("#idModalDetallePedido").modal("hide");
	}

	function agregarQuitarCantidad(idProducto) {
		var cant = $("#id_cantidadProducto" + idProducto).val();
		$.ajax({
			type : 'POST',
			data : {
				'idProducto' : idProducto,
				'cantidad' : cant
			},
			url : 'agregarQuitarCantidad',
			success : function(data) {
				$("#totalPrecio").text("TOTAL : " + data.TOTAL);
				$("#id_montoBoleta").val(data.TOTAL);
			},
			error : function() {
			}
		});
	}

	function eliminarProducto(idProducto) {
		$
				.ajax({
					type : 'POST',
					data : {
						'idProducto' : idProducto,
					},
					url : 'eliminarProductoBoleta',
					success : function(data) {
						$("#id_compras1").load(
								window.location.href + " #id_compras1");
						$("#id_compras2").load(
								window.location.href + " #id_compras2");
						if (data.CANTIDAD == 0) {
							$("#idModalDetallePedido").modal("hide");
						} else {
							$("#totalPrecio").text("TOTAL : " + data.TOTAL);
							$("#id_montoBoleta").val(data.TOTAL);
							$("#id_modalDetallePedido").load(
									" #id_modalDetallePedido");
						}
					},
					error : function() {
					}
				});
	}
</script>