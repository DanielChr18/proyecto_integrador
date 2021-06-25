<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html lang="esS">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

<link rel="icon" type="image/png" href="images/logo.png">
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
						<form accept-charset="UTF-8">
					<div class="card">
						<div class="card-header card-header-primary">
							<h3 class="card-title">
								<i class="material-icons">home</i> Nosotros
							</h3>
						</div>
						<div class="card-body">
						<div class="card-header"
													style="border-bottom: #9c27b0 1px solid;">
													<h2 class="card-title" style="color: #9c27b0">
														<strong>¿Quiénes somos?</strong>
													</h2>
												</div>
						<div class="card-body" style="padding: 20px 10px;">
													<div class="row">
														<div class="col-md-7">
															<div class="form-group" >
																<h3 class="card-title">
																	<strong>La Veterinaria ZOOTOPIA es una empresa dedicada al cuidado de las mascotas, que lleva en el mercado desde el año 2021, trabajando en el bienestar de cada mascota. Desde entonces, sus primordiales objetivos estuvieron encaminados a mejorar en todos sus servicios, y muchos de estos objetivos se han logrado, dando como resultado el poder ofrecer a todos nuestros clientes un servicio integral atendidos por profesionales de altísima calidad, todo esto con el fin de tratar nuestros pacientes como seres que merecen la mejor atención y especial cuidado.</strong>
																</h3>
															</div>
														</div>
														<div class="col-md-5" >
															<img src="images/quienes.jpg" 
																width="100%" height="300px" style="border: 2px solid;border-color:#9c27b0"  />
														</div>
													</div>
										</div>
										
										<div class="card-header"
													style="border-bottom: #9c27b0 1px solid;">
													<h2 class="card-title" style="color: #9c27b0;text-align: right">
														<strong>Misión</strong>
													</h2>
												</div>
						<div class="card-body" style="padding: 20px 10px;">
													<div class="row">
													<div class="col-md-6">
															<img src="images/mision.jpg" 
																width="100%" height="300px"  style="border: 2px solid;border-color:#9c27b0"/>
														</div>
													
														<div class="col-md-6">
															<div class="form-group" >
																<h3 class="card-title">
																	<strong>La veterinaria ZOOTOPIA tiene como misión ofrecer bienestar a cada una de nuestras mascotas, que sus familias entiendan los deberes y los derechos que tienen las mascotas desde el instante que entran a formar parte de sus vidas. Nuestro grupo de trabajo comparte valores y principios éticos de respeto, responsabilidad y compromiso, superándolas expectativas de nuestros clientes y entregando calidad y satisfacción en nuestros servicios.</strong>
																</h3>
															</div>
														</div>
														
													</div>
										</div>	
										
										<div class="card-header"
													style="border-bottom: #9c27b0 1px solid;">
													<h2 class="card-title" style="color: #9c27b0">
														<strong>Visión</strong>
													</h2>
												</div>
						<div class="card-body" style="padding: 20px 10px;">
													<div class="row">
														<div class="col-md-6">
															<div class="form-group" >
																<h3 class="card-title">
																	<strong>La veterinaria ZOOTOPIA tiene como visión ser una  de las veterinarias líderes en prestación de servicios médicos veterinarios de la mejor calidad y profesionalismo, con énfasis en animales de compañía. Nuestro compromiso social es mejorar la calidad de vida de las familias a través del cuidado de la salud de nuestros pacientes contando con excelente tecnología, un equipo médico altamente calificado con educación y capacidad continua.</strong>
																</h3>
															</div>
														</div>
														<div class="col-md-6">
															<img src="images/vision.jpg"
																width="100%" height="300px" style="border: 2px solid;border-color:#9c27b0" />
														</div>
													</div>
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

	<script type="text/javascript">
		$('#id_menuNosotros').addClass('active');
	</script>
</body>
</html>



