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

<link rel="stylesheet" href="css/estilo1.1.css" />
<link rel="stylesheet" href="css/bootstrapValidator.css" />

</head>
<body class="">
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
										<i class="material-icons">inventory_2</i> Productos
									</h3>
								</div>
								<div class="card-body">
									<div class="row">
										<div class="col-md-9">
											<div class="form-group" style="padding-left: 10px;">
												<label class="bmd-label-floating">Nombre del
													Art�culo</label> <input type="text" class="form-control"
													id="id_nombreArticulo">
											</div>
										</div>
										<div class="col-md-1 offset-1">
											<button onclick="buscarProductos();" type="button"
												id="id_btnBuscar" class="btn btn-primary pull-right">Buscar</button>
										</div>
									</div>
									<div class="row">
										<div class="col-md-12" id="id_listadoProductos">
											<c:forEach var="producto" items="${productos}">
												<form accept-charset="UTF-8">
													<div class="cart-grid" id="cart-8">
														<div class="img"
															onmouseover="cambiarImagen('${producto.idProducto}');">
															<img
																class="slideProducto fadeProducto imagenesProducto${producto.idProducto}"
																src="images/productos/${producto.imagen1}" alt="">
															<img
																class="slideProducto fadeProducto imagenesProducto${producto.idProducto}"
																src="images/productos/${producto.imagen2}" alt="">
															<img
																class="slideProducto fadeProducto imagenesProducto${producto.idProducto}"
																src="images/productos/${producto.imagen3}" alt="">
														</div>
														<ul class="info">
															<li style="font-size: 14px; height: 100px; width: 100%;">${producto.nombre}</li>
															<li>S/ ${producto.precio}</li>
														</ul>
														<div class="snipcart-details">
															<button type="button"
																onclick="agregarProductos('${producto.idProducto}');"
																class="button w3l-cart" data-id="cart-8">A�adir</button>
														</div>
													</div>
												</form>
											</c:forEach>
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

	<script type="text/javascript" charset="utf-8">
		function cambiarImagen(idProducto) {
			var slides = document.getElementsByClassName('imagenesProducto'
					+ idProducto);
			var slide = 0;

			setTimeout(function() {
				for (var i = 0; i < slides.length; i++) {
					slides[i].style.display = "none";
				}
				slide++;
				if (slide > slides.length - 1) {
					slide = 0;
				}
				slides[slide].style.display = "block";
			}, 1000);
		}
	</script>


	<script type="text/javascript">
		$('#id_menuProductos').addClass("active");

		$("#id_nombreArticulo").on("keypress", function(event) {
			if (event.which == 13) {
				buscarProductos();
			}
		});

		function buscarProductos() {
			var nom = $("#id_nombreArticulo").val();
			$("#id_listadoProductos").html("");

			$
					.getJSON(
							'listadoProductoNombre',
							{
								"nombreArticulo" : nom
							},
							function(data) {
								$
										.each(
												data,
												function(index, item) {
													$("#id_listadoProductos")
															.append(
																	"<form accept-charset='UTF-8'>"
																			+ "<div class='cart-grid' id='cart-8'>"
																			+ "<div class='img'>"
																			+ "<img src='images/productos/"
																			+ item.imagen1
																			+ "' alt='img'>"
																			+ "</div>"
																			+ "<ul class='info'>"
																			+ "<li style='font-size: 14px; height: 100px; width: 100%;'>"
																			+ item.nombre
																			+ "</li>"
																			+ "<li>S/"
																			+ item.precio
																			+ "</li>"
																			+ "</ul>"
																			+ "<div class='snipcart-details'>"
																			+ "<button type='button' onclick=\"agregarProductos('"
																			+ item.idProducto
																			+ "');\" class='button w3l-cart' data-id='cart-8'> A�adir </button>"
																			+ "</div>"
																			+ "</div>"
																			+ "</form>");
												});
							});
		}
	</script>



</body>
</html>



