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
							<div class="row">
						<div class="col-md-12">
							<button type="button" onclick="cerrarModalDetallePedido();"
								class="btn btn-primary pull-left">Cancelar</button>
						</div>
					</div>
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
							<div class="dropdown-divider"></div>

							<form action="agregarBoleta" id="form_boletaCompra"
								accept-charset="UTF-8">
								<div class="row">
									<input id="id_montoBoleta" hidden="hidden" class="form-control"
										type="text" name="monto">
								</div>
								<div class="cart-grid" id="cart-8"
									style="width: 100%; margin: 0;">
									<h4>METODO DE PAGO</h4>
									<div class="dropdown-divider"></div>
									<div class="col2">
										<label>Numero de Tarjeta</label> <input class="number" type="text"
											ng-model="ncard" maxlength="19"
											onkeypress='return event.charCode >= 48 && event.charCode <= 57' />
										<label>Fecha de Vencimiento</label> <input
											class="expire" type="text" placeholder="MM / YYYY" /> <label>Numero de Seguridad</label> 
										<input class="ccv" type="text" placeholder="CVC"
											maxlength="3"
											onkeypress='return event.charCode >= 48 && event.charCode <= 57' />
									</div>
									<div class="dropdown-divider"></div>
									<div class="snipcart-details">
										<button id="id_btnRealizarCompra" type="submit"
											class="button w3l-cart" data-id="cart-8">ACEPTAR</button>
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

<script type="text/javascript">
	$(function() {

		var cards = [
				{
					nome : "mastercard",
					colore : "#0061A8",
					src : "https://upload.wikimedia.org/wikipedia/commons/0/04/Mastercard-logo.png"
				},
				{
					nome : "visa",
					colore : "#E2CB38",
					src : "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/Visa_Inc._logo.svg/2000px-Visa_Inc._logo.svg.png"
				},
				{
					nome : "dinersclub",
					colore : "#888",
					src : "http://www.worldsultimatetravels.com/wp-content/uploads/2016/07/Diners-Club-Logo-1920x512.png"
				},
				{
					nome : "americanExpress",
					colore : "#108168",
					src : "https://upload.wikimedia.org/wikipedia/commons/thumb/3/30/American_Express_logo.svg/600px-American_Express_logo.svg.png"
				},
				{
					nome : "discover",
					colore : "#86B8CF",
					src : "https://lendedu.com/wp-content/uploads/2016/03/discover-it-for-students-credit-card.jpg"
				},
				{
					nome : "dankort",
					colore : "#0061A8",
					src : "https://upload.wikimedia.org/wikipedia/commons/5/51/Dankort_logo.png"
				} ];

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
					if (!$(e.target).is(".inputname")
							|| !$(e.target).closest(".inputname").length) {
						$(".fullname").css("color", "var(--text-color)");
					}
				});

		//Card number input
		$(".number")
				.keyup(
						function(event) {
							$(".card_number").text($(this).val());
							number = $(this).val();

							if (parseInt(number.substring(0, 2)) > 50
									&& parseInt(number.substring(0, 2)) < 56) {
								selected_card = 0;
							} else if (parseInt(number.substring(0, 1)) == 4) {
								selected_card = 1;
							} else if (parseInt(number.substring(0, 2)) == 36
									|| parseInt(number.substring(0, 2)) == 38
									|| parseInt(number.substring(0, 2)) == 39) {
								selected_card = 2;
							} else if (parseInt(number.substring(0, 2)) == 34
									|| parseInt(number.substring(0, 2)) == 37) {
								selected_card = 3;
							} else if (parseInt(number.substring(0, 2)) == 65) {
								selected_card = 4;
							} else if (parseInt(number.substring(0, 4)) == 5019) {
								selected_card = 5;
							} else {
								selected_card = -1;
							}

							if (selected_card != -1) {
								html.setAttribute("style", "--card-color: "
										+ cards[selected_card].colore);
								$(".bankid").attr("src",
										cards[selected_card].src).show();
							} else {
								html.setAttribute("style",
										"--card-color: #cecece");
								$(".bankid").attr("src", "").hide();
							}

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
						})

		//Name Input
		$(".inputname").keyup(function() {
			$(".fullname").text($(this).val());
			if ($(".inputname").val().length === 0) {
				$(".fullname").text("FULL NAME");
			}
			return event.charCode;
		}).focus(function() {
			$(".fullname").css("color", "white");
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







