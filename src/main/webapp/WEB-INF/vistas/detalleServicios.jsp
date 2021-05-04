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
<script type="text/javascript" src="datepicker/jquery-ui.js"></script>
<script type="text/javascript"
	src="datepicker/jquery.ui.datepicker-es.js"></script>

<link rel="stylesheet" href="datepicker/jquery-ui.css" />
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
									<h3 class="card-title">Detalles de Servicio</h3>
								</div>
								<div class="card-body">
									<form accept-charset="UTF-8">
										<div class="row">
											<div class="col-md-12">
												<div class="row" hidden="hidden">
													<input class="form-control" type="text" id="id_idServicio"
														name="idServicio" value="${servicio.idServicio}">
													<input class="form-control" type="text" id="id_diaServicio"
														name="dia" value="${objNumeroDia}">
												</div>
												<div class="card-header"
													style="border-bottom: #9c27b0 1px solid;">
													<h2 class="card-title" style="color: #9c27b0">
														<strong>${servicio.nombre}</strong>
													</h2>
												</div>
												<div class="card-body" style="padding: 20px 10px;">
													<div class="row">
														<div class="col-md-8">
															<div class="form-group" id="div_stockModificar">
																<h5 class="card-title">
																	<strong>${servicio.descripcion}</strong>
																</h5>
															</div>
														</div>
														<div class="col-md-4">
															<img src="images/servicios/${servicio.imagen}"
																width="300px" height="300px" />
														</div>
													</div>
													<div class="row">
														<div class="col-md-12">
															<div class="row" style="padding-left: 15px;">
																<div style="width: 240px; height: auto;">
																	<div class="form-group" id="div_nombreModificar">
																		<label class="bmd-label">Separa tu Cita : </label> <br>
																		<input class="form-control" type="text"
																			id="id_fechaCita" name="fechaCita"
																			readonly="readonly">
																	</div>
																	<div id="datepicker"></div>
																</div>
																<div id="id_listadoHorarios"
																	style="width: 100px; height: auto; padding-top: 75px;">
																</div>
															</div>
														</div>
													</div>
													<div class="row">
														<div class="col-md-12">
															<button type="button" onclick="history.go(-1)"
																class="btn btn-primary pull-left">Regresar</button>
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
		</div>
	</div>


	<script type="text/javascript">
		$('#id_menuServicios').addClass('active');
		$(function() {
			var ayuda = $("#id_diaServicio").val();
			var id = $("#id_idServicio").val();
			$("#datepicker")
					.datepicker(
							{
								minDate : 0,
								maxDate : "+1M",
								dateFormat : 'dd/mm/yy',
								dayNamesMin : [ "Do", "Lu", "Ma", "Mi", "Ju",
										"Vi", "Sa" ],
								dayNamesShort : [ "Dom", "Lun", "Mar", "Mie",
										"Jue", "Vie", "Sab" ],
								monthNames : [ "Enero", "Febrero", "Marzo",
										"Abril", "Mayo", "Junio", "Julio",
										"Agosto", "Septiembre", "Octubre",
										"Noviembre", "Diciembre" ],
								monthNamesShort : [ "Ene", "Feb", "Mar", "Abr",
										"May", "Jun", "Jul", "Ago", "Sep",
										"Oct", "Nov", "Dic" ],
								beforeShowDay : function(day) {
									var day = day.getDay();
									if (day == ayuda) {
										return [ true, "someothercssclass" ]
									} else {
										return [ false, "somecssclass" ]
									}
								},
								onSelect : function(selectedDate) {
									$("#id_fechaCita").val(selectedDate);
									$("#id_listadoHorarios div").remove();
									$
											.getJSON(
													'fechas',
													{
														"fecha" : selectedDate,
														"idServicio" : id
													},
													function(data) {
														$
																.each(
																		data,
																		function(
																				index,
																				item) {
																			if (item.estado == 'libre') {
																				$(
																						"#id_listadoHorarios")
																						.append(
																								"<div class='col-md-12'>"
																										+ "<div class='form-group'>"
																										+ "<input class='btn btn-primary' type='button'"
																							+ "style='font-size:14px;' value='"
																							+ item.idHorariosServicios.horario
																							+ "' onclick=''>"
																										+ "</div></div>");
																			} else {
																				$(
																						"#id_listadoHorarios")
																						.append(
																								"<div class='col-md-12'>"
																										+ "<div class='form-group'>"
																										+ "<input class='btn btn-primary' type='button'"
																				+ "style='font-size:14px;' disabled='diabled' value='"
																				+ item.idHorariosServicios.horario
																				+ "' onclick=''>"
																										+ "</div></div>");
																			}
																		});
													});
								}
							});
		});
	</script>

</body>

</html>




