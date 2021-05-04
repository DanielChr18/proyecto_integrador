<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<nav
	class="navbar navbar-expand-lg navbar-transparent navbar-absolute fixed-top ">
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
				<li class="nav-item dropdown"><a class="nav-link"
					href="javascript:;" id="navbarDropdownProfile"
					data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						<i class="material-icons">person</i>
						<p class="d-lg-none d-md-block">Cuenta</p>
				</a>
					<div class="dropdown-menu dropdown-menu-right"
						aria-labelledby="navbarDropdownProfile">
						<c:if test="${objCargo != null}">
							<c:if test="${objCargo == 'Cilente'}">
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