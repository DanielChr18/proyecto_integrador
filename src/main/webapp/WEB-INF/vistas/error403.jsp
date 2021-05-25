<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html lang="esS">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=0">
<link rel="stylesheet" type="text/css" href="vendor/main.css">
<title>Error 404</title>
</head>
<body>
	<div class="container-login100"
		style="background-image: url('images/error403.jpg');">
		<c:if test="${objCargo == null}">
				<a href="listaProductos" class="btn btn-primary"> Ir a Productos
				</a>
		</c:if>
		<c:if test="${objCargo != null}">
			<c:if test="${objCargo == 'Cliente'}">
				<a href="listaProductos" class="btn btn-primary"> Ir a Productos
				</a>
			</c:if>
			<c:if test="${objCargo == 'Personal de Ventas'}">
				<a href="crudProductos" class="btn btn-primary"> Ir a
					Mantenimiento Productos </a>
			</c:if>
			<c:if test="${objCargo == 'Veterinario'}">
				<a href="javascript: history.go(-1)" class="btn btn-primary">
					REGRESAR </a>
			</c:if>
		</c:if>
	</div>
</body>
</html>