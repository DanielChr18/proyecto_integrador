<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<nav
	class="navbar navbar-expand-lg navbar-transparent navbar-absolute fixed-top" id="id_compras1" >
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
									<a class="dropdown-item" href="#"> IR AL CARRITO </a>
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
							<a class="dropdown-item" href="salir">Log out</a>
						</c:if>
						<c:if test="${objCargo == null}">
							<a class="dropdown-item" href="login">Login</a>
						</c:if>
					</div></li>
			</ul>
		</div>
	</div>
</nav>