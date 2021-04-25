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
					<div class="card">
						<div class="card-header card-header-primary">
							<h3 class="card-title">
								<i class="material-icons">medical_services</i> Servicios
							</h3>
						</div>
						<div class="choose_bg">
							<div class="white_bg">
								<div class="row">
									<c:forEach var="servicio" items="${servicios}">
										<div class="col-xl-3 col-lg-3 col-md-6 col-sm-12">
											<div class="for_box">
												<form accept-charset="UTF-8" action="detalleServicios"
													method="post">
													<input hidden="hidden" class="form-control" type="text"
														name="idServicio" value="${servicio.idServicio}">
													<input hidden="hidden" class="form-control" type="text"
														name="dia" value="${servicio.dia}"> <i><img
														class="servicioImagen"
														src="images/servicios/${servicio.imagen}" /></i>
													<h3>
														<button type="submit"
															style="background: none; border-width: 0; border-color: transparent;">${servicio.nombre}</button>
													</h3>
													<p>${servicio.descripcion}</p>
												</form>
											</div>
										</div>
									</c:forEach>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>

<script type="text/javascript">
	$('#id_menuServicios').addClass('active');
</script>

</html>



