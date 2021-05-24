<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html lang="esS">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

<title>Proyecto Integrador</title>

<script type="text/javascript" src="js/core/jquery.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/bootstrapValidator.js"></script>

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
							<div class="col-md-12">
								<div class="card">
									<div class="card-header card-header-primary">
										<h3 class="card-title">
											<i class="material-icons">leaderboard</i> Transacciones
										</h3>
									</div>
									<div class="card-body">
										<div class="row">
											<div class="col-md-12">
												<div class="card" style="margin-top: 20px;">
													<div
														class="card-header card-header-tabs card-header-primary">
														<div class="nav-tabs-navigation">
															<div class="nav-tabs-wrapper">
																<ul class="nav nav-tabs" data-tabs="tabs">
																	<li class="nav-item"><a class="nav-link active"
																		href="#productos" data-toggle="tab"> <i
																			class="material-icons">inventory_2</i> Productos
																			<div class="ripple-container"></div>
																	</a></li>
																	<li class="nav-item"><a class="nav-link"
																		href="#servicios" data-toggle="tab"> <i
																			class="material-icons">medical_services</i> Servicios
																			<div class="ripple-container"></div>
																	</a></li>
																</ul>
															</div>
														</div>
													</div>
													<div class="card-body">
														<div class="tab-content">
															<div class="tab-pane active" id="productos"></div>
															<div class="tab-pane" id="servicios"></div>
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
			</div>
		</div>
	</c:if>

	<!-- Restricción de Acceso -->
	<c:if test="${objCargo != 'Cliente'}">
		<div class="container-login100"
			style="background-image: url('images/error403.jpg');"></div>
	</c:if>

	<script type="text/javascript">
		$('#id_menuTrackingClientes').addClass('active');
	</script>

</body>
</html>