<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html lang="esS">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=0">
<!--===============================================================================================-->
<link rel="icon" type="image/png" href="images/logo.png">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="vendor/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="vendor/iconic/css/material-design-iconic-font.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="vendor/animsition/css/animsition.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css" href="vendor/util.css">
<link rel="stylesheet" type="text/css" href="vendor/main.css">
<!--===============================================================================================-->

<title>LOGIN</title>
</head>
<body>
	<div class="limiter">
		<div class="container-login100"
			style="background-image: url('images/fondoLogin.png');">
			<div class="wrap-login100 p-l-55 p-r-55 p-t-65 p-b-54">
				<form accept-charset="UTF-8" class="login100-form validate-form"
					action="login" method="post" onsubmit="funcionSubmit(event)">
					<span class="login100-form-title p-b-49" style="color: #a470dd">
						<img alt="#" src="images/icono1.png" width="30px" height="30px"
						style="margin-right: 30px;"> Login <img alt="#"
						src="images/icono1.png" width="30px" height="30px"
						style="transform: rotate(75deg); margin-left: 30px;">
					</span>
					<div class="wrap-input100 validate-input m-b-23"
						data-validate="Usuario requerido">
						<span class="label-input100"> Usuario </span> <input
							class="input100" type="text" name="username"
							placeholder="Ingresa tu Usuario" id="id_nombreUsuario"> <span
							class="focus-input100" data-symbol="&#xf206;"></span>
					</div>
					<div class="wrap-input100 validate-input"
						data-validate="Contraseña requerida">
						<span class="label-input100"> Contraseña </span> <input
							class="input100" type="password" name="password"
							placeholder="Ingresa tu Contraseña" id="id_contrasenia">
						<span class="focus-input100" data-symbol="&#xf190;"></span>
					</div>
					<div class="container-login100-form-btn p-t-20">
						<div class="wrap-login100-form-btn">
							<div class="login100-form-bgbtn"></div>
							<button id="id_ingresar" class="login100-form-btn" type="submit">Entrar</button>
						</div>
					</div>
					<div class="container-login100-form-btn p-t-20">
						<div class="wrap-login100-form-btn" style="width: 50%;">
							<div class="login100-form-bgbtn"></div>
							<a href="datosClientes">
								<button id="id_registrar" class="btn login100-form-btn"
									type="button" style="height: 35px;">Registrarme</button>
							</a>
						</div>
					</div>
					<div class="row">
						<div class="flex-col-c p-t-30 pull-left">
							<a href="javascript: history.go(-1)" class="txt2"> REGRESAR </a>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>

	<!--===============================================================================================-->
	<script src="vendor/jquery/jquery-3.2.1.min.js"></script>
	<!--===============================================================================================-->
	<script src="vendor/animsition/js/animsition.min.js"></script>
	<!--===============================================================================================-->
	<script src="vendor/bootstrap/js/popper.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.min.js"></script>
	<!--===============================================================================================-->
	<script src="vendor/main.js"></script>
	<!--===============================================================================================-->
	<script src="js/plugins/sweetalert2.js"></script>
	<!--===============================================================================================-->

	<script type="text/javascript">
		document.getElementById("id_nombreUsuario").focus();

		function funcionSubmit(event) {
			event.preventDefault();
			if ($("#id_nombreUsuario").val() != ''
					&& $("#id_contrasenia").val() != '') {
				$.ajax({
					type : 'POST',
					data : {
						'nom_usuario' : $("#id_nombreUsuario").val(),
						'con_usuario' : $("#id_contrasenia").val()
					},
					url : 'validacionLogin',
					success : function(data) {
						if (data.CONFIRMACION == 'SI') {
							if (data.USUARIO != null) {
								swal("¡Bienvenido!", data.USUARIO, "success");
							}
							setTimeout(function() {
								event.target.submit();
							}, 1000);
						} else {
							swal("¡Error!", data.MENSAJE, "error");
						}
					},
					error : function() {
						swal("¡Error!", "¡Comunicate con el administrador!",
								"error");
					}
				});
			}
		}
	</script>

</body>
</html>